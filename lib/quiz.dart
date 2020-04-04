import 'package:flutter/material.dart';
import './main-drawer.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestion = 0;
  int score = 0;
  var quiz = [
    {
      "title": "The Question 1",
      "answers": [
        {"answer": "Answer 11", "correct": false},
        {"answer": "Answer 12", "correct": true},
        {"answer": "Answer 13", "correct": false},
      ]
    },
    {
      "title": "The Question 2",
      "answers": [
        {"answer": "Answer 14", "correct": false},
        {"answer": "Answer 15", "correct": false},
        {"answer": "Answer 16", "correct": true},
      ]
    },
    {
      "title": "The Question 3",
      "answers": [
        {"answer": "Answer 111", "correct": true},
        {"answer": "Answer 124", "correct": true},
        {"answer": "Answer 139", "correct": false},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Center(
            child: Text(
              "Quiz",
              style: TextStyle(backgroundColor: Colors.grey),
            ),
          ),
        ),
        body: currentQuestion >= quiz.length
            ? (Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                ListTile(
                  title: Center(
                      child: Text(
                    "Score ${(score / quiz.length * 100).toStringAsFixed(2)}%",
                  )),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.purple,
                ),
                ListTile(
                  title: MaterialButton(
                    color: Colors.purple,
                    child: Text("Reprendre?"),
                    onPressed: () {
                      setState(() {
                        score = 0;
                        currentQuestion = 0;
                      });
                    },
                  ),
                )
              ],
            ))
            : Container(
                child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text(
                        "Question ${currentQuestion + 1}",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      quiz[currentQuestion]['title'],
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...(quiz[currentQuestion]['answers'] as List).map((answer) {
                    return ListTile(
                      title: RaisedButton(
                        hoverColor: Colors.blueGrey,
                        child: Align(
                          child: Text(
                            answer['answer'],
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        onPressed: () {
                          print("Answer ${answer['answer']} is clicked");
                          if (answer['correct'] == true) {
                            ++score;
                          }
                          setState(() {
                            currentQuestion++;
                          });
                        },
                      ),
                    );
                  }),
                  Divider(
                    color: Colors.blue,
                    thickness: 2,
                  )
                ],
              )));
  }
}
