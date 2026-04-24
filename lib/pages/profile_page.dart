import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detail_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc('user_profile').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        var data = snapshot.data!.data() as Map<String, dynamic>? ?? {};

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://images.unsplash.com/photo-1769788873237-fbd659d9a9f5?w=400&auto=format&fit=crop&q=60"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 140,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage("https://images.unsplash.com/photo-1718382341267-aef8a9e4ecef?w=400&auto=format&fit=crop&q=60"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                
                Text(
                  data['nama'] ?? "Nama User", 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                ),
                Text(data['lokasi'] ?? "Lokasi"),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(15)),
                  child: Text(data['jabatan'] ?? "Jabatan", style: const TextStyle(color: Colors.blue)),
                ),
                
                const SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat("Proyek", "30"),
                      const VerticalDivider(thickness: 1),
                      _buildStat("Pengikut", "2026"),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  color: Colors.blueAccent,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const DetailProfilePage())
                      );
                    },
                    icon: const Icon(Icons.person_search, color: Colors.white, size: 16),
                    label: const Text("Lihat Detail Profil", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
      ],
    );
  }
}
