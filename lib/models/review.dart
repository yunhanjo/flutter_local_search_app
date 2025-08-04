class Review {
  final String id;
  final String content;
  final double mapX;
  final double mapY;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.content,
    required this.mapX,
    required this.mapY,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'mapX': mapX,
    'mapY': mapY,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json['id'],
    content: json['content'],
    mapX: json['mapX'],
    mapY: json['mapY'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}
