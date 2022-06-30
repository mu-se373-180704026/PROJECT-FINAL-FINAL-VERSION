



class Answer {

  String? content;
  String? answeredBy;


  Answer(String content, String answeredBy){
    this.answeredBy = answeredBy;
    this.content = content;

  }

  Map toJSON(){
    return {"answeredBy" : answeredBy, "content" : content};
  }


}
