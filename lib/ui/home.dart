import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> {
  final TextEditingController ageInputController = new TextEditingController();
  final TextEditingController heightInputController =
      new TextEditingController();
  final TextEditingController weightInputController =
      new TextEditingController();
  double bmi;
  String status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: <Widget>[
            Image.asset(
              "images/bmilogo.png",
              height: 100,
              width: 200,
            ),
            Container(
              color: Colors.grey.shade300,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: ageInputController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Insert your age here.",
                            labelText: "Age",
                            icon: Icon(Icons.person)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: heightInputController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Insert your height here.",
                            labelText: "Height (In Centimeters)",
                            icon: Icon(Icons.accessibility)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: weightInputController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Insert your weight here.",
                            labelText: "Weight (In KG)",
                            icon: Icon(Icons.line_weight)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.pinkAccent,
                            textColor: Colors.white,
                            onPressed: bmiCalculator,
                            child: Text("Calculate"),
                          ),
                          RaisedButton(
                            color: Colors.grey,
                            textColor: Colors.white,
                            onPressed: clear,
                            child: Text("Clear"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      bmi == null || bmi <= 0
                          ? ""
                          : "Your BMI is: ${bmi.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      status == null || status.isEmpty ? "" : status,
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void bmiCalculator() {
    setState(() {
      if (ageInputController.text.isEmpty ||
          weightInputController.text.isEmpty ||
          heightInputController.text.isEmpty) {
        return null;
      }
      double weight = double.parse(weightInputController.text);
      double heightInCm = double.parse(heightInputController.text);

      if (heightInCm == 0 || weight == 0) {
        return -1;
      }
      double heightInMeter = heightInCm / 100;
      double meterSquare = heightInMeter * heightInMeter;
      bmi = weight / meterSquare;
      status = getWeightStatus(bmi);
    });
  }

  void clear() {
    setState(() {
      weightInputController.clear();
      ageInputController.clear();
      heightInputController.clear();
      bmi = null;
      status = null;
    });
  }

  String getWeightStatus(double bmi) {
    if (bmi == null || bmi <= 0) {
      return "";
    }
    if (bmi >= 18.5 && bmi <= 24.9) {
      return "NORMAL";
    } else if (bmi < 18.5) {
      return "UNDERWEIGHT";
    } else if (bmi > 24.9 && bmi < 30) {
      return "OVERWEIGHT";
    } else if (bmi >= 30) {
      return "OBESE";
    }
  }
}
