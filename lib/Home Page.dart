import 'package:flutter/material.dart';
import 'package:flutter_hivedb_demo/Model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  String? _name, _age;
  bool check = false;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: check
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Name",
                            labelText: "Enter Name"),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return "Enter Name";
                          }
                          return null;
                        },
                        onChanged: (name) {
                          _name = name;
                        },
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Age",
                          labelText: "Enter Age",
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return "Enter Age";
                          }
                          return null;
                        },
                        onChanged: (age) {
                          _age = age;
                        },
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  InfoModel info = InfoModel(_name, _age);
                                  Hive.box('Info').add(info).then((value) =>
                                      Fluttertoast.showToast(
                                          msg: "Info Saved"));
                                  _formKey.currentState?.reset();
                                } else {
                                  check = true;
                                }
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              child: Text('SAVE'))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                _formKey.currentState?.reset();
                                check = false;
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              child: Text('RESET')))
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: Hive.box('Info').listenable(),
                builder: (BuildContext context, Box box, Widget? child) {
                  if (box.values.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        InfoModel info = box.getAt(index);
                        return ListTile(
                          title: Text(info.name),
                          subtitle: Text(info.age),
                          trailing: IconButton(
                              onPressed: () {
                                Hive.box('Info').deleteAt(index);
                              },
                              icon: Icon(Icons.delete)),
                        );
                      },
                      itemCount: box.values.length,
                    );
                  }
                  return Center(
                      child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                          child: Text('Nothing to Show')));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
