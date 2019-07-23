import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      // Title
      title: "Simple Material App",
      // Home
      home: MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  // init the step to 0th position
  int current_step = 0;
  List<Step> my_steps = [
    Step(
        // Title of the Step
        title: Text("Step 1"),
        // Content, it can be any widget here. Using basic Text for this example
        content: Text("Hello!"),
        isActive: true),
    Step(
        title: Text("Step 2"),
        content: Text("World!"),
        // You can change the style of the step icon i.e number, editing, etc.
        state: StepState.editing,
        isActive: true),
    Step(
        title: Text("Step 3"),
        content: Text("Hello World!"),
        isActive: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        // Title
        title: Text("Simple Material App"),
      ),
      // Body
      body: Container(
          child: Stepper(
        // Using a variable here for handling the currentStep
        currentStep: this.current_step,
        // List the steps you would like to have
        steps: my_steps,
        // Define the type of Stepper style
        // StepperType.horizontal :  Horizontal Style
        // StepperType.vertical   :  Vertical Style
        type: StepperType.vertical,
        // Know the step that is tapped
        onStepTapped: (step) {
          // On hitting step itself, change the state and jump to that step
          setState(() {
            // update the variable handling the current step value
            // jump to the tapped step
            current_step = step;
          });
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
