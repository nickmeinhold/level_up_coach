import 'package:flutter/material.dart';

class RecordVideoScreen extends StatefulWidget {
  const RecordVideoScreen({super.key});

  @override
  State<RecordVideoScreen> createState() => _RecordVideoScreenState();
}

class _RecordVideoScreenState extends State<RecordVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Video')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.videocam, size: 100),
            const SizedBox(height: 20),
            const Text('Video recording functionality would go here'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // In a real app, this would return the actual video URL
                Navigator.pop(context, 'https://example.com/video123');
              },
              child: const Text('Simulate Recording'),
            ),
          ],
        ),
      ),
    );
  }
}
