class CourseModel {
  final String id;
  final String title;
  final String overview;
  final String description;
  final String coverImage;
  final int numberOfLectures;
  final int totalLength;
  final double price;
  final double discountedPrice;
  final DateTime createdAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.description,
    required this.coverImage,
    required this.numberOfLectures,
    required this.totalLength,
    required this.price,
    required this.discountedPrice,
    required this.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'بدون عنوان',
      overview: json['overview'] ?? '',
      description: json['description'] ?? '',
      coverImage: json['coverImage'] ?? '',
      numberOfLectures: json['numberOfLectures'] ?? 0,
      totalLength: json['totalLength'] ?? 0,
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      discountedPrice: json['discountedPrice'] != null ? (json['discountedPrice'] as num).toDouble() : 0.0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),

      // TODO: IMPLEMENT THE TAGS AND SUBSCRIBEDUSERS
    );
  }
}
