import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDetailVisible = false;

  String _nama = "Ridho Caknono";
  String _bio = "Founder RuangPaham";
  String _domisili = "Jakarta";
  String _gender = "Pria";
  String _pendidikan = "SMA";
  bool _isPublic = true;
  bool _isLookingForJob = false;
  double _skillLevel = 50.0;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final Map<DateTime, List<String>> _activityHistory = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      "Mengerjakan Proyek Flutter",
      "Meeting dengan tim desain"
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1): [
      "Menyelesaikan bug di aplikasi",
      "Presentasi kepada klien"
    ],
  };
  List<String> _activitiesForSelectedDate = [];

  Future<void> _navigateAndEditProfile() async {
    Map<String, dynamic> currentData = {
      'nama': _nama,
      'bio': _bio,
      'gender': _gender,
      'pendidikan': _pendidikan,
      'isPublic': _isPublic,
      'isLookingForJob': _isLookingForJob,
      'skillLevel': _skillLevel,
      'domisili': _domisili,
    };

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(initialData: currentData),
      ),
    );

    if (result != null) {
      setState(() {
        _nama = result['nama'];
        _bio = result['bio'];
        _gender = result['gender'];
        _pendidikan = result['pendidikan'];
        _isPublic = result['isPublic'];
        _isLookingForJob = result['isLookingForJob'];
        _skillLevel = result['skillLevel'];
        _domisili = result['domisili'];
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profil Berhasil Diperbarui! ✅"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        DateTime normalizedDate = DateTime(picked.year, picked.month, picked.day);
        _activitiesForSelectedDate = _activityHistory[normalizedDate] ?? ["Tidak ada aktivitas pada tanggal ini."];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/cover_background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/foto_profil.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            Text(_nama, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("Kota $_domisili", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(20)),
              child: Text(_bio, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [Text("Proyek", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)), Text("30", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
                  Column(children: [Text("Pengikut", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)), Text("2026", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isDetailVisible = !_isDetailVisible;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(_isDetailVisible ? "Sembunyikan Detail Profil" : "Lihat Detail Profil"),
                  ),
                  const SizedBox(height: 10),

                  OutlinedButton.icon(
                    onPressed: _navigateAndEditProfile,
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text("Edit Profil"),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      foregroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            if (_isDetailVisible)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Detail Informasi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const Divider(),
                        _buildDetailRow("Nama Lengkap", _nama),
                        _buildDetailRow("Bio / Jabatan", _bio),
                        _buildDetailRow("Domisili", _domisili),
                        _buildDetailRow("Jenis Kelamin", _gender),
                        _buildDetailRow("Pendidikan", _pendidikan),
                        _buildDetailRow("Profil Publik", _isPublic ? "Ya" : "Tidak"),
                        _buildDetailRow("Mencari Pekerjaan", _isLookingForJob ? "Ya" : "Tidak"),
                        _buildDetailRow("Tingkat Keahlian", "${_skillLevel.toInt()}%"),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Riwayat Aktivitas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(),
                      ListTile(
                        title: Text(_selectedDate == null ? "Pilih tanggal" : "Tanggal: ${_selectedDate!.toLocal().toString().split(' ')[0]}"),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () => _selectDate(context),
                      ),
                      ListTile(
                        title: Text(_selectedTime == null ? "Pilih waktu" : "Waktu: ${_selectedTime?.format(context) ?? ''}"),
                        trailing: const Icon(Icons.access_time),
                        onTap: () => _selectTime(context),
                      ),
                      if (_selectedDate != null) ...[
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               const Text("Aktivitas pada tanggal ini:", style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              ..._activitiesForSelectedDate.map((activity) => Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text("• $activity"),
                              )),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
              const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
