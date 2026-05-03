import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/logic/bloc/auth/auth_bloc.dart';
import 'package:rest_api/logic/bloc/auth/auth_event.dart';
import 'package:rest_api/data/repositories/auth_repository.dart';
import 'package:rest_api/logic/bloc/auth/auth_state.dart';
import 'package:rest_api/logic/ui/pages/dashboard_page.dart';
import 'package:rest_api/logic/ui/pages/login_page.dart';
import 'package:rest_api/logic/ui/pages/register_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(repository: AuthRepository())..add(AppStarted()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.indigo,
            ),
            title: "Aplikasi Ternak",
            home: _getHome(state),
          );
        },
      ),
    );
  }

  Widget _getHome(AuthState state) {
    if (state is AuthLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (state is Authenticated) {
      return const DashboardPage(); 
    } else {
      return const LoginPage(); 
    }
  }
}
