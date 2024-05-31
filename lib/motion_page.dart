import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MotionPage extends StatefulWidget {
  const MotionPage({super.key});

  @override
  State<MotionPage> createState() => _MotionPageState();
}

class _MotionPageState extends State<MotionPage> {
  final _future = Supabase.instance.client.from('tablemotion').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motion'),
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
          final motionData = snapshot.data as List<dynamic>;
          return ListView.builder(
            itemCount: motionData.length,
            itemBuilder: (context, index) {
              final motion = motionData[index];
              final motionValue = motion['motion'];
              final createdAt = motion['created_at'];
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
                            Icons.thermostat_outlined, // Temperature icon
                            color: Colors.black, // Icon color set to black
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Temperature: $motionValue',
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
