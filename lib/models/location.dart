class Location {
  final String title;
  final String category;
  final String roadAddress;

  Location({
    required this.title,
    required this.category,
    required this.roadAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      title: json['title'],
      category: json['category'],
      roadAddress: json['roadAddress'],
    );
  }
}
