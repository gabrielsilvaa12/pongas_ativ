// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:pongas_ativ/pages/main_page.dart';
import 'package:pongas_ativ/services/auth_service.dart';

const Color _primaryBlue = Color(0xFF0D47A1);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // Função de Login
  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    try {
      await _auth.signInWithEmail(
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
      _showSnackbar('Erro no login: $errorCode');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Função de Login com Google (Reutiliza a do LoginPage)
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 100),

            // Título
            const Text(
              'Acesse sua conta',
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

            // Botão de Login (E-mail/Senha)
            ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Login', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 30),

            // Separador
            const Center(
              child: Text('OU', style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 30),

            // Botão de Login com Google
            OutlinedButton.icon(
              icon: Image.asset('assets/images/google_logo.png', height: 24.0),
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

            // Link para Cadastro
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                'Ainda não tem conta? Cadastre-se',
                style: TextStyle(color: _primaryBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
