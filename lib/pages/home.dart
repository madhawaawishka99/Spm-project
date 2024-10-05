import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spm_project/component/drawer.dart';
import 'package:spm_project/component/voice.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterTts flutterTts = FlutterTts();
  String username = 'User';

  @override
  void initState() {
    super.initState();
    getUsernameAndGreet();
  }

  Future<void> getUsernameAndGreet() async {
    try {
      // Get the current user
      User? currentUser = FirebaseAuth.instance.currentUser;

      // Fetch the user's document from Firestore
      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users') // Ensure the collection name is correct
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            username = userDoc['username'] ?? 'User';
          });

          // Greet the user using TTS
          await _speak("Hello, $username. You are on the home page.");
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Hi $username!",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                _buildNavigationCard('Profile', Icons.person, '/profile_page'),
                _buildNavigationCard('Fruits', Icons.apple, '/fruits_obj'),
                _buildNavigationCard('Vegetables', Icons.food_bank, '/vegetables_obj'),
                _buildNavigationCard('Packages', Icons.shop, '/packages_obj'),
                _buildNavigationCard('Voice Chat', Icons.chat, '/tutor_list_page'),
                _buildNavigationCard('Saved Object', Icons.save_alt, '/display_shape_obj'),
                _buildNavigationCard('Video call Navigation', Icons.save_alt, '/home_page1'),
                _buildNavigationCard('Coummunity Space', Icons.save_alt, '/community_page'),
              
              ],
            ),
          ),
          SpeechButton(
            onCaptureCommand: () {},
          ),
        ],
      ),
    );
  }

  // Helper method to build navigation cards
  Widget _buildNavigationCard(String text, IconData icon, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, size: 40, color: Colors.purple),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
