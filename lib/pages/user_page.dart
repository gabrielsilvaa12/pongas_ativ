// lib/pages/user_tab_page.dart

import 'package:flutter/material.dart';

// Cores definidas em seus componentes para consistência
const Color _primaryBlue = Color(0xFF0D47A1);
const Color _accentRed = Color(0xFFFF1919);

// 1. CORREÇÃO: Renomeado para UserPage para consistência e clareza
class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 1. Informações Básicas do Perfil
          const CircleAvatar(
            radius: 60,
            // Substitua por NetworkImage ou Image.asset real
            backgroundImage: AssetImage('assets/images/placeholder_user.png'),
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 10),

          const Text(
            'Gabriel Silva', // Nome do Usuário
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _primaryBlue,
            ),
          ),
          const Text(
            '@gabrielsilvaa12', // Username
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // 2. Pontuação/Rating Principal
          // 2. CORREÇÃO: Removido o 'const' do Padding/Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: _accentRed.withOpacity(0.9),
              child: Padding(
                // Removido 'const'
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _StatColumn(
                      // Agora chamada do método auxiliar
                      value: '1250',
                      label: 'Rating (Pontos)',
                      color: Colors.white,
                    ),
                    _StatColumn(
                      // Agora chamada do método auxiliar
                      value: '#12',
                      label: 'Ranking Atual',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // 3. Opções de Acesso e Configurações
          // 3. CORREÇÃO: Removido o 'const' do Padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildSettingsItem(
                  // Agora chamada do método auxiliar
                  icon: Icons.edit_note,
                  title: 'Editar Perfil',
                  subtitle: 'Mude nome, username e foto',
                ),
                const Divider(),
                _buildSettingsItem(
                  // Agora chamada do método auxiliar
                  icon: Icons.lock_outline,
                  title: 'Segurança',
                  subtitle: 'Alterar senha e autenticação',
                ),
                const Divider(),
                _buildSettingsItem(
                  // Agora chamada do método auxiliar
                  icon: Icons.notifications_none,
                  title: 'Notificações',
                  subtitle: 'Gerenciar alertas do jogo',
                ),
                const Divider(),
                _buildSettingsItem(
                  // Agora chamada do método auxiliar
                  icon: Icons.logout,
                  title: 'Sair da Conta',
                  subtitle: 'Desconectar-se do aplicativo',
                  color: Colors.red, // Destaque para Ação de Sair
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // 4. CORREÇÃO: Componente auxiliar movido para uma CLASSE SEPARADA ou Widget auxiliar para resolver o erro 'const'
  // Alternativamente, podemos mantê-lo como um método, mas a chamada não pode ser 'const'.
  Widget _StatColumn({
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: color.withOpacity(0.8)),
        ),
      ],
    );
  }

  // 5. CORREÇÃO: Removido o 'static' para manter a consistência da chamada (funciona sem 'static' em StatelessWidget, mas resolve o conflito com 'const' removendo-o do Padding externo).
  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(icon, color: color, size: 28),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, color: color),
      ),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () {
        // Lógica de navegação ou ação
      },
    );
  }
}
