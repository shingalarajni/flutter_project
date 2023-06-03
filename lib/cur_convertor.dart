import 'dart:convert';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Cur_Con extends StatefulWidget {
  const Cur_Con({Key? key}) : super(key: key);

  @override
  State<Cur_Con> createState() => _Cur_ConState();
}

class _Cur_ConState extends State<Cur_Con> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  String rate="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency Convertor"),
      ),
      body: Column(
        children: [
          TextField(
            controller: t1,
            decoration: InputDecoration(hintText: "Enter Amount"),
          ),
          TextField(
            onTap: () {
              showCurrencyPicker(
                context: context,
                showFlag: true,
                showCurrencyName: true,
                showCurrencyCode: true,
                onSelect: (Currency currency) {
                  print('Select currency: ${currency.code}');
                  t2.text="${currency.code}";
                },
              );
            },
            controller: t2,
            decoration: InputDecoration(hintText: "From"),
          ),
          TextField(onTap: () {
            showCurrencyPicker(
              context: context,
              showFlag: true,
              showCurrencyName: true,
              showCurrencyCode: true,
              onSelect: (Currency currency) {
                print('Select currency: ${currency.code}');
                t3.text="${currency.code}";
              },
            );
          },
            controller: t3,
            decoration: InputDecoration(hintText: "To"),
          ),
          ElevatedButton(onPressed: () async {
            String to=t3.text;
            String from =t2.text;
            String amount=t1.text;
            var url = Uri.parse('https://cdmicreative.000webhostapp.com/cur_convertor.php');
            var response = await http.post(url, body: {'to': '$to', 'from': '$from','amount':'$amount'});
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
            Map m=jsonDecode(response.body);
            print(m);
            rate=m['info']['rate'].toString();
            //import 'package:currency_picker/currency_picker.dart';
            //api layer
            setState(() {

            });
          }, child: Text("Convert")),
          Text("Rate:$rate")
        ],
      ),
    );
  }
}
