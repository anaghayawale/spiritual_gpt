import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    _user = auth.currentUser!;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'spiritual gpt',
          style: TextStyle(
            fontFamily: 'Samarkan',
            fontSize: 25,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(_user, _isLoading),
            _buildItem(
              icon: Icons.message_rounded,
              title: 'History',
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            _buildItem(
              icon: Icons.logout_rounded,
              title: 'Logout',
              onTap: () {
                _handleLogout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(User user, bool isLoading) {
  if (isLoading) {
    return const CircularProgressIndicator();
  } else {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 48, 47, 47)),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL!),
            radius: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user.displayName ?? 'Guest User',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildItem(
    {required IconData icon,
    required String title,
    required GestureTapCallback onTap}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: onTap,
  );
}

void _handleLogout(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signOut();

  Navigator.pushReplacementNamed(context, '/login');
}
