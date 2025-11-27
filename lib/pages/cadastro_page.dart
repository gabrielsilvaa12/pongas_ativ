// lib/pages/register_page.dart

import 'package:flutter/material.dart';
import 'package:pongas_ativ/pages/main_page.dart';
import 'package:pongas_ativ/services/auth_service.dart';

const Color _primaryBlue = Color(0xFF0D47A1);

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // Função de Registro
  Future<void> _handleRegister() async {
    setState(() => _isLoading = true);
    try {
      await _auth.registerWithEmail(
        _emailController.text,
        _passwordController.text,
      );

      // Sucesso: Navega para a tela principal
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    } catch (errorCode) {
      _showSnackbar('Erro no cadastro: $errorCode');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Função de Login com Google
  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await _auth.signInWithGoogle();

      // Sucesso: Navega para a tela principal
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    } catch (errorCode) {
      _showSnackbar('Erro no Google Sign-In: $errorCode');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Título
            const Text(
              'Cadastre-se',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _primaryBlue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Campo E-mail
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Campo Senha
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),

            // Botão de Cadastro (E-mail/Senha)
            ElevatedButton(
              onPressed: _isLoading ? null : _handleRegister,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Cadastrar', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 30),

            // Separador
            const Center(
              child: Text('OU', style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 30),

            // Botão de Cadastro com Google
            OutlinedButton.icon(
              icon: Image.asset(
                'assets/images/google_logo.png',
                height: 24.0,
              ), // Você precisará dessa imagem
              label: const Text(
                'Entrar com Google',
                style: TextStyle(fontSize: 18, color: _primaryBlue),
              ),
              onPressed: _isLoading ? null : _handleGoogleSignIn,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                side: const BorderSide(color: _primaryBlue, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Link para Login
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Volta para a tela de Login
              },
              child: const Text(
                'Já tem uma conta? Faça Login',
                style: TextStyle(color: _primaryBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
