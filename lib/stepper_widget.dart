import 'package:flutter/material.dart';






void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StepperWidgetExample(),
    );
  }
}

class StepperWidgetExample extends StatefulWidget {
  const StepperWidgetExample({Key? key}) : super(key: key);

  @override
  _StepperWidgetExampleState createState() => _StepperWidgetExampleState();
}

class _StepperWidgetExampleState extends State<StepperWidgetExample> {
  int currentStep = 0;

  bool isVerticalStepper = true;

  _stepTapped(int step) {
    setState(() => currentStep = step);
  }

  _stepContinue() {
    currentStep < 2 ? setState(() => currentStep += 1) : null;
  }

  _stepCancel() {
    currentStep > 0 ? setState(() => currentStep -= 1) : null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue,
          title: const Text('Stepper Widget With Ahmed'),
        ),
        body: Column(
          children: [
            SwitchListTile(activeColor: Colors.blue,
                title: const Text('Vertical Stepper ?',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                            ),),
                subtitle: const Text('vertical/horizontal direction',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),),
                value: isVerticalStepper,
                onChanged: (_) {
                  setState(() {
                    isVerticalStepper = !isVerticalStepper;
                  });
                }),
            const Divider(
              thickness: 3,
              height: 15,color: Color.fromARGB(255, 121, 188, 243),
            ),
            Expanded(
              child: Stepper(elevation: 0.0,
                type: isVerticalStepper
                    ? StepperType.vertical
                    : StepperType.horizontal,
                physics: const ScrollPhysics(),
                currentStep: currentStep,
                onStepTapped: (step) => _stepTapped(step),
                onStepContinue: _stepContinue,
                onStepCancel: _stepCancel,
                steps: [
                  Step(
                    title: const Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    content: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Your name',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),

                  Step(
                    title: const Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    content: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Your mobile number',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  // The third step: Verify phone number
                  Step(
                    title: const Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Verification code',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
