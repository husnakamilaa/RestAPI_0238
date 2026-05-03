import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/logic/bloc/hewan/hewan_bloc.dart';
import 'package:rest_api/logic/bloc/hewan/hewan_event.dart';

class AddHewanPage extends StatefulWidget {
  const AddHewanPage({super.key});

  @override
  State<AddHewanPage> createState() => _AddHewanPageState();
}

class _AddHewanPageState extends State<AddHewanPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _jenisController = TextEditingController();
  final _statusController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _hargaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _jenisController.dispose();
    _statusController.dispose();
    _hargaController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }

  
}
