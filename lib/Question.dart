



import 'dart:collection';
import 'Answer.dart';

class Question {
  var name;
  var content;
  var askedBy;
  var isAnswered;
  var answers;

  var id;

  Question(int id, String name, String content, String askedBy){
    this.id = id;
    this.name = name;
    this.content = content;
    this.askedBy = askedBy;
    isAnswered = false;
    answers = [];

  }



  void answer(String content, String answeredBy){
    answers.add({"content" : content, "answeredBy" : answeredBy});
  }

  Map toJSON(){
    var res = {"id" : id, "name" : name, "content" : content, "isAnswered" : isAnswered, "askedBy" : askedBy, "answers" : answers};
    return res;
  }


}
