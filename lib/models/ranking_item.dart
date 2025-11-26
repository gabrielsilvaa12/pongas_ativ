class RankingItem {
  final int position;
  final String name;
  final int rating;
  final String imageUrl;

  RankingItem({
    required this.position,
    required this.name,
    required this.rating,
    required this.imageUrl,
  });

  // Método de fábrica para criar um objeto RankingItem a partir de um JSON (Map)
  factory RankingItem.fromJson(Map<String, dynamic> json) {
    return RankingItem(
      position: json['position'] as int,
      name: json['name'] as String,
      rating: json['rating'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
