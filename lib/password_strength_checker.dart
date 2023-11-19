import 'package:flutter/cupertino.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PasswordUIWithChecker(),
    );
  }
}

class PasswordUIWithChecker extends StatefulWidget {
  const PasswordUIWithChecker({Key? key}) : super(key: key);

  @override
  State<PasswordUIWithChecker> createState() => _PasswordUIWithCheckerState();
}

class _PasswordUIWithCheckerState extends State<PasswordUIWithChecker> {
  late String password;
  bool isObscure = false;
  double strength = 0;

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  String displayText = 'Please enter a password';

  void checkPassword(String value) {
    password = value.trim();

    if (password.isEmpty) {
      setState(() {
        strength = 0;
        displayText = 'Please enter you password';
      });
    } else if (password.length < 6) {
      setState(() {
        strength = 1 / 4;
        displayText = 'Your password is too short';
      });
    } else if (password.length < 8) {
      setState(() {
        strength = 2 / 4;
        displayText = 'Your password is acceptable but not strong';
      });
    } else {
      if (!letterReg.hasMatch(password) || !numReg.hasMatch(password)) {
        setState(() {
          strength = 3 / 4;
          displayText = 'Your password is strong';
        });
      } else {
        setState(() {
          strength = 1;
          displayText = 'Your password is great';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: strength <= 1 / 4
                ? Colors.red
                : strength == 2 / 4
                    ? Color.fromARGB(255, 223, 223, 102)
                    : strength == 3 / 4
                        ? Colors.blue
                        : Color.fromARGB(255, 52, 240, 58),
            title: const Text('Password UI With Progress Checker'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => checkPassword(value),
                  obscureText: isObscure,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: strength <= 1 / 4
                                  ? Colors.red
                                  : strength == 2 / 4
                                      ? Colors.yellow
                                      : strength == 3 / 4
                                          ? Colors.blue
                                          : Colors.green,
                              width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      prefixIcon: const Icon(CupertinoIcons.lock, size: 30),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Password'),
                ),
                const SizedBox(
                  height: 30,
                ),
                LinearProgressIndicator(
                  value: strength,
                  backgroundColor: Color.fromARGB(255, 173, 173, 173),
                  color: strength <= 1 / 4
                      ? Colors.red
                      : strength == 2 / 4
                          ? Colors.yellow
                          : strength == 3 / 4
                              ? Colors.blue
                              : Colors.green,
                  minHeight: 12,
                ),
                const SizedBox(height: 20),
                Text(
                  displayText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: strength <= 1 / 4
                          ? Colors.red
                          : strength == 2 / 4
                              ? Colors.yellow
                              : strength == 3 / 4
                                  ? Colors.blue
                                  : Colors.green),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: strength < 1 / 2 ? null : () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      strength <= 1 / 4
                          ? Colors.red
                          : strength == 2 / 4
                              ? Colors.yellow
                              : strength == 3 / 4
                                  ? Colors.blue
                                  : Colors.green,
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
