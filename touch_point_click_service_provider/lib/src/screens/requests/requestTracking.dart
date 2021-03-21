import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

class RequestTracking extends StatefulWidget {
  @override
  _RequestTrackingState createState() => _RequestTrackingState();
}

class _RequestTrackingState extends State<RequestTracking> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [stickyHeader()]);
  }

  Widget stickyHeader() {
    return UtilWidget.stickyHeader(
      "Request Id: 45632",
      Column(
        children: [
          stepper(),
        ],
      ),
    );
  }

  int _currentStep = 0;

  void tapped(int step) {
    setState(() => _currentStep = step);
  }

  void stepContinue() {
    if (_currentStep >= 4) return;
    setState(() => _currentStep += 1);
  }

  void stepCancel() {
    if (_currentStep <= 0) return;
    setState(() => _currentStep -= 1);
  }

  Widget stepper() {
    return Stepper(
      currentStep: _currentStep,
      onStepContinue: () {
        stepContinue();
      },
      onStepCancel: () => stepCancel(),
      steps: <Step>[
        Step(
          title: Text("Step 1"),
          content: SizedBox(
            width: 10,
            height: 10,
          ),
          isActive: _currentStep >= 0,
          state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: Text("Step 2"),
          content: SizedBox(
            width: 10,
            height: 10,
          ),
          isActive: _currentStep >= 1,
          state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: Text("Step 3"),
          content: SizedBox(
            width: 10,
            height: 10,
          ),
          isActive: _currentStep >= 2,
          state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: Text("Step 4"),
          content: SizedBox(
            width: 10,
            height: 10,
          ),
          isActive: _currentStep >= 3,
          state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: Text("Step 5"),
          content: SizedBox(
            width: 10,
            height: 10,
          ),
          isActive: _currentStep >= 4,
          state: _currentStep >= 4 ? StepState.complete : StepState.disabled,
        ),
      ],
    );
  }
}
