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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Tambah Hewan",
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
  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white.withOpacity(0.1),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildField(_namaController, "Nama", icon: Icons.pets),
                  const SizedBox(height: 12),
                  _buildField(_jenisController, "Jenis", icon: Icons.category),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _tanggalController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Tanggal Lahir",
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white70,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) => value == null || value.isEmpty
                        ? "Tanggal tidak boleh kosong"
                        : null,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null) {
                        String formatted =
                            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                        setState(() {
                          _tanggalController.text = formatted;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildField(
                    _hargaController,
                    "Harga",
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  _buildField(_statusController, "Status", icon: Icons.info),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<HewanBloc>().add(
                          CreateHewan({
                            "nama": _namaController.text,
                            "jenis": _jenisController.text,
                            "tanggal_lahir": _tanggalController.text,
                            "harga": int.parse(_hargaController.text),
                            "status": _statusController.text,
                          }),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Tambah"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
  Widget _buildField(
    TextEditingController controller,
    String hint, {
    IconData? icon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.isEmpty ? "$hint tidak boleh kosong" : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: icon != null ? Icon(icon, color: Colors.white70) : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
