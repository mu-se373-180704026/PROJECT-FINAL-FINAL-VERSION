import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'beginner.dart';

class MyAppLoginPage extends StatelessWidget {
  const MyAppLoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xE788ABF1),
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(title: 'Login Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController namectl = TextEditingController();
  TextEditingController emailctl = TextEditingController();
  TextEditingController passwordctl = TextEditingController();
  CollectionReference userData = FirebaseFirestore.instance.collection('users');
  Future login(String mail, String password) async{
    var data = await userData.doc(mail).get();
    if(data.exists){
      if(data["password"] == password){

        String n;
        String m;

         n = await data["name"];
         m = await data["mail"];

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  BeginnerHomePage(title: "Share Chords", name: n, mail: m)),
        );

      }
      else{
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Warning!'),
            content: const Text('Wrong mail or password.'),
            actions: <Widget>[

              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

    }
    else{
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning!'),
          content: const Text('Wrong mail or password.'),
          actions: <Widget>[

            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  child: TextField(
                    controller: emailctl,
                    decoration: InputDecoration(
                      labelText: "mail",

                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: passwordctl,
                    decoration: InputDecoration(
                      labelText: "password",
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            login(emailctl.text, passwordctl.text);
                          },
                          child: Text(
                            "LOGIN",
                          ),
                        ))),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(200, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                    onPressed: (){
                    Navigator.pop(context);

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      Icon(Icons.arrow_back),
                      Text("Previous age"),
                    ],)
                )
              ],
            ),
          ),
        ));
  }
}
