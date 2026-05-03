import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/logic/bloc/auth/auth_bloc.dart';
import 'package:rest_api/logic/bloc/auth/auth_event.dart';
import 'package:rest_api/data/repositories/auth_repository.dart';
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
      create: (_) => AuthBloc(
        repository: AuthRepository(),
      )..add(AppStarted()), 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
        ),

        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/dashboard': (context) => const DashboardPage(),
        },
      ),
    );
  }
}