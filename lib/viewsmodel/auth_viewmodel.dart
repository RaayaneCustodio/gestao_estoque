import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/user.dart';
import 'package:gestao_estoque/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel({required this.authRepository}) {
    _user = authRepository.currentUser;
  }

  final AuthRepository authRepository;

  AppUser? _user;
  bool isLoading = false;
  String feedback = '';

  AppUser? get user => _user;
  bool get isAuthenticated => _user != null && authRepository.isAuthenticated;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    feedback = '';
    notifyListeners();

    try {
      _user = await authRepository.login(email, password);
      return true;
    } catch (e) {
      debugPrint('Erro ao fazer login: $e');
      feedback = 'Nao foi possivel entrar. Verifique o e-mail e a senha.';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    authRepository.logout();
    _user = null;
    feedback = '';
    notifyListeners();
  }
}
