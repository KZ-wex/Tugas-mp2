import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> initialData;
  const EditProfilePage({super.key, required this.initialData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late String _gender;
  late String _pendidikan;
  late bool _isPublic;
  late bool _isLookingForJob;
  late double _skillLevel;
  late String _domisili;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData['nama']);
    _bioController = TextEditingController(text: widget.initialData['bio']);
    _gender = widget.initialData['gender'];
    _pendidikan = widget.initialData['pendidikan'];
    _isPublic = widget.initialData['isPublic'];
    _isLookingForJob = widget.initialData['isLookingForJob'];
    _skillLevel = widget.initialData['skillLevel'];
    _domisili = widget.initialData['domisili'];
  }

  void _confirmSave() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Simpan Perubahan?"),
        content: const Text("Pastikan semua data yang diinput sudah benar."),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Batal")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              
              Map<String, dynamic> updatedData = {
                'nama': _nameController.text,
                'bio': _bioController.text,
                'gender': _gender,
                'pendidikan': _pendidikan,
                'isPublic': _isPublic,
                'isLookingForJob': _isLookingForJob,
                'skillLevel': _skillLevel,
                'domisili': _domisili,
              };

              Navigator.pop(context, updatedData);
            }, 
            child: const Text("Ya, Simpan")
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profil")),
      body: ListView( 
        padding: const EdgeInsets.all(16),
        children: [
          _buildLabel("Nama Lengkap"),
          TextField(controller: _nameController, decoration: const InputDecoration(border: OutlineInputBorder())),
          const SizedBox(height: 15),

          _buildLabel("Bio / Jabatan"),
          TextField(controller: _bioController, decoration: const InputDecoration(border: OutlineInputBorder())),
          const SizedBox(height: 15),

          _buildLabel("Domisili"),
          DropdownButtonFormField<String>(
            value: _domisili,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: ["Jakarta", "Bandung", "Surabaya", "Medan"].map((city) {
              return DropdownMenuItem(value: city, child: Text(city));
            }).toList(),
            onChanged: (val) => setState(() => _domisili = val!),
          ),
          const SizedBox(height: 20),

          _buildLabel("Jenis Kelamin"),
          Row(
            children: [
              Radio(value: "Pria", groupValue: _gender, onChanged: (v) => setState(() => _gender = v.toString())),
              const Text("Pria"),
              const SizedBox(width: 20),
              Radio(value: "Wanita", groupValue: _gender, onChanged: (v) => setState(() => _gender = v.toString())),
              const Text("Wanita"),
            ],
          ),
          const SizedBox(height: 10),

          _buildLabel("Pendidikan Terakhir"),
          Column(
            children: ["SMK", "Diploma", "Sarjana"].map((edu) {
              return RadioListTile(
                title: Text(edu),
                value: edu,
                groupValue: _pendidikan,
                onChanged: (v) => setState(() => _pendidikan = v.toString()),
              );
            }).toList(),
          ),

          _buildLabel("Pengaturan Akun"),
          CheckboxListTile(
            title: const Text("Profil Publik"),
            subtitle: const Text("Izinkan semua orang melihat profil Anda"),
            value: _isPublic, 
            onChanged: (v) => setState(() => _isPublic = v!),
          ),
          CheckboxListTile(
            title: const Text("Terbuka untuk Pekerjaan"),
            value: _isLookingForJob, 
            onChanged: (v) => setState(() => _isLookingForJob = v!),
          ),

          _buildLabel("Tingkat Keahlian Flutter: ${_skillLevel.toInt()}%"),
          Slider(
            value: _skillLevel,
            max: 100,
            divisions: 10,
            label: _skillLevel.round().toString(),
            onChanged: (v) => setState(() => _skillLevel = v),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: _confirmSave, 
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.blue[800],
              foregroundColor: Colors.white,
            ),
            child: const Text("SIMPAN SEMUA PERUBAHAN"),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}