import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jadwal SEA Games',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      onGenerateRoute: (settings) {
        // Parsing route name and arguments
        final route = settings.name!.split('/');
        final match =
            Match(route[2], route[3], route[4], DateTime.parse(route[5]));

        // Navigate to MatchPage with match data
        if (settings.name!.startsWith('/pertandingan/')) {
          return MaterialPageRoute(
              builder: (context) => MatchPage(match: match));
        }

      
        return MaterialPageRoute(builder: (context) => UnknownPage());
      },
    );
  }
  
  UnknownPage() {}
}

class Match {
  final String timA;
  final String timB;
  final String stadion;
  final DateTime waktupertandingan;

  Match(this.timA, this.timB, this.stadion, this.waktupertandingan);
}

class HomePage extends StatelessWidget {
  final List<Match> matches = [
    Match('Indonesia', 'Vietnam', 'Stadium 1',
        DateTime.parse('2023-12-01 15:00')),
    Match('Thailand', 'Malaysia', 'Stadium 2',
        DateTime.parse('2023-12-02 18:00')),
    Match('Philippines', 'Cambodia', 'Stadium 3',
        DateTime.parse('2023-12-03 12:00')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal SEA Games'),
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];

          // Format match time as string
          final matchTimeString = match.waktupertandingan.toLocal().toString();

          return Card(
            child: ListTile(
              title: Text('${match.timA} vs ${match.timB}'),
              subtitle: Text('$matchTimeString ${match.stadion}'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/pertandingan/${match.timA}/${match.timB}/${match.stadion}/${match.waktupertandingan}',
                );
              },
            ),
          );
        },
      ),
    );
  }
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 100.0),
        child: Center(
          child: Column(
            children: [
              Image.asset (
                "../images/baner.jpg",
                height: 200.0,
                width: 200.0,
              )
            ],
            )
          )
      )
    );
  }


class MatchPage extends StatelessWidget {
  final Match match;

  MatchPage({required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waktu Pertandingan'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' ${match.timA} vs ${match.timB}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Text(
                'Stadion: ${match.stadion}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20.0),
              Text(
                'Waktu Pertandingan: ${match.waktupertandingan.toLocal()}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Kembali ke halaman sebelumnya
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
