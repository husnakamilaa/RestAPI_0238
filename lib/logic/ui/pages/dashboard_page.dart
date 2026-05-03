import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/logic/bloc/auth/auth_bloc.dart';
import 'package:rest_api/logic/bloc/auth/auth_event.dart';
import 'package:rest_api/logic/bloc/hewan/hewan_bloc.dart';
import 'package:rest_api/logic/bloc/hewan/hewan_event.dart';
import 'package:rest_api/logic/bloc/hewan/hewan_state.dart';
import 'package:rest_api/data/repositories/hewan_repository.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HewanBloc(repository: HewanRepository())..add(FetchHewan()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Aplikasi Ternak',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
              icon: const Icon(Icons.logout, color: Colors.white),
              tooltip: 'Logout',
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A237E), Color(0xFF4FC3F7)],
                ),
              ),
            ),
            BlocListener<HewanBloc, HewanState>(
              listener: (context, state) {
                if (state is HewanCreatedSuccess) {
                  _showSnackBar(context, 'Operasi Berhasil!', Colors.green);
                } else if (state is HewanError) {
                  _showSnackBar(context, state.message, Colors.red);
                }
              },
              child: BlocBuilder<HewanBloc, HewanState>(
                builder: (context, state) {
                  if (state is HewanLoading) {
                    return Center(
                      child: Image.asset('assets/loading.json', width: 200),
                    );
                  } else if (state is HewanError) {
                    return Center(
                      child: const Text(
                        'Belum ada coloasi.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return CustomRefreshIndicator(
                    onRefresh: () async {
                      context.read<HewanBloc>().add(FetchHewan());
                      await Future.delayed(const Duration(seconds: 2));
                    },
                    builder: (context, child, controller) {
                      return AnimatedBuilder(
                        animation: controller,
                        builder: (context, _) {
                          return Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              if (controller.state == IndicatorState.loading)
                                Positioned(
                                  top: 50 * controller.value,
                                  child: Image.asset(
                                    'assets/loading.json',
                                    height: 80,
                                  ),
                                ),
                              Transform.translate(
                                offset: Offset(0, 100 * controller.value),
                                child: child,
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ListView.builder(
                      itemCount: state is HewanLoaded
                          ? (state as HewanLoaded).hewanList.length
                          : 0,
                      itemBuilder: (context, index) {
                        final hewan = (state as HewanLoaded).hewanList[index];
                        return _buildHewanCard(context, hewan);
                      },
                    ),
                  );

                  return Center(child: Text("Gagal memuat data."));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: context.read<HewanBloc>(),
                    child: AddHewanPage(),
                  ),
                ),
              );
            },
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildHewanCard(BuildContext context, dynamic hewan) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.2),
          child: const Icon(Icons.pets, color: Colors.white),
        ),
        title: Text(
          hewan.nama,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${hewan.jenis} • ${hewan.status}',
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () => _showDeleteDialog(context, hewan),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, dynamic hewan) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.indigo.shade900,
        title: const Text(
          'Hapus Hewan?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Anda yakin ingin menghapus ${hewan.nama}?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context.read<HewanBloc>().add(DeleteHewan(hewan.id));
              Navigator.pop(dialogContext);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: color));
  }
}
