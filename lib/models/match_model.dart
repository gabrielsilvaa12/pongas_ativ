class ProfessionalMatch {
  final String id;
  final String eventName; // Ex: "Ma Long vs Fan Zhendong"
  final String leagueName; // Ex: "Olympic Games"
  final String date; // Ex: "2024-07-30"
  final String time; // Ex: "14:00:00"
  final String homeScore; // Placar Jogador 1
  final String awayScore; // Placar Jogador 2
  final String status; // Ex: "Match Finished"
  final String thumbUrl; // Imagem do evento/partida

  ProfessionalMatch({
    required this.id,
    required this.eventName,
    required this.leagueName,
    required this.date,
    required this.time,
    required this.homeScore,
    required this.awayScore,
    required this.status,
    required this.thumbUrl,
  });

  factory ProfessionalMatch.fromJson(Map<String, dynamic> json) {
    return ProfessionalMatch(
      id: json['idEvent'] ?? '',
      eventName: json['strEvent'] ?? 'Partida Desconhecida',
      leagueName: json['strLeague'] ?? 'Torneio',
      date: json['dateEvent'] ?? '',
      time: json['strTime'] ?? '',
      homeScore: json['intHomeScore'] ?? '0',
      awayScore: json['intAwayScore'] ?? '0',
      status: json['strStatus'] ?? 'Agendado',
      // TheSportsDB às vezes retorna null para imagem se não tiver
      thumbUrl:
          json['strThumb'] ??
          'https://www.thesportsdb.com/images/media/league/badge/i6o0kh1549879130.png',
    );
  }
}
