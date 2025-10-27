import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _u = TextEditingController();
  final TextEditingController _p = TextEditingController();
  bool _loading = false;
  late AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }
  // @override
  // void dispose() {
  //   _anim.dispose();
  //   _u.dispose();
  //   _p.dispose();
  //   super.dispose();
  // }

  void _login() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    // contoh sederhana: username: ortu ; password: 1234
    if (_u.text.trim() == 'ortu' && _p.text.trim() == '1234') {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login gagal — coba: ortu / 1234')));
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)], begin: Alignment.topLeft, end: Alignment.bottomRight);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: Tween(begin: 0.95, end: 1.05).animate(CurvedAnimation(parent: _anim, curve: Curves.easeInOut)),
                  child: const Icon(Icons.school_rounded, size: 96, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text('Spy Kids App', style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)]),
                  child: Column(
                    children: [
                      TextField(
                        controller: _u,
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline), labelText: 'Username'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _p,
                        obscureText: true,
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.lock_outline), labelText: 'Password'),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _login,
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 14)),
                          child: _loading ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('Masuk', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => showDialog(context: context, builder: (_) => const AlertDialog(title: Text('Info'), content: Text('Gunakan username: ortu dan password: 1234 untuk demo'))),
                        child: const Text('Butuh bantuan?'),
                      )
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