import 'package:flutter/material.dart';
import '../../../../core/widgets/icon_button.dart';
import '../../../../core/widgets/text.dart';
import '../logic/video_player_logic.dart';
import 'video_settings_sheet.dart';

class VideoControls extends StatelessWidget {
  final VideoPlayerLogic logic;

  const VideoControls({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: logic,
      builder: (context, _) {
        return IgnorePointer(
          ignoring: !logic.showControls,
          child: AnimatedOpacity(
            opacity: logic.showControls ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Stack(children: [_buildMainOverlay(context), _buildTopBar(context), _buildBottomControls(context)]),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: logic.isFullScreen ? 20.0 : 12.0, vertical: 10.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black54, Colors.transparent]),
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                text: logic.currentVideo.title,
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CustomIconButton(icon: Icons.settings, size: 22, color: Colors.white, onPressed: () => VideoSettingsSheet.show(context, logic)),
          ],
        ),
      ),
    );
  }

  Widget _buildMainOverlay(BuildContext context) {
    bool isBuffering = logic.controller?.value.isBuffering ?? false;
    return Container(
      color: Colors.black38,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
              icon: Icons.skip_previous_rounded,
              size: 32,
              color: logic.currentIndex > 0 ? Colors.white : Colors.white24,
              onPressed: logic.currentIndex > 0 ? () => logic.changeVideo(logic.currentIndex - 1) : null,
            ),
            const SizedBox(width: 30),
            isBuffering || !logic.isInitialized
                ? const CircularProgressIndicator(color: Colors.red)
                : CustomIconButton(
                    onPressed: logic.togglePlay,
                    animatedIcon: AnimatedIcons.play_pause,
                    progress: logic.playPauseController,
                    size: 40,
                    color: Colors.white,
                    backgroundColor: Colors.black45,
                    boxSize: 65,
                  ),
            const SizedBox(width: 30),
            CustomIconButton(
              icon: Icons.skip_next_rounded,
              size: 32,
              color: logic.currentIndex < logic.playlist.length - 1 ? Colors.white : Colors.white24,
              onPressed: logic.currentIndex < logic.playlist.length - 1 ? () => logic.changeVideo(logic.currentIndex + 1) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: logic.isFullScreen ? 20.0 : 12.0, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Opacity(opacity: 0, child: CustomText(text: "00:00:00", fontSize: 12)),
                    CustomText(
                      text: _formatDuration(
                        logic.isDragging
                            ? Duration(milliseconds: logic.dragValue.toInt())
                            : (logic.controller?.value.position ?? Duration.zero),
                      ),
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(child: _buildInteractiveSlider(context)),
                const SizedBox(width: 10),
                CustomIconButton(
                  onPressed: logic.toggleFullScreen,
                  icon: logic.isFullScreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
                  size: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveSlider(BuildContext context) {
    final double maxDuration = logic.controller?.value.duration.inMilliseconds.toDouble() ?? 1.0;
    final double currentPos = logic.isDragging ? logic.dragValue : (logic.controller?.value.position.inMilliseconds.toDouble() ?? 0.0);

    double bufferedEnd = 0.0;
    if (logic.controller != null && logic.controller!.value.buffered.isNotEmpty) {
      bufferedEnd = logic.controller!.value.buffered.last.end.inMilliseconds.toDouble();
    }

    return IgnorePointer(
      ignoring: !logic.isInitialized,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: LinearProgressIndicator(
              value: maxDuration > 0 ? (bufferedEnd / maxDuration).clamp(0.0, 1.0) : 0,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white24),
              backgroundColor: Colors.white10,
              minHeight: 4,
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4.0,
              trackShape: const FullWidthTrackShape(),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7.0, disabledThumbRadius: 4.0),
              overlayShape: SliderComponentShape.noOverlay,
              activeTrackColor: Colors.red,
              inactiveTrackColor: Colors.transparent,
              thumbColor: Colors.red,
            ),
            child: Slider(
              value: currentPos.clamp(0.0, maxDuration),
              min: 0.0,
              max: maxDuration > 0 ? maxDuration : 1.0,
              onChangeStart: (v) {
                logic.cancelHideTimer();
                logic.isDragging = true;
              },
              onChanged: (v) => logic.dragValue = v,
              onChangeEnd: (v) {
                logic.controller?.seekTo(Duration(milliseconds: v.toInt()));
                logic.isDragging = false;
                logic.startHideTimer();
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }
}

class FullWidthTrackShape extends RectangularSliderTrackShape {
  const FullWidthTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTWH(offset.dx, trackTop, parentBox.size.width, trackHeight);
  }
}
