import 'dart:async';
import 'package:pongas_ativ/models/ranking_item.dart';

class ApiService {
  Future<List<RankingItem>> fetchRanking() async {
    await Future.delayed(const Duration(seconds: 2));

    final List<Map<String, dynamic>> mockData = [
      {
        'position': 1,
        'name': 'Pedro Henrique',
        'rating': 1500,
        'imageUrl': 'https://i.pravatar.cc/150?img=1',
      },
      {
        'position': 2,
        'name': 'Isabela Santos',
        'rating': 1450,
        'imageUrl': 'https://i.pravatar.cc/150?img=2',
      },
      {
        'position': 3,
        'name': 'Lucas Fernandes',
        'rating': 1380,
        'imageUrl': 'https://i.pravatar.cc/150?img=3',
      },
      {
        'position': 4,
        'name': 'Ana Clara',
        'rating': 1300,
        'imageUrl': 'https://i.pravatar.cc/150?img=4',
      },
      {
        'position': 5,
        'name': 'Gabriel Silva',
        'rating': 1250,
        'imageUrl': 'https://i.pravatar.cc/150?img=5',
      },
    ];

    return mockData.map((json) => RankingItem.fromJson(json)).toList();
  }
}
