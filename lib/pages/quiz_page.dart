import "package:flutter/material.dart";

import "../UI/answer_button.dart";
import '../UI/question_text.dart';
import "./score_page.dart";
import "../UI/correct_wrong_overlay.dart";
import '../utils/questions.dart';
import '../utils/quiz.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {

  Questions currentQustion;
  Quiz quiz = new Quiz([
    new Questions("Elon Musk is Human", false),
    new Questions("Pizza is healthy", false),
    new Questions("Flutter is Awesome", true)
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShoulddBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQustion = quiz.nextQuestion;
    questionText = currentQustion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQustion.answes == answer);
    quiz.answer(isCorrect);
    this.setState(() {
     overlayShoulddBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(false, () => handleAnswer(false)), // false button
            new QuestionText(questionText, questionNumber),
            new AnswerButton(true, () => handleAnswer(true)) // true button
          ],
        ),
        overlayShoulddBeVisible ? new CorrectWrongOverlay(isCorrect, () {
          if(quiz.length == questionNumber) {
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)
              )
            );
            return;
          }
          currentQustion = quiz.nextQuestion;
          this.setState(() {
            overlayShoulddBeVisible = false;
            questionNumber = quiz.questionNumber;
            questionText = currentQustion.question;
          });
        }) : new Container()
      ],
    );
  }
}
