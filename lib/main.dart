import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobil_verify_app/screens/home_screen.dart';
import 'package:mobil_verify_app/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Authentication Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitializerWidget(),
    );
  }
}

class InitializerWidget extends StatefulWidget {
  InitializerWidget({Key? key}) : super(key: key);

  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  FirebaseAuth? _auth;
  User? _user;

  bool showLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
    showLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return showLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _user == null
            ? LoginScreen()
            : HomeScreen();
  }
}
