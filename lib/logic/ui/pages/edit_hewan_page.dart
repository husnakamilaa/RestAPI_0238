import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/logic/bloc/hewan/hewan_bloc.dart';
import 'package:rest_api/logic/bloc/hewan/hewan_event.dart';

class EditHewanPage extends StatefulWidget {
  final dynamic hewan;

  const EditHewanPage({super.key, required this.hewan});

  @override
  State<EditHewanPage> createState() => _EditHewanPageState();
}

class _EditHewanPageState extends State<EditHewanPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _namaController;
  late TextEditingController _jenisController;
  late TextEditingController _statusController;
  late TextEditingController _hargaController;
  late TextEditingController _tanggalController;

  @override
  void initState() {
    super.initState();

    _namaController = TextEditingController(text: widget.hewan.nama);
    _jenisController = TextEditingController(text: widget.hewan.jenis);
    _statusController = TextEditingController(text: widget.hewan.status);
    _hargaController = TextEditingController(
      text: widget.hewan.harga.toString(),
    );
    _tanggalController = TextEditingController(text: widget.hewan.tanggalLahir);
  }

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Edit Hewan",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A237E), Color(0xFF4FC3F7)],
          ),
        ),
        child: Center(child: _buildForm(context)),
      ),
    );
  }

  
}
