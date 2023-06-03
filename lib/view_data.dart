import 'dart:convert';

import 'package:crud_img/mymodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class View_Record extends StatefulWidget {
  const View_Record({Key? key}) : super(key: key);

  @override
  State<View_Record> createState() => _View_RecordState();
}

class _View_RecordState extends State<View_Record> {
  get_data() async {
    var url =
        Uri.parse('https://cdmicreative.000webhostapp.com/view_recored.php');
    var response = await http.get(url);
    List l = [];
    if (response.statusCode == 200) {
      l = jsonDecode(response.body);
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    print("hi...");
    return Scaffold(
      appBar: AppBar(
        title: Text("View Contact"),
      ),
      body: FutureBuilder(
        future: get_data(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            List l = snapshot.data as List;
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                My_Model m = My_Model.fromJson(l[index]);
                print(m);
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdmicreative.000webhostapp.com/${m.image}")),
                  title: Text("${m.name}"),
                  subtitle: Text("${m.contact}"),
                );
              },
            );
          } else
            return Text("");
        },
      ),
    );
  }
}
