import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'temperature_page.dart';
import 'motion_page.dart';
import 'light_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(

  );
  final latestTemp = await Supabase.instance.client
      .from('lala')
      .select('temperature')
      .order('id', ascending: false)
      .limit(1);
  final latestLight = await Supabase.instance.client
      .from('haha')
      .select('lighter')
      .order('id', ascending: false)
      .limit(1);
  runApp(Home(
    latestTemp: latestTemp,
    latestLight: latestLight,
  ));
}

class Home extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final latestTemp;
  // ignore: prefer_typing_uninitialized_variables
  final latestLight;

  const Home({Key? key, this.latestTemp, this.latestLight});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var latestTemp;
  var latestLight;

  @override
  void initState() {
    super.initState();
    latestTemp = widget.latestTemp;
    latestLight = widget.latestLight;
  }

  Future<void> _refreshData() async {
    final newLatestTemp = await Supabase.instance.client
        .from('lala')
        .select('temperature')
        .order('id', ascending: false)
        .limit(1);
    final newLatestLight = await Supabase.instance.client
        .from('haha')
        .select('lighter')
        .order('id', ascending: false)
        .limit(1);

    setState(() {
      latestTemp = newLatestTemp;
      latestLight = newLatestLight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Room Monitoring',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Fortinity',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.1,
            ),
          ),
          backgroundColor: const Color(0xFFFEE715),
        ),
        drawer: Drawer(
          backgroundColor: const Color(0xFF101820),
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFFFEE715)),
                child: Center(
                  child: Text(
                    'Fortinity',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.1,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny, size: 24.0, color: Colors.white),
                title: Text(
                  'About  Fortinity',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              ListTile(
                leading:
                    Icon(Icons.accessibility, size: 24.0, color: Colors.white),
                title: Text(
                  'About Us',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: MyCard(
            latestTemp: latestTemp,
            latestLight: latestLight,
          ),
        ),
        backgroundColor: const Color(0xFF101820),
        floatingActionButton: FloatingActionButton(
          onPressed: _refreshData,
          backgroundColor: const Color(0xFFFEE715),
          child: const Icon(
            Icons.refresh_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final latestTemp;
  // ignore: prefer_typing_uninitialized_variables
  final latestLight;

  const MyCard({Key? key, this.latestTemp, this.latestLight});

  @override
  Widget build(BuildContext context) {
    final temperature =
        latestTemp.isNotEmpty ? latestTemp[0]['temperature'].toString() : '';
    final light =
        latestLight.isNotEmpty ? latestLight[0]['lighter'].toString() : '';

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TemperaturePage()),
            );
          },
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.thermostat,
                      size: 24.0, color: Color(0xFF101820)),
                  title: const Text(
                    'Temperature',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                      color: Colors.black,
                      letterSpacing: 1.2,
                    ),
                  ),
                  subtitle: Text(
                    '$temperature°C',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 1.2,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MotionPage()),
            );
          },
          child: const Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.accessibility,
                      size: 24.0, color: Color(0xFF101820)),
                  title: Text(
                    'Motion',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                      color: Colors.black,
                      letterSpacing: 1.2,
                    ),
                  ),
                  subtitle: Text(
                    'Detected',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 1.2,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LightPage()),
            );
          },
          child: Card(
            // Added GestureDetector here
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.lightbulb,
                      size: 24.0, color: Color(0xFF101820)),
                  title: const Text(
                    'Light',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                      color: Colors.black,
                      letterSpacing: 1.2,
                    ),
                  ),
                  subtitle: Text(
                    '$light(lm)', // Displaying light data here
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 1.2,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
