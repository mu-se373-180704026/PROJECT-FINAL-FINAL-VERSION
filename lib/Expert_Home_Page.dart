import 'package:flutter/material.dart';

class MyExpertHomePage extends StatelessWidget {
  const MyExpertHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xE788ABF1),
        primarySwatch: Colors.blue,
      ),
      home: const ExpertHomePage(title: 'Expert Home Page'),
    );
  }
}

class ExpertHomePage extends StatefulWidget {
  const ExpertHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ExpertHomePage> createState() => _ExpertHomePage();
}

class _ExpertHomePage extends State<ExpertHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCardForUser(),
                Column(
                  children: [
                    CustomCardForWaitingQuestions(),
                    CustomCardForOldQuestions(),
                  ],
                )
              ],
            ),
            UnsolvedQuestions(),
            AskQuestion(),
            AllQuestions(),
          ],
        ),
      ),
    );
  }
}

class CustomCardForUser extends StatefulWidget {
  const CustomCardForUser({Key? key}) : super(key: key);

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
      color: Colors.white70,
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: const SizedBox(
          width: 180,
          height: 210,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("USER INFO"),
          ),
        ),
      ),
    );
  }
}

class CustomCardForWaitingQuestions extends StatefulWidget {
  const CustomCardForWaitingQuestions({Key? key}) : super(key: key);

  @override
  State<CustomCardForWaitingQuestions> createState() =>
      _CustomCardForWaitingQuestionsState();
}

class _CustomCardForWaitingQuestionsState
    extends State<CustomCardForWaitingQuestions> {
  List textFromWaitingQuestions = ["Question1","Question2","Question3","Question4","Question5","Question6"];
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      color: Color(0xE7F35D5D),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          setState(() {
            isVisible = !isVisible;
          });
          debugPrint('Card tapped.');
        },
        child: Column(
          children: [
            Column(children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(35, 16, 35, 16),
                child: Text(
                  "Waiting Questions",
                  textAlign: TextAlign.center,
                ),
              ),
              isVisible
                  ?  Divider(
                thickness: 1,
                indent: 1,
                endIndent: 1,
              )
                  : Container(),
              isVisible
                  ?  Padding(
                padding: EdgeInsets.all(1),
                child: Column(
                  children: [for (int i = 0;i<textFromWaitingQuestions.length;i++)
                    TextButton(onPressed: null, child: Text(textFromWaitingQuestions[i]),
                    )],
                ),
              )
                  : Container(),
            ]),
          ],
        ),
      ),
    );
  }
}

class CustomCardForOldQuestions extends StatefulWidget {
  const CustomCardForOldQuestions({Key? key}) : super(key: key);

  @override
  State<CustomCardForOldQuestions> createState() =>
      _CustomCardForOldQuestionsState();
}

class _CustomCardForOldQuestionsState extends State<CustomCardForOldQuestions> {
  List textFromOldQuestions = ["Question1","Question2","Question3","Question4","Question5","Question6"];
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      color: Color(0xE7F35D5D),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          setState(() {
            isVisible = !isVisible;
          });
          debugPrint('Card tapped.');
        },
        child: Column(
          children: [
            Column(children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(35, 16, 35, 16),
                child: Text(
                  "Old Questions",
                  textAlign: TextAlign.center,
                ),
              ),
              isVisible
                  ?  Divider(
                thickness: 1,
                indent: 1,
                endIndent: 1,
              )
                  : Container(),
              isVisible
                  ?  Padding(
                padding: EdgeInsets.all(1),
                child: Column(
                  children: [for (int i = 0;i<textFromOldQuestions.length;i++)
                    TextButton(onPressed: null, child: Text(textFromOldQuestions[i]),
                    )],
                ),
              )
                  : Container(),
            ]),
          ],
        ),
      ),
    );
  }
}

class AskQuestion extends StatefulWidget {
  const AskQuestion({Key? key}) : super(key: key);

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  final maxLines = 5;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //enable scrolling, when keyboard appears,
      // hight becomes small, so prevent overflow
      child: Container(
        margin: EdgeInsets.all(12),
        height: maxLines * 24.0,
        child: TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: "Ask a song,chord,notes....",
            fillColor: Colors.grey[300],
            filled: true,
          ),
        ),
      ),
    );
  }
}

class AllQuestions extends StatefulWidget {
  const AllQuestions({Key? key}) : super(key: key);
  @override
  State<AllQuestions> createState() => _AllQuestionsState();
} // Cards

class _AllQuestionsState extends State<AllQuestions> {
  List textFromAllQuestions = ["Question1","Question2","Question3","Question4","Question5","Question6"];
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      color: Color(0xE7A7FFC5),
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
          for (int i = 0;i<textFromAllQuestions.length;i++)
            TextButton(onPressed: null, child: Text(textFromAllQuestions[i])
            )
        ],
      ),
    );
  }
}

class UnsolvedQuestions extends StatefulWidget {
  const UnsolvedQuestions({Key? key}) : super(key: key);
  @override
  State<UnsolvedQuestions> createState() => _UnsolvedQuestionsState();
} // Cards

class _UnsolvedQuestionsState extends State<UnsolvedQuestions> {
  List textFromUnSolvedQuestions = ["Question1","Question2","Question3","Question4","Question5","Question6"];
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      color: Color(0xE7A7FFC5),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Column(
        children:[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Unsolved Questions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          for (int i = 0;i<textFromUnSolvedQuestions.length;i++)
            TextButton(onPressed: null, child: Text(textFromUnSolvedQuestions[i])
            )
        ],
      ),
    );
  }
}
