import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile_page.dart';

class DetailProfilePage extends StatelessWidget {
  const DetailProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Profil")),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc('user_profile').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          var data = snapshot.data!.data() as Map<String, dynamic>? ?? {};

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Informasi Pribadi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                const SizedBox(height: 10),
                
                _buildInfoTile(Icons.badge_outlined, "Nama Lengkap", data['nama']),
                _buildInfoTile(Icons.location_on_outlined, "Lokasi", data['lokasi']),
                _buildInfoTile(Icons.work_outline, "Jabatan", data['jabatan']),
                _buildInfoTile(Icons.person_search_outlined, "Profesi", data['profesi']),
                _buildInfoTile(Icons.email_outlined, "Email", data['email']),
                _buildInfoTile(Icons.phone_outlined, "No. HP", data['hp']),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Tentang Saya", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
                Text(data['tentang'] ?? "-", style: const TextStyle(fontSize: 14)),
                
                const SizedBox(height: 30),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profil Saya"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String? value) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value ?? "-", style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }
}