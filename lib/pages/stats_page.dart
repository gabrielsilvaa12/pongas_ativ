import 'package:flutter/material.dart';
import 'package:pongas_ativ/models/match_model.dart';
import 'package:pongas_ativ/services/api_service.dart';

// Cores Oficiais (Estilo WTT - Preto e Dourado/Vermelho ou Azul)
const Color _wttBlack = Color(0xFF121212);
const Color _wttCardBg = Color(0xFF1E1E1E);
const Color _accentGold = Color(0xFFFFD700);
// const Color _accentBlue = Color(0xFF0D47A1); // Opcional

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final ApiService _apiService = ApiService();
  late Future<List<ProfessionalMatch>> _matchesFuture;

  @override
  void initState() {
    super.initState();
    // Inicia a busca assim que a tela carrega
    _matchesFuture = _apiService.fetchProfessionalMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _wttBlack, // Fundo escuro profissional
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho da página
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: Text(
              'Resultados Recentes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto', // Fonte limpa
              ),
            ),
          ),

          // Lista de Jogos (FutureBuilder)
          Expanded(
            child: FutureBuilder<List<ProfessionalMatch>>(
              future: _matchesFuture,
              builder: (context, snapshot) {
                // 1. Carregando
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: _accentGold),
                  );
                }
                // 2. Erro
                else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                          size: 40,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Erro ao carregar jogos:\n${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _matchesFuture = _apiService
                                  .fetchProfessionalMatches();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accentGold,
                          ),
                          child: const Text(
                            'Tentar Novamente',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                // 3. Sem Dados
                else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum jogo encontrado recentemente.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  );
                }

                // 4. Sucesso -> Lista
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final match = snapshot.data![index];
                    return _buildMatchCard(match);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget para desenhar cada cartão de partida
  Widget _buildMatchCard(ProfessionalMatch match) {
    // Define a cor do status dinamicamente
    Color statusColor;
    if (match.status.toLowerCase().contains('live') ||
        match.status.contains('Ao Vivo')) {
      statusColor = Colors.redAccent; // Vermelho para Ao Vivo
    } else if (match.status.toLowerCase().contains('finished') ||
        match.status.contains('Finalizado')) {
      statusColor = Colors.grey; // Cinza para finalizado
    } else {
      statusColor = _accentGold; // Dourado para agendado
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _wttCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
        // Adiciona a imagem de fundo (thumb) se disponível
        image: match.thumbUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(match.thumbUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(
                    0.85,
                  ), // Escurece bastante a imagem para ler o texto
                  BlendMode.darken,
                ),
              )
            : null,
      ),
      child: Column(
        children: [
          // --- Topo do Card: Liga e Status ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    match.leagueName.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: statusColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    match.status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- Centro do Card: Placar e Jogadores ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Evento/Jogo
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        match.eventName, // Ex: "Ma Long vs Fan Zhendong"
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Placar em destaque
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: _accentGold.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          '${match.homeScore} - ${match.awayScore}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                      // Data
                      Text(
                        match.date,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
