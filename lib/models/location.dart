class Location {
  final String title;
  final String category;
  final String roadAddress;
  final double mapx;
  final double mapy;

  Location({
    required this.title,
    required this.category,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      title: json['title'],
      category: json['category'],
      roadAddress: json['roadAddress'],
      mapx: double.parse(json['mapx']),
      mapy: double.parse(json['mapy']),
    );
  }
}
