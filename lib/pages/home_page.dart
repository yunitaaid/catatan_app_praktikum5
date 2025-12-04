import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> items = [
    {"title": "Belajar Row & Column", "desc": "Pahami mainAxis dan crossAxis, serta Expanded/Flexible."},
    {"title": "Button di Flutter", "desc": "Gunakan FilledButton untuk aksi utama."},
    {"title": "Overflow Text", "desc": "Gunakan maxLines untuk mencegah teks meledak."},
  ];

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  // ============================================================
  // 🔵 LOGOUT DENGAN KONFIRMASI
  // ============================================================
  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Keluar", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text("Yakin ingin keluar dari aplikasi?", style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal", style: GoogleFonts.poppins()),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context); // tutup dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            child: Text("Logout", style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 🔵 BOTTOMSHEET TAMBAH
  // ============================================================
  void _showAddSheet() {
    titleCtrl.clear();
    descCtrl.clear();

    _openBottomSheet(
      title: "Tambah Catatan",
      buttonText: "Simpan",
      onSave: () {
        setState(() {
          items.add({"title": titleCtrl.text, "desc": descCtrl.text});
        });
      },
    );
  }

  // ============================================================
  // 🔵 BOTTOMSHEET EDIT
  // ============================================================
  void _showEditSheet(int index) {
    titleCtrl.text = items[index]["title"]!;
    descCtrl.text = items[index]["desc"]!;

    _openBottomSheet(
      title: "Edit Catatan",
      buttonText: "Simpan Perubahan",
      onSave: () {
        setState(() {
          items[index] = {
            "title": titleCtrl.text,
            "desc": descCtrl.text,
          };
        });
      },
    );
  }

  // ============================================================
  // 🔵 BOTTOMSHEET UTAMA
  // ============================================================
  void _openBottomSheet({required String title, required String buttonText, required VoidCallback onSave}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),

            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(
                labelText: "Judul",
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: descCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Deskripsi",
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  backgroundColor: Colors.teal.shade500,
                ),
                onPressed: () {
                  onSave();
                  Navigator.pop(context);
                },
                child: Text(buttonText, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 🔴 KONFIRMASI HAPUS
  // ============================================================
  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text("Hapus Catatan", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text("Yakin ingin menghapus catatan ini?", style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            child: Text("Batal", style: GoogleFonts.poppins()),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Hapus", style: GoogleFonts.poppins()),
            onPressed: () {
              setState(() => items.removeAt(index));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 🔵 CARD ESTETIK
  // ============================================================
  Widget _buildCard(Map<String, String> item, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 7, offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.note_alt, color: Colors.teal, size: 24),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["title"]!, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(item["desc"]!, maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 13)),
              ],
            ),
          ),

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 22, color: Colors.teal),
                onPressed: () => _showEditSheet(index),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 22, color: Colors.red),
                onPressed: () => _confirmDelete(index),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 🔵 UI UTAMA
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F7F1),

      appBar: AppBar(
        title: Text("CatatanKu", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.teal.shade600,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text("Rekomendasi",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...items.asMap().entries.map((e) => _buildCard(e.value, e.key)),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade600,
        child: const Icon(Icons.add, size: 28),
        onPressed: _showAddSheet,
      ),
    );
  }
}
