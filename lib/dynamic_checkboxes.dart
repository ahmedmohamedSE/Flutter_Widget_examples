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
      theme: ThemeData(useMaterial3: true),
      home: const DynamicCheckboxesExample(),
    );
  }
}

class DynamicCheckboxesExample extends StatefulWidget {
  const DynamicCheckboxesExample({Key? key}) : super(key: key);

  @override
  State<DynamicCheckboxesExample> createState() => _DynamicCheckboxesExampleState();
}

class _DynamicCheckboxesExampleState extends State<DynamicCheckboxesExample> {
  List<Map> categories = [
    {"name": "Swimming", "isChecked": false},
    {"name": "Cycling", "isChecked": false},
    {"name": "Tennis", "isChecked": false},
    {"name": "Boxing", "isChecked": false},
    {"name": "Volleyball ", "isChecked": false},
    {"name": "Bowling ", "isChecked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text('Dynamic Checkboxes',style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),),
            Text(
              'Ahmed Mohamed SE',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Please Choose Your Favorite Category:",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Column(
                children: categories.map((favorite) {
              return CheckboxListTile(
                  activeColor: Colors.blue,
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  value: favorite["isChecked"],
                  title: Text(favorite["name"],style:TextStyle(fontSize: 20)),
                  onChanged: (val) {
                    setState(() {
                      favorite["isChecked"] = val;
                    });
                  });
            }).toList()),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Wrap(
              children: categories.map((favorite) {
                if (favorite["isChecked"] == true) {
                  return Card(
                    elevation: 3,
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            favorite["name"],
                            style: const TextStyle(color: Colors.white,fontSize: 20),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                favorite["isChecked"] = !favorite["isChecked"];
                              });
                            },
                            child: const Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              }).toList(),
            )
          ]),
        ),
      ),
    );
  }
}
