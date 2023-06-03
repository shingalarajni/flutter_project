import 'dart:convert';
import 'dart:io';
import 'package:crud_img/view_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'cur_convertor.dart';

void main() {
  print("Hello Testing");
  print("good morning");
  runApp(MaterialApp(
    home: Cur_Con(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool is_image = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: Column(
        children: [
          TextField(
            controller: t1,
          ),
          TextField(
            controller: t2,
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    image = await picker.pickImage(source: ImageSource.camera);
                    is_image = true;
                    setState(() {});
                  },
                  child: Text("Upload")),
              Container(
                height: 70,
                width: 70,
                child: (is_image)
                    ? Image.file(File(image!.path))
                    : Icon(Icons.supervised_user_circle_outlined),
              )
            ],
          ),
          ElevatedButton(onPressed: () async {
            String name,contact,image_path;
            name=t1.text;
            contact=t2.text;
            image_path=base64Encode(await image!.readAsBytes());
            var url = Uri.parse('https://cdmicreative.000webhostapp.com/add_record.php');
            var response = await http.post(url, body: {'name': '$name', 'contact': '$contact','image':'$image_path'});
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
          }, child: Text("Add Contact")),
          ElevatedButton(onPressed: ()  {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return View_Record();
            },));

          }, child: Text("View Contact"))
        ],
      ),
    );
  }
}
