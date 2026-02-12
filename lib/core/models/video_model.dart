class VideoModel {
  final String title;
  final Map<String, String> sources;
  final String? captionUrl;

  VideoModel({
    required this.title,
    required this.sources,
    this.captionUrl,
  });
}
