import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> dummyPosts = [
    {
      "name": "Alex Rivai",
      "role": "Senior Developer at Tech Giant",
      "time": "2 jam",
      "content": "Tips belajar Flutter: Jangan cuma hafal syntax, tapi pahamin konsep Widget Tree-nya! 🚀",
      "profileImg": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200",
      "postImg": "https://images.unsplash.com/photo-1587620962725-abab7fe55159?w=600",
    },
    {
      "name": "Sarah Wijaya",
      "role": "Product Designer",
      "time": "5 jam",
      "content": "Clean UI is a happy user. Hari ini ngerapihin desain dashboard lagi. Gimana menurut kalian?",
      "profileImg": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200",
      "postImg": "https://images.unsplash.com/photo-1586717791821-3f44a563eb4c?w=600",
    },
    {
      "name": "Budi Pratama",
      "role": "Recruiter at Startup XYZ",
      "time": "1 hari",
      "content": "Lagi cari 5 Flutter Developer buat batch bulan depan. DM gue kalau tertarik ya!",
      "profileImg": "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200",
      "postImg": "https://images.unsplash.com/photo-1521737711867-e3b97375f902?w=600",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/foto_profil.jpg'),
          ),
        ),
        title: Container(
          height: 35,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF3F7),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Cari",
              hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
              prefixIcon: Icon(Icons.search, size: 20, color: Colors.black54),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 2),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyPosts.length,
        itemBuilder: (context, index) {
          return _buildPostCard(dummyPosts[index]);
        },
      ),
    );
  }

  Widget _buildPostCard(Map<String, String> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data['profileImg']!),
            ),
            title: Text(
              data['name']!, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
            ),
            subtitle: Text(data['role']!),
            trailing: const Icon(Icons.more_horiz),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(data['content']!),
          ),
          const SizedBox(height: 8),
          Image.network(
            data['postImg']!, 
            fit: BoxFit.cover, 
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 200,
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.thumb_up_alt_outlined, "Suka"),
                _buildActionButton(Icons.comment_outlined, "Komentar"),
                _buildActionButton(Icons.repeat, "Posting"),
                _buildActionButton(Icons.send, "Kirim"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.black54),
            const SizedBox(width: 4),
            Text(
              label, 
              style: const TextStyle(
                fontSize: 12, 
                color: Colors.black54, 
                fontWeight: FontWeight.bold
              )
            ),
          ],
        ),
      ),
    );
  }
}
