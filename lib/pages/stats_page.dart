// lib/pages/stats_tab_page.dart

import 'package:flutter/material.dart';

// Cores definidas em seus componentes para consistência
const Color _primaryBlue = Color(0xFF0D47A1);
const Color _accentRed = Color(0xFFFF1919);

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Minhas Estatísticas',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: _primaryBlue,
            ),
          ),
          const SizedBox(height: 20),

          // Seção de Métricas Principais (Grid de Cards)
          _buildMetricsGrid(),
          const SizedBox(height: 30),

          // Seção de Gráfico (Placeholder para Futura Implementação de Gráficos)
          const Text(
            'Desempenho Recente (Últimas 10 Partidas)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),

          // Card Placeholder para o Gráfico
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              height: 200,
              alignment: Alignment.center,
              // Aqui futuramente você colocará um widget de gráfico (e.g., charts_flutter ou fl_chart)
              child: const Text(
                'Gráfico de Evolução de Pontuação/Rating',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Seção de Dicas/Metas
          _buildTipCard(
            'Seu Recorde',
            'A maior sequência de vitórias consecutivas é 7.',
            Icons.local_fire_department,
          ),
        ],
      ),
    );
  }

  // Widget para os cartões de métricas principais
  Widget _buildMetricsGrid() {
    return GridView.count(
      shrinkWrap:
          true, // Importante para usar GridView dentro de SingleChildScrollView
      physics:
          const NeverScrollableScrollPhysics(), // Desabilita o scroll do GridView
      crossAxisCount: 2, // 2 colunas
      childAspectRatio: 1.5, // Proporção para deixar os cards mais largos
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: <Widget>[
        _buildMetricCard(
          'Taxa de Vitória',
          '72%',
          _accentRed,
          Icons.emoji_events,
        ),
        _buildMetricCard(
          'Total de Jogos',
          '155',
          _primaryBlue,
          Icons.sports_tennis,
        ),
        _buildMetricCard(
          'Rating Atual',
          '1250 pts',
          _primaryBlue,
          Icons.trending_up,
        ),
        _buildMetricCard(
          'Último Jogo',
          'Vitória 3-0',
          _accentRed,
          Icons.check_circle_outline,
        ),
      ],
    );
  }

  // Componente Card de Métrica
  Widget _buildMetricCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon, color: color, size: 28),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Componente Card de Dica/Meta
  Widget _buildTipCard(String title, String subtitle, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[100],
      child: ListTile(
        leading: Icon(icon, color: Colors.orange, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
