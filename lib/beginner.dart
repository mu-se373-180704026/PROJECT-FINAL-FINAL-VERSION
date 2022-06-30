 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Question.dart';
import 'Questions.dart';

class BeginnerHomePage extends StatefulWidget {
  const BeginnerHomePage({Key? key, required this.title, required this.name, required this.mail}) : super(key: key);
  final String title;
  final String name;
  final String mail;
  @override
  State<BeginnerHomePage> createState() => _BeginnerHomePage();
}

class _BeginnerHomePage extends State<BeginnerHomePage> {
  List<Question> questionList = [];
  @override
  CollectionReference questionsRef = FirebaseFirestore.instance.collection('questions');
  Future updateData() async {
    questionList.clear();
    QuerySnapshot querySnapshot = await questionsRef.get();
    querySnapshot.docs.forEach((element) {

      if(element.data().toString() != "{}"){

        Question q = Question(element["id"], element["name"], element["content"], element["askedBy"]);
        q.answers = element["answers"];
        questionList.add(q);
      }



    }
    );
    print(questionList.length);

    // Get data from docs and convert map to List




  }



  void initState() {
    updateData();
    questionsRef.snapshots().listen((result) {
    updateData();
      // Question q = Question(result.data()?["id"], result["name"], result["content"], result["askedBy"]);
    });

    // questionsRef.snapshots().listen((querySnapshot) {
    //   querySnapshot.docChanges.forEach((change) async {
    //     await questionsRef
    //         .get()
    //         .then((QuerySnapshot querySnapshot) {
    //       querySnapshot.docs.forEach((doc) async{
    //         var data = await doc.data();
    //
    //         if(doc.data()["id"] != null){
    //           Question q = Question(data["id"], data["name"], data["content"], data["askedBy"]);
    //           questionList.add(q);
    //           print(questionList.length);
    //         }
    //
    //       });
    //     });
    //   });
    // });

  }
  @override
  Widget build(BuildContext context) {
    questionList.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                CustomCardForUser(name: widget.name, mail: widget.mail),
                Column(
                  children: [
                    Container(height: 5,),
                    ElevatedButton(

                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),)),
                          minimumSize: MaterialStateProperty.all(Size(200, 90)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                        ),

                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  QuestionsHomePage(title: "Questions", questionList: questionList, userName: widget.name,)),
                          );
                        }, child: Text(
                        "See All Questions",
                      style: TextStyle(height: 1 , fontSize: 18),
                        ))
                  ],
                ),
              ],
            ),
            AskQuestion(name: widget.name, questionList: questionList,),
            Container(child: Text(""),),
          ],
        ),
      ),
    );
  }
}

class CustomCardForUser extends StatefulWidget {
  const CustomCardForUser({Key? key, required this.name, required this.mail}) : super(key: key);
  final String name;
  final String mail;
  @override
  State<CustomCardForUser> createState() => _CustomCardForUserState();
}

class _CustomCardForUserState extends State<CustomCardForUser> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      color: const Color(0xffb053f8),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
        },
        child:  Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Name: ${widget.name}",
              style: TextStyle( fontSize: 16),),
            Container(height: 5,),
            Text("Mail:${widget.mail}",
              style: TextStyle( fontSize: 16),)
          ],)
        ),
      ),
    );
  }
}



class AskQuestion extends StatefulWidget {
  const AskQuestion({Key? key, required this.name, required this.questionList}) : super(key: key);
  final String name;
  final List<Question> questionList;

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  TextEditingController questionNameCtl = TextEditingController();
  TextEditingController questionContentCtl = TextEditingController();
  CollectionReference questions = FirebaseFirestore.instance.collection('questions');
  final maxLines = 5;
  Future askQuestion(String name, String content) async{
    bool flag = true;
    widget.questionList.forEach((element) {
      if(element.name == name){
        print("This question exists.");
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Warning!'),
            content: const Text('This question exists.'),
            actions: <Widget>[

              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        flag = false;
      }
    });
    int id = 0;
    if(flag){
      Question q = Question(id, name, content, widget.name);
      await questions.doc(name).set(q.toJSON()).then((value) => print("yey")).catchError((error) => print("Failed to add user: $error"));
    }


  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(12),
          child: TextField(
            controller: questionNameCtl,
            decoration: InputDecoration(
                hintText: "Question Header",
                fillColor: Color(0xff5af6d9),
              filled: true,
            ),
          ),
        ),
        SingleChildScrollView(
          //enable scrolling, when keyboard appears,
          // hight becomes small, so prevent overflow
          child: Container(
            margin: EdgeInsets.all(12),
            height: maxLines * 24.0,
            child: TextField(
              controller: questionContentCtl,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: "Ask a song,chord,notes....",
                fillColor: Color(0xff4bf5d6),
                filled: true,
              ),
            ),
          ),
        ),
      ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(200, 50)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
          ),
          onPressed: (){
        askQuestion(questionNameCtl.text, questionContentCtl.text);
      }, child: Text("Ask Question"))
      ],
    );
  }
}

class AllQuestions extends StatefulWidget {
  const AllQuestions({Key? key, required this.questionList}) : super(key: key);
  final List<Question> questionList;
  @override
  State<AllQuestions> createState() => _AllQuestionsState();
}     // Cards

class _AllQuestionsState extends State<AllQuestions> {
  List textFromAllQuestions = ["Question1","Question2","Question3","Question4","Question5","Question6"];
  CollectionReference questionsRef = FirebaseFirestore.instance.collection('questions');

  @override
  void initState() {
    questionsRef.snapshots().listen((event) {
      setState(() {
        print("hey");
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    widget.questionList.length;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35),),
      color: Color(0xE788ABF1),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "All Questions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          for (int i = 0;i<widget.questionList.length;i++)
            TextButton(onPressed: null, child: Text(widget.questionList[i].name)
            )



        ],
      ),
    );
  }
}


 class QListView extends StatelessWidget {
   const QListView({Key? key, required this.entries}) : super(key: key);
   final List<dynamic> entries;
   @override
   Widget build(BuildContext context) {
     return ListView.separated(
       padding: const EdgeInsets.all(8),
       itemCount: entries.length,
       itemBuilder: (BuildContext context, int index) {
         return Container(
           height: 50,
           color: Colors.brown[((index + 1) * 100) % 700],
           child: Center(child: Text('Player ${index + 1}: ${entries[index]}')),
         );
       },
       separatorBuilder: (BuildContext context, int index) => const Divider(),
     );
   }
 }

