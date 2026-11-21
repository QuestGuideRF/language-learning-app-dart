import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/exercise_screen.dart';
import 'screens/profile_screen.dart';
import 'providers/user_provider.dart';
import 'providers/language_provider.dart';
import 'providers/lesson_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => LanguageProvider()),
        ChangeNotifierProvider(create: (ctx) => LessonProvider()),
      ],
      child: MaterialApp(
        title: 'Изучение языков',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            headline3: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            bodyText1: TextStyle(fontSize: 16),
            bodyText2: TextStyle(fontSize: 14),
          ),
        ),
        home: MainScreen(),
        routes: {
          '/lesson': (ctx) => LessonScreen(),
          '/exercise': (ctx) => ExerciseScreen(),
          '/profile': (ctx) => ProfileScreen(),
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    HomeScreen(),
    LessonScreen(),
    ProfileScreen(),
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Уроки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _onItemTapped,
      ),
    );
  }
}