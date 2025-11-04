import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  bool loading = false;

  void _login() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    final u = userCtrl.text.trim();
    final p = passCtrl.text.trim();

    // Demo simple: jika username contains "guru" => role guru
    // jika "ortu" => role orang tua. Kalau kosong -> default orang tua.
    if (u.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Masukkan username (guru/ortu) untuk demo')));
      setState(() => loading = false);
      return;
    }

    if (u.toLowerCase().contains('guru')) {
      Navigator.pushReplacementNamed(context, '/guru');
    } else {
      Navigator.pushReplacementNamed(context, '/ortu');
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)]);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.school_rounded, size: 90, color: Colors.white),
                const SizedBox(height: 12),
                const Text('Spy Kids)', style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      TextField(
                        controller: userCtrl,
                        decoration: const InputDecoration(labelText: 'Username (guru / ortu)'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: passCtrl,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Password (demo)'),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: loading ? null : _login,
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2F80ED)),
                          child: loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('Masuk'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Ketik "guru" pada username untuk masuk sebagai guru, lainnya masuk sebagai orang tua', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
