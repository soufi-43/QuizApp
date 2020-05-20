import 'package:flutter/material.dart';
import 'package:quizapp/services/database.dart';
import 'package:quizapp/views/addquestion.dart';
import 'package:quizapp/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DataBaseService dataBaseService = new DataBaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription,
      };
      await dataBaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AddQuestion()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val) => val.isEmpty ? "enter ImageUrl" : null,
                      decoration: InputDecoration(hintText: "Quiz Image Url"),
                      onChanged: (val) {
                        quizImageUrl = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "enter Quiz Title" : null,
                      decoration: InputDecoration(hintText: "Quiz Quiz Title"),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "enter Quiz description" : null,
                      decoration:
                          InputDecoration(hintText: "Quiz Quiz description"),
                      onChanged: (val) {
                        quizDescription = val;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: (){
                          createQuizOnline();
                        },

                        child: blueButton(context, "Create Quiz")),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
