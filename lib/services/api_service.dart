import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pongas_ativ/models/match_model.dart';
import 'package:pongas_ativ/models/ranking_item.dart';

class ApiService {
  // Chave pública de teste da TheSportsDB (Grátis)
  static const String _apiKey = '3';
  static const String _baseUrl =
      'https://www.thesportsdb.com/api/v1/json/$_apiKey';

  // ID da Liga de Tênis de Mesa
  // 4443 é frequentemente usado para 'Olympic Games Table Tennis' ou similar na base deles.
  // Se não retornar dados, podemos tentar outras ligas ou buscar por 'Table Tennis' generico.
  static const String _leagueId = '4443';

  // --- Buscar Últimos Resultados (Partidas Profissionais) ---
  Future<List<ProfessionalMatch>> fetchProfessionalMatches() async {
    // Endpoint: eventspastleague.php?id={id} -> Retorna os últimos 15 eventos finalizados
    final uri = Uri.parse('$_baseUrl/eventspastleague.php?id=$_leagueId');

    print('Buscando partidas profissionais em: $uri');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // A API retorna uma lista dentro da chave "events"
        if (data['events'] != null) {
          final List<dynamic> eventsList = data['events'];

          // Mapeia cada item do JSON para nosso modelo ProfessionalMatch
          return eventsList
              .map((json) => ProfessionalMatch.fromJson(json))
              .toList();
        } else {
          // Se a chave 'events' for null, significa que não achou jogos recentes para essa liga
          print(
            'Nenhum evento encontrado na resposta da API para a liga $_leagueId',
          );
          return [];
        }
      } else {
        throw Exception(
          'Falha ao carregar jogos. Código de Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Erro de conexão com TheSportsDB: $e');
      // Lança a exceção para que a tela possa mostrar uma mensagem de erro ao usuário
      rethrow;
    }
  }

  // --- Buscar Ranking Mundial (Simulado / Mockado) ---
  // A TheSportsDB foca em Ligas e Times, não tem um endpoint direto de "Ranking Mundial de Jogadores" fácil na versão free.
  // Por isso, manteremos o Ranking Mockado para garantir que a aba de Ranking não fique vazia.
  Future<List<RankingItem>> fetchWorldRanking() async {
    await Future.delayed(const Duration(seconds: 1)); // Simula tempo de rede

    final List<Map<String, dynamic>> mockData = [
      {
        'position': 1,
        'name': 'Fan Zhendong (CHN)',
        'rating': 7500,
        'imageUrl':
            'https://www.thesportsdb.com/images/media/player/thumb/4w7c3n1626884638.jpg', // Exemplo de imagem real se houver
      },
      {
        'position': 2,
        'name': 'Wang Chuqin (CHN)',
        'rating': 6800,
        'imageUrl':
            'https://www.thesportsdb.com/images/media/player/thumb/yq0k6f1626884705.jpg',
      },
      {
        'position': 3,
        'name': 'Ma Long (CHN)',
        'rating': 4500,
        'imageUrl':
            'https://www.thesportsdb.com/images/media/player/thumb/u6z89j1626884524.jpg',
      },
      {
        'position': 4,
        'name': 'Hugo Calderano (BRA)',
        'rating': 3900,
        'imageUrl':
            'https://www.thesportsdb.com/images/media/player/thumb/qn6x3z1626884792.jpg',
      },
      {
        'position': 5,
        'name': 'F. Lebrun (FRA)',
        'rating': 3500,
        'imageUrl':
            'https://www.thesportsdb.com/images/media/player/thumb/placeholder.png', // Placeholder se não tiver imagem
      },
    ];

    return mockData.map((json) => RankingItem.fromJson(json)).toList();
  }
}
