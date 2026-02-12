import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../../core/models/video_model.dart';

class VideoPlayerLogic extends ChangeNotifier {
  final List<VideoModel> playlist;
  int _currentIndex = 0;
  String _currentQuality;

  VideoPlayerController? _controller;
  late AnimationController playPauseController;

  bool _isInitialized = false;
  bool _isPlayingIntent = true;
  bool _showControls = true;
  bool _isDragging = false;
  double _dragValue = 0.0;
  bool _isFullScreen = false;
  double _dragOffset = 0.0;

  // Caption Settings
  bool _captionsEnabled = false;
  double _captionFontSize = 16.0;
  Color _captionBgColor = Colors.black54;

  Timer? _hideTimer;
  Completer<void>? _initCompleter;

  final TickerProvider vsync;

  VideoPlayerLogic({required this.playlist, required this.vsync, String initialQuality = "1080p"}) : _currentQuality = initialQuality {
    playPauseController = AnimationController(vsync: vsync, duration: const Duration(milliseconds: 200));
    _initializeVideo();
  }

  // Getters
  VideoPlayerController? get controller => _controller;

  int get currentIndex => _currentIndex;

  String get currentQuality => _currentQuality;

  bool get isInitialized => _isInitialized;

  bool get showControls => _showControls;

  bool get isDragging => _isDragging;

  double get dragValue => _dragValue;

  bool get isFullScreen => _isFullScreen;

  double get dragOffset => _dragOffset;

  bool get captionsEnabled => _captionsEnabled;

  double get captionFontSize => _captionFontSize;

  Color get captionBgColor => _captionBgColor;

  VideoModel get currentVideo => playlist[_currentIndex];

  set isDragging(bool value) {
    _isDragging = value;
    notifyListeners();
  }

  set dragValue(double value) {
    _dragValue = value;
    notifyListeners();
  }

  set dragOffset(double value) {
    _dragOffset = value;
    notifyListeners();
  }

  void toggleOverlay() {
    _showControls = !_showControls;
    if (_showControls) startHideTimer();
    notifyListeners();
  }

  void startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (_controller != null && _controller!.value.isPlaying && !_isDragging) {
        _showControls = false;
        notifyListeners();
      }
    });
  }

  void cancelHideTimer() => _hideTimer?.cancel();

  Future<void> _initializeVideo({Duration? seekTo}) async {
    _initCompleter?.complete();
    final currentInitCompleter = Completer<void>();
    _initCompleter = currentInitCompleter;

    final bool wasPlaying = _controller?.value.isPlaying ?? _isPlayingIntent;

    _isInitialized = false;
    notifyListeners();

    if (_controller != null) {
      _controller!.removeListener(_videoListener);
      final oldController = _controller;
      _controller = null;
      await oldController!.dispose();
    }

    if (currentInitCompleter != _initCompleter) return;

    final String? url = currentVideo.sources[_currentQuality];
    if (url == null) return;

    final newController = VideoPlayerController.networkUrl(Uri.parse(url), closedCaptionFile: _loadCaptions());

    try {
      await newController.initialize();

      if (currentInitCompleter != _initCompleter) {
        await newController.dispose();
        return;
      }

      _controller = newController;
      _controller!.addListener(_videoListener);

      if (seekTo != null) {
        await _controller!.seekTo(seekTo);
      }

      if (wasPlaying) {
        await _controller!.play();
        playPauseController.forward();
      } else {
        playPauseController.reverse();
      }

      _isInitialized = true;
      notifyListeners();
      startHideTimer();
    } catch (e) {
      debugPrint("Video Error: $e");
    }
  }

  Future<ClosedCaptionFile> _loadCaptions() async {
    // This is hardcoded to bunny.vtt in the original code,
    // but we can adapt it to use currentVideo.captionUrl if needed.
    try {
      // For now keeping original logic
      final String data = await rootBundle.loadString('assets/captions/bunny.vtt');
      return WebVTTCaptionFile(data);
    } catch (e) {
      return WebVTTCaptionFile("");
    }
  }

  void _videoListener() {
    if (!_isDragging && _controller != null) {
      notifyListeners();
    }
  }

  void changeQuality(String q) {
    if (_currentQuality == q) return;
    final pos = _controller?.value.position ?? Duration.zero;
    _currentQuality = q;
    _initializeVideo(seekTo: pos);
  }

  void changeVideo(int index) {
    if (index >= 0 && index < playlist.length) {
      _currentIndex = index;
      _initializeVideo();
    }
  }

  void togglePlay() {
    if (!_isInitialized) return;
    if (_controller!.value.isPlaying) {
      _controller?.pause();
      playPauseController.reverse();
      _isPlayingIntent = false;
    } else {
      _controller?.play();
      playPauseController.forward();
      _isPlayingIntent = true;
    }
    startHideTimer();
    notifyListeners();
  }

  void toggleFullScreen() {
    _isFullScreen = !_isFullScreen;
    _dragOffset = 0.0;
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    notifyListeners();
  }

  void updateCaptionsEnabled(bool enabled) {
    _captionsEnabled = enabled;
    notifyListeners();
  }

  void updateCaptionFontSize(double size) {
    _captionFontSize = size;
    notifyListeners();
  }

  void updateCaptionBgColor(Color color) {
    _captionBgColor = color;
    notifyListeners();
  }

  void setPlaybackSpeed(double speed) {
    _controller?.setPlaybackSpeed(speed);
    notifyListeners();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _controller?.dispose();
    playPauseController.dispose();
    super.dispose();
  }
}
