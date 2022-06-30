import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'register.dart';
import 'beginner.dart';
import 'Expert_Home_Page.dart';
import 'firebase_options.dart';
import 'login.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Cords',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE3D7D7),
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Share Cords'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  Future<void> addUser() {
    var users = FirebaseFirestore.instance.collection("users");
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'full_name': "ali", // John Doe
      'company': "amazon", // Stokes and Sons
      'age': 23 // 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

        children: [

          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(200, 50)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
            ),
            onPressed: (){

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  LoginPage(title: "Login")),
              );
            },
            child: Text("Login"),
          ),
          Container(child: Text(""),),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(200, 50)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage(title: "Register")),
              );
            },
            child: Text("Register"),
          ),



        ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
