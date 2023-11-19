import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PasswordUIWithChecker2(),
      ),
    );

class PasswordUIWithChecker2 extends StatefulWidget {
  const PasswordUIWithChecker2({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PasswordUIWithChecker2State createState() => _PasswordUIWithChecker2State();
}

class _PasswordUIWithChecker2State extends State<PasswordUIWithChecker2> {
  bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasSymbols = false;
  bool _hasUpperCase = false;
  bool _hasLowerCase = false;

  void passwordValidator(String password) {
    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (AppRegExp.numericRegex.hasMatch(password)) {
        _hasPasswordOneNumber = true;
      }

      _hasSymbols = false;
      if (AppRegExp.symRegex.hasMatch(password)) _hasSymbols = true;

      _hasUpperCase = false;
      if (AppRegExp.hasUpperCase.hasMatch(password)) _hasUpperCase = true;

      _hasLowerCase = false;
      if (AppRegExp.hasLowerCase.hasMatch(password)) _hasLowerCase = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue,
          title: const Text(
            "Password UI With Checkbox",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 15, 15, 15),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildForm(),
              const SizedBox(height: 30),
              CustomTile(
                isCheck: _isPasswordEightCharacters,
                title: "Contains at least 8 characters",
              ),
              const SizedBox(height: 10),
              CustomTile(
                isCheck: _hasUpperCase,
                title: "Contains Uppercase",
              ),
              const SizedBox(height: 10),
              CustomTile(
                isCheck: _hasLowerCase,
                title: "Contains Lowercase",
              ),
              const SizedBox(height: 10),
              CustomTile(
                isCheck: _hasPasswordOneNumber,
                title: "Contains at least 1 number",
              ),
              const SizedBox(height: 10),
              CustomTile(
                isCheck: _hasSymbols,
                title: "Contains Symbols (?#@)",
              ),
              const SizedBox(height: 50),
              MaterialButton(
                height: 40,
                minWidth: double.infinity,
                onPressed: () {},
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: const Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Set your password",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(
          "Kindly generate a strong password that following criteria.",
          style:
              TextStyle(fontSize: 16, height: 1.5, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return TextField(
      onChanged: (password) => passwordValidator(password),
      obscureText: !_isVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white)),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          icon: _isVisible
              ? const Icon(
                  Icons.visibility,
                  color: Colors.blue,
                  size: 30,
                )
              : const Icon(
                  Icons.visibility_off,
                  color: Colors.red,
                  size: 30,
                ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blue, width: 2)),
        hintText: "Write a Password",
        hintStyle: const TextStyle(color: Colors.white),
        labelText: "Password",
        labelStyle: const TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.title,
    required this.isCheck,
  });

  final bool isCheck;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: isCheck ? Colors.green : Colors.transparent,
              border: isCheck
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 22),
        )
      ],
    );
  }
}

class AppRegExp {
  AppRegExp._();

  static final numericRegex = RegExp(r'[0-9]');
  static final symRegex = RegExp(r'[!@#$%^&*()]');
  static final hasUpperCase = RegExp(r'[A-Z]');
  static final hasLowerCase = RegExp(r'[a-z]');
}
