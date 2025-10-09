import 'package:flutter/material.dart';
import 'package:note_app/views/screens/home_view.dart';

class ForceUpdateView extends StatelessWidget {
  const ForceUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Illustration
                const SizedBox(height: 40),

                // Title
                const Text(
                  'Update Required',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Message
                const Text(
                  'A new version of the app is available.\nPlease update to continue using all features.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Update Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Update Now',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 16),

                // Optional Skip Button (for non-mandatory updates)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeView()),
                    );
                  },
                  child: const Text(
                    'Later',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
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
