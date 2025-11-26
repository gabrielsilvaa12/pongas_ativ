// lib/pages/ranking_tab_page.dart

import 'package:flutter/material.dart';
import 'package:pongas_ativ/models/ranking_item.dart';
import 'package:pongas_ativ/services/api_service.dart';

const Color _accentRed = Color(0xFFFF1919);
const Color _primaryBlue = Color(0xFF0D47A1);

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<RankingItem>> _rankingFuture;

  @override
  void initState() {
    super.initState();
    _rankingFuture = ApiService().fetchRanking();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            'Ranking Global',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: _primaryBlue,
            ),
          ),
        ),

        Expanded(
          child: FutureBuilder<List<RankingItem>>(
            future: _rankingFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: _accentRed),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao carregar o ranking: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Nenhum jogador encontrado no ranking.'),
                );
              } else {
                return _buildRankingList(snapshot.data!);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRankingList(List<RankingItem> ranking) {
    return ListView.builder(
      itemCount: ranking.length,
      itemBuilder: (context, index) {
        final item = ranking[index];
        return _buildRankingTile(item, index);
      },
    );
  }

  Widget _buildRankingTile(RankingItem item, int index) {
    final isTopThree = index < 3;
    final Color rankColor = isTopThree ? _accentRed : Colors.grey;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      elevation: isTopThree ? 6 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isTopThree
            ? BorderSide(color: _accentRed, width: 2.0)
            : BorderSide.none,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),

        leading: Text(
          '#${item.position}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: rankColor,
          ),
        ),

        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: _primaryBlue,
              backgroundImage: NetworkImage(item.imageUrl), // Usa a URL mockada
            ),
            const SizedBox(width: 15),
            // Nome do Jogador
            Text(
              item.name,
              style: TextStyle(
                fontWeight: isTopThree ? FontWeight.w900 : FontWeight.w600,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${item.rating}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _primaryBlue,
              ),
            ),
            const Text(
              'PTS',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ver detalhes de ${item.name}')),
          );
        },
      ),
    );
  }
}
