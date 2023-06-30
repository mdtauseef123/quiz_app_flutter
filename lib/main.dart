import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(
    const Quizzler(),
  );
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int totalCorrect = 0;
  // List<String> questions = [
  //   "You can lead a cow down stairs but not up stairs.",
  //   "Approximately one quarter of human bones are in the feet.",
  //   "A slug's blood is green."
  // ];
  // List<bool> answers = [false, true, true];
  // Question obj = Question(
  //     q: "You can lead a cow down stairs but not up stairs.", a: false);
  // List<Question> questionBank = [
  //   Question(
  //     "You can lead a cow down stairs but not up stairs.",
  //     false,
  //   ),
  //   Question(
  //     "Approximately one quarter of human bones are in the feet.",
  //     true,
  //   ),
  //   Question(
  //     "A slug's blood is green.",
  //     true,
  //   ),
  // ];
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      if (correctAnswer == userPickedAnswer) {
        totalCorrect++;
        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      quizBrain.nextQuestionNumber();
      if (scoreKeeper.length == quizBrain.getListSize()) {
        int total = scoreKeeper.length;
        Alert(
          context: context,
          title: "Finished!",
          desc: "You've got $totalCorrect/$total correct.",
        ).show();
        totalCorrect = 0;
        scoreKeeper.clear();
        quizBrain.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              //color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                // if (scoreKeeper.length == quizBrain.getListSize()) {
                //   Alert(
                //     context: context,
                //     title: "Finished",
                //     desc: "You've reached the end of the quiz.",
                //   ).show();
                //}
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
