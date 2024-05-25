import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  final _future = Supabase.instance.client.from('lala').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature'),
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
          final temperatureData = snapshot.data as List<dynamic>;
          return ListView.builder(
            itemCount: temperatureData.length,
            itemBuilder: (context, index) {
              final temperature = temperatureData[index];
              final temperatureValue = temperature['temperature'];
              final createdAt = temperature['created_at'];
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
                            'Temperature: $temperatureValue',
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
