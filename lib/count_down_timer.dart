import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CountDownTimerExample(),
    );
  }
}

class CountDownTimerExample extends StatefulWidget {
  const CountDownTimerExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CountDownTimerExampleState createState() => _CountDownTimerExampleState();
}

class _CountDownTimerExampleState extends State<CountDownTimerExample> with TickerProviderStateMixin {
  late AnimationController controller;

  String get timerString {
    Duration duration = (controller.duration! * controller.value);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Column(
          children: const [
            Text(
              "Count Down Timer",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color:Colors.white),

            ),
            Text(
              "@ahmedmohamedSE",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color:Colors.white),
            ),
          ],
        ),
      ),
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.blue,
                    height:
                        controller.value * MediaQuery.of(context).size.height,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: CircularProgressIndicator(
                                      color: controller.value < 0.4821094
                                          ? Colors.blue
                                          : Colors.white,
                                      backgroundColor: controller.isAnimating
                                          ? const Color.fromARGB(74, 0, 0, 0)
                                          : Colors.deepPurpleAccent,
                                      strokeWidth: 20,
                                      value: controller.value,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "0$timerString",
                                        style: TextStyle(
                                            fontSize: 112.0,
                                            color: controller.value < 0.4821094
                                                ? Colors.blue
                                                : Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: FloatingActionButton.extended(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          controller.isAnimating ? 10 : 20),),
                                  backgroundColor: controller.isAnimating
                                      ? Colors.white
                                      : Colors.blue,
                                  onPressed: () {
                                    if (controller.isAnimating) {
                                      controller.stop();
                                    } else {
                                      controller.reverse(
                                          from: controller.value == 0.0
                                              ? 1.0
                                              : controller.value);
                                    }
                                  },
                                  icon: Icon(size: 30,
                                    controller.isAnimating
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: !controller.isAnimating
                                        ? Colors.white
                                        : Colors.blue,
                                  ),
                                  label: Text(
                                    controller.isAnimating ? "Pause" : "Play",
                                    style: TextStyle(fontSize: 22,
                                      color: !controller.isAnimating
                                          ? Colors.white
                                          : Colors.blue,
                                    ),
                                  )),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
