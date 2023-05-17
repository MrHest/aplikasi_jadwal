import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  
  var FlutterNativeSplash;
  var SplashTransition;
  FlutterNativeSplash.configure(
    backgroundColor: Colors.black,
    splashScreen: 'assets/splash2.jpg',
    splashTransition: SplashTransition.fadeTransition,
    splashIconSize: 250,
    duration: 3000,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jadwa SEA Games',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      onGenerateRoute: (settings) {
        // Parsing route name and arguments
        final route = settings.name!.split('/');
        final match = Match(
          route[2],
          route[3],
          route[4],
          DateTime.parse(route[5]),
        );

        if (settings.name!.startsWith('/match/')) {
          return MaterialPageRoute(builder: (context) => MatchPage(match: match));
        }

        return MaterialPageRoute(builder: (context) => UnknownPage());
      },
    );
  }
}

class Match {
  final String teamA;
  final String teamB;
  final String stadium;
  final DateTime matchTime;

  Match(this.teamA, this.teamB, this.stadium, this.matchTime);
}

class HomePage extends StatelessWidget {
  final List<Match> matches = [
    Match('Indonesia', 'Vietnam', 'Stadion kamboja 1', DateTime.parse('2023-12-01 15:00')),
    Match('Thailand', 'Malaysia', 'Stadium kamboja 2', DateTime.parse('2023-12-02 18:00')),
    Match('Philippines', 'Cambodia', 'Stadium kamboja 3', DateTime.parse('2023-12-03 12:00')),
    Match('Singapure', 'Laos', 'Stadium kamboja 4', DateTime.parse('2023-12-04 12:00')),
    Match('Brunei', 'Timor Leste', 'Stadium kamboja 5', DateTime.parse('2023-12-05 12:00')),
    Match('Myanmar', 'Cambodia', 'Stadium kamboja 6', DateTime.parse('2023-12-06 12:00')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal SEA Games'),
      ),
      body: Column(
        children: [
          Image.asset(
          "../images/bgr.jpg",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];

                // Format match time as string
                final matchTimeString = match.matchTime.toLocal().toString();

                return Card(
                  child: ListTile(
                    title: Text('${match.teamA} vs ${match.teamB}'),
                    subtitle: Text('$matchTimeString di ${match.stadium}'),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/match/${match.teamA}/${match.teamB}/${match.stadium}/${match.matchTime.toIso8601String()}',
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
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
                ' ${match.teamA} vs ${match.teamB}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Text(
                'Stadion: ${match.stadium}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20.0),
              Text(
                'Waktu Pertandingan: ${match.matchTime.toLocal()}',
                style: TextStyle(),
                
              
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text(''),
      ),
    );
  }
}
