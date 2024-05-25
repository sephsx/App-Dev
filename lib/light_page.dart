import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LightPage extends StatefulWidget {
  const LightPage({super.key});

  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  final _future = Supabase.instance.client.from('haha').select().limit(50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Light'),
        backgroundColor: const Color(0xFFFEE715),
      ),
      backgroundColor: const Color(0xFF101820),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final LightData = snapshot.data as List<dynamic>;
          return ListView.builder(
            itemCount: LightData.length,
            itemBuilder: (context, index) {
              final light = LightData[index];
              final lightValue = light['lighter'];
              final createdAt = light['created_at'];
              return Card(
                color: Colors.white, // Background color set to white
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.lightbulb, // Temperature icon
                            color: Colors.black, // Icon color set to black
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Light: $lightValue',
                            style: const TextStyle(
                              color: Colors.black, // Text color set to black
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time, // Creation time icon
                            color: Colors.black, // Icon color set to black
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Created At: $createdAt',
                            style: const TextStyle(
                              color: Colors.black, // Text color set to black
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
