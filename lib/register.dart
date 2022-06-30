import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MyAppRegisterPage extends StatelessWidget {
  const MyAppRegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xE788ABF1),
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(title: 'Register Page'),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController namectl = TextEditingController();
  TextEditingController emailctl = TextEditingController();
  TextEditingController passwordctl = TextEditingController();
  CollectionReference userData = FirebaseFirestore.instance.collection('users');


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    namectl.dispose();
    emailctl.dispose();
    passwordctl.dispose();
    super.dispose();
  }
  Future createUser(String name, String mail, String password) async{

    var data = await userData.doc(mail).get();
    if(data.exists){

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning!'),
          content: const Text('User already exists.'),
          actions: <Widget>[

            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );

    }
    else{
      await userData.doc(mail).set({
        'name': name, // John Doe
        'mail': mail, // Stokes and Sons
        'password': password // 42
      }).then((value) => print("created")).catchError((error) => print("Failed to add user: $error"));
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: Text('User created. Redirecting to homepage.'),
            );
          }).then((value) => Navigator.pop(context));

    }

  }
  Future<void> addUser(String name,String mail,String password) {
    var users = FirebaseFirestore.instance.collection("database");
    // Call the user's CollectionReference to add a new user
    return users.doc("userList").collection("users").doc(name)
        .set({
      'full_name': name, // John Doe
      'mail': mail, // Stokes and Sons
      'password': password, // 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        //enable scrolling, when keyboard appears,
        // hight becomes small, so prevent overflow
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                  child: TextField(
                    controller: emailctl,
                decoration: InputDecoration(
                  labelText: "Mail:",
                ),
              )), //text input for name

              Container(
                  child: TextField(
                    controller: namectl,
                decoration: InputDecoration(
                  labelText: "Username:",
                ),
              )), //text input for address

              Container(
                  child: TextField(

                    controller: passwordctl,
                decoration: InputDecoration(
                  labelText: "Password:",
                ),
              )), //text input for roll no

              Container(
                margin: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      createUser(namectl.text, emailctl.text, passwordctl.text);
                    },
                    child: Text(
                      "REGISTER",
                    ),
                    //background of button is darker color, so set brightness to dark
                  ),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back),
                      Text("Previous Page"),

                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class Alert extends StatelessWidget {
  const Alert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning!'),
          content: const Text('User already exists.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}

