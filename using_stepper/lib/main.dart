import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      // Title
      title: "Simple Material App",
      // Home
      home: new MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => new MyHomeState();
}

class MyHomeState extends State<MyHome> {
  // init the step to 0th position
  int current_step = 0;
  List<Step> my_steps = [
    new Step(
        // Title of the Step
        title: new Text("Step 1"),
        // Content, it can be any widget here. Using basic Text for this example
        content: new Text("Hello!"),
        isActive: true),
    new Step(
        title: new Text("Step 2"),
        content: new Text("World!"),
        // You can change the style of the step icon i.e number, editing, etc.
        state: StepState.editing,
        isActive: true),
    new Step(
        title: new Text("Step 3"),
        content: new Text("Hello World!"),
        isActive: true),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // Appbar
      appBar: new AppBar(
        // Title
        title: new Text("Simple Material App"),
      ),
      // Body
      body: new Container(
          child: new Stepper(
        // Using a variable here for handling the currentStep
        currentStep: this.current_step,
        // List the steps you would like to have
        steps: my_steps,
        // Define the type of Stepper style
        type: StepperType.vertical,
        // Know the step that is tapped
        onStepTapped: (step) {
          // Log function call
          print("onStepTapped : " + step.toString());
        },
        onStepCancel: () {
          // On hitting cancel button, change the state
          setState(() {
            // update the variable handling the current step value
            // going back one step i.e subtracting 1, until its 0
            if (current_step > 0) {
              current_step = current_step - 1;
            } else {
              current_step = 0;
            }
          });
          // Log function call
          print("onStepCancel : " + current_step.toString());
        },
        // On hitting continue button, change the state
        onStepContinue: () {
          setState(() {
            // update the variable handling the current step value
            // going back one step i.e adding 1, until its the length of the step
            if (current_step < my_steps.length - 1) {
              current_step = current_step + 1;
            } else {
              current_step = 0;
            }
          });
          // Log function call
          print("onStepContinue : " + current_step.toString());
        },
      )),
    );
  }
}
