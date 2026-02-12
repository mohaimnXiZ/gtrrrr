import 'package:flutter/material.dart';
import '../../../../core/widgets/icon.dart';
import '../../../../core/widgets/icon_button.dart';
import '../../../../core/widgets/text.dart';
import '../logic/video_player_logic.dart';

class VideoSettingsSheet extends StatelessWidget {
  final VideoPlayerLogic logic;

  const VideoSettingsSheet({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return _buildMainSettingsLayout(context);
  }

  static Future<void> show(BuildContext context, VideoPlayerLogic logic) async {
    logic.cancelHideTimer();
    final result = await _openSheet(context, VideoSettingsSheet(logic: logic));

    if (result == 'speed') {
      final back = await _openSheet(context, _buildSpeedLayout(context, logic));
      if (back == 'back') show(context, logic);
    } else if (result == 'quality') {
      final back = await _openSheet(context, _buildQualityLayout(context, logic));
      if (back == 'back') show(context, logic);
    } else if (result == 'captions') {
      final back = await _openSheet(context, _buildCaptionsToggleLayout(context, logic));
      if (back == 'back') show(context, logic);
    } else if (result == 'caption_style') {
      final back = await _openSheet(context, _buildCaptionStyleLayout(context, logic));
      if (back == 'back') show(context, logic);
    } else {
      logic.startHideTimer();
    }
  }

  static Future<String?> _openSheet(BuildContext context, Widget content) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF1C1C1C),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => content,
    );
  }

  Widget _buildMainSettingsLayout(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _buildDragHandle(),
        _tile(
          Icons.speed,
          "Playback Speed",
          subtitle: "${logic.controller?.value.playbackSpeed ?? 1.0}x",
          onTap: () => Navigator.pop(context, 'speed'),
        ),
        _tile(Icons.high_quality, "Quality", subtitle: logic.currentQuality, onTap: () => Navigator.pop(context, 'quality')),
        _tile(Icons.subtitles, "Captions", subtitle: logic.captionsEnabled ? "On" : "Off", onTap: () => Navigator.pop(context, 'captions')),
        if (logic.captionsEnabled) _tile(Icons.closed_caption, "Caption Style", onTap: () => Navigator.pop(context, 'caption_style')),
      ],
    );
  }

  static Widget _buildDragHandle() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Center(
          child: Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  static Widget _tile(IconData icon, String title, {String? subtitle, Widget? trailing, VoidCallback? onTap}) => ListTile(
    leading: CustomIcon(icon: icon, color: Colors.white),
    title: CustomText(text: title, color: Colors.white),
    subtitle: subtitle != null ? CustomText(text: subtitle, color: Colors.white54, fontSize: 12) : null,
    trailing: trailing ?? const CustomIcon(icon: Icons.chevron_right, color: Colors.white38, size: 18),
    onTap: onTap,
  );

  static Widget _buildCaptionsToggleLayout(BuildContext context, VideoPlayerLogic logic) {
    return ListenableBuilder(
      listenable: logic,
      builder: (context, _) {
        return ListView(
          shrinkWrap: true,
          children: [
            _buildDragHandle(),
            _subHeader("Captions", context),
            _selectableTile("Off", !logic.captionsEnabled, () {
              logic.updateCaptionsEnabled(false);
            }),
            _selectableTile("On", logic.captionsEnabled, () {
              logic.updateCaptionsEnabled(true);
            }),
          ],
        );
      },
    );
  }

  static Widget _buildCaptionStyleLayout(BuildContext context, VideoPlayerLogic logic) {
    return ListenableBuilder(
      listenable: logic,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildDragHandle(),
              _subHeader("Caption Customization", context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(text: "Font Size", color: Colors.white70),
                    Slider(
                      value: logic.captionFontSize,
                      min: 12,
                      max: 32,
                      activeColor: Colors.red,
                      onChanged: (v) {
                        logic.updateCaptionFontSize(v);
                      },
                    ),
                    const SizedBox(height: 10),
                    const CustomText(text: "Background Color", color: Colors.white70),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _colorDot(Colors.transparent, "None", logic),
                        _colorDot(Colors.black54, "Dim", logic),
                        _colorDot(Colors.black, "Solid", logic),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _colorDot(Color color, String label, VideoPlayerLogic logic) {
    bool isSelected = logic.captionBgColor == color;
    return GestureDetector(
      onTap: () {
        logic.updateCaptionBgColor(color);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: color == Colors.transparent ? Colors.white10 : color,
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? Colors.red : Colors.white24, width: 2),
              ),
              child: color == Colors.transparent ? const Icon(Icons.close, size: 14, color: Colors.white) : null,
            ),
            const SizedBox(height: 4),
            CustomText(text: label, color: isSelected ? Colors.red : Colors.white38, fontSize: 10),
          ],
        ),
      ),
    );
  }

  static Widget _buildSpeedLayout(BuildContext context, VideoPlayerLogic logic) {
    final speeds = ["0.5x", "0.75x", "1.0x", "1.25x", "1.5x", "2.0x"];
    return ListenableBuilder(
      listenable: logic,
      builder: (context, _) {
        return ListView(
          shrinkWrap: true,
          children: [
            _buildDragHandle(),
            _subHeader("Playback Speed", context),
            ...speeds.map(
              (s) => _selectableTile(s, (logic.controller?.value.playbackSpeed ?? 1.0) == double.parse(s.replaceAll('x', '')), () {
                double val = double.parse(s.replaceAll('x', ''));
                logic.setPlaybackSpeed(val);
              }),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildQualityLayout(BuildContext context, VideoPlayerLogic logic) {
    // Current video qualities available
    final qualities = logic.currentVideo.sources.keys.toList();
    return ListenableBuilder(
      listenable: logic,
      builder: (context, _) {
        return ListView(
          shrinkWrap: true,
          children: [
            _buildDragHandle(),
            _subHeader("Video Quality", context),
            ...qualities.map(
              (q) => _selectableTile(q, logic.currentQuality == q, () {
                Navigator.pop(context);
                logic.changeQuality(q);
              }),
            ),
          ],
        );
      },
    );
  }

  static Widget _selectableTile(String title, bool isSelected, VoidCallback onTap) {
    return ListTile(
      title: CustomText(text: title, color: Colors.white),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.red, size: 20) : null,
      onTap: onTap,
    );
  }

  static Widget _subHeader(String title, BuildContext context) => ListTile(
    leading: CustomIconButton(icon: Icons.arrow_back, size: 20, color: Colors.white, onPressed: () => Navigator.pop(context, 'back')),
    title: CustomText(text: title, color: Colors.white, fontWeight: FontWeight.bold),
  );
}
