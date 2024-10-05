import 'package:flutter/material.dart';
import 'package:spm_project/component/voice.dart';

class ObjectsPage extends StatelessWidget {
  const ObjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Objects"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                _buildObjectCard('Fruits', Icons.apple, '/fruits_obj', context),
                _buildObjectCard('Vegetables', Icons.food_bank, '/vegetables_obj', context),
                _buildObjectCard('Packages', Icons.shop, '/packages_obj', context),
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

  // Helper method to build object cards
  Widget _buildObjectCard(String text, IconData icon, String route, BuildContext context) {
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
