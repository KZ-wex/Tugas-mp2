import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _namaController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _jabatanController = TextEditingController();
  final _profesiController = TextEditingController();
  final _emailController = TextEditingController();
  final _hpController = TextEditingController();
  final _tentangController = TextEditingController();

  void _showConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Konfirmasi")),
          content: const Text("Apakah Anda yakin ingin menyimpan data profil?", textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("NO", style: TextStyle(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                _saveData();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("YES", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveData() async {
    await FirebaseFirestore.instance.collection('users').doc('user_profile').set({
      'nama': _namaController.text,
      'lokasi': _lokasiController.text,
      'jabatan': _jabatanController.text,
      'profesi': _profesiController.text,
      'email': _emailController.text,
      'hp': _hpController.text,
      'tentang': _tentangController.text,
    });
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.edit_note, size: 50, color: Colors.blue),
                const SizedBox(height: 10),
                const Text("Form Input Profil", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                const Text("Silakan isi data profil untuk ditampilkan pada halaman detail profil.", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 20),
                _buildField(_namaController, "Nama Lengkap", Icons.badge_outlined),
                _buildField(_lokasiController, "Lokasi", Icons.location_on_outlined),
                _buildField(_jabatanController, "Jabatan", Icons.work_outline),
                _buildField(_profesiController, "Profesi", Icons.person_search_outlined),
                _buildField(_emailController, "Email", Icons.email_outlined),
                _buildField(_hpController, "No. HP", Icons.phone_outlined),
                _buildField(_tentangController, "Tentang Saya", Icons.info_outline, maxLines: 4),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _showConfirmation,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text("Simpan Data"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, minimumSize: const Size(double.infinity, 50)),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text("Hapus Data"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, minimumSize: const Size(double.infinity, 50)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
