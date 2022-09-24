import 'dart:convert' show base64, json, jsonDecode, jsonEncode, utf8;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'Backend.dart';
import 'back.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.greenAccent,

      ),
      home: const MyHomePage(title: "Open Banking"),
    );
  }
}
bool high = false;
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  void initState() {
  makePostRequest();
  }
  @override
  Otp? usere;


  Future makePostRequest() async {
    String url ="https://tr5vfx4bag.execute-api.us-east-1.amazonaws.com/dev/axis";
    final urle = Uri.parse(url);
    Map<String, String> headers = {
      'x-ibm-client-id': "43a572be-7544-477e-8f46-91763192d495",
      'x-ibm-client-secret': "wW0kA7yC6wE5lN0nE5gQ2gD0tW3iU5xJ1uL7fV1iM0oP1sI0aI",
      'x-axis-test-id': "1",
      'content-type': "application/json",
      'accept': "application/json"
    };
   // final msg = jsonEncode({"BalanceEnquiryRequest":{"SubHeader":{"requestUUID":"97f6b07e-b82d-4fed-9c57-80088ba23e30","serviceRequestId":"NB.GEN.PDT.ELIG","serviceRequestVersion":"1.0","channelId":"TEST"},"BalanceEnquiryRequestBody":{"accountId":"565573123"}}

   // });
    final msg = jsonEncode({"CustomerConsentOTPRequest":{"SubHeader":{"requestUUID":"97f6b07e-b82d-4fed-9c57-80088ba23e30","serviceRequestId":"NB.GEN.PDT.ELIG","serviceRequestVersion":"1.0","channelId":"TEST"},"CustomerConsentOTPRequestBody":{"mobileNumber":"XXXXXXXXXX","applicationReferenceId":"XXXXXXX123345678","deviceId":"XXXXXXXX1854","otpReferenceId":"OTP123"}}});

    final response = await post(urle, headers: headers, body: msg
    );
    var r = json.decode(response.body);
    setState(() {
      usere = Otp.fromJson(r);
    });
    print('Body: ${response.body}');
    print('Status code: ${response.statusCode}');
    //Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
      //otps = otpFromJson(response.body) as List<Otp>;
      //print (otps);
    //print(data['name']);
    //List data = jsonDecode(response.body);
    /*data.forEach((element) {
      Map obj = element;
      Map CustomerConsentOTPResponseBody = obj['CustomerConsentOTPResponseBody'];
      String isOTPGenerated = CustomerConsentOTPResponseBody['isOTPGenerated'];
      print(isOTPGenerated);
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Banking",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.tealAccent,
      ),
      body: Center(

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Give an Phone Number to get a validation token",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Container(
              width: 350,
              child:TextField(
              obscureText: false,
              /*decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number'
              ),*/
              /*decoration: InputDecoration(
                icon: Icon(Icons.send),
                hintText: 'Phone Nos',
                helperText: 'Helper Text',
                counterText: '0 characters',
                border: OutlineInputBorder(borderSide: BorderSide(
                    color: Colors.red,
                    width: 5.0),),
              ),*/
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(40),
                  filled: true,
                  fillColor: Colors.tealAccent,
                  border: OutlineInputBorder(),
                  labelText: 'Please Fill in Phone Nos',
                  hintText: '90........',
                  //helperText: 'help',
                  //counterText: 'counter',
                  //icon: Icon(Icons.phone),
                  prefixIcon: Icon(Icons.phone_iphone_sharp),
                  suffixIcon: Icon(Icons.park),
                ),

            ),),
            SizedBox(height: 20,),
            /*Text(
              'Axis Bank',
              style: Theme.of(context).textTheme.headline4,
            ),*/
             high ==true ?Container(height:150,width: 350,  padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                 decoration: new BoxDecoration(
                     //color: const Color(0xFF66BB6A),
                    color: Colors.tealAccent,
                     boxShadow: [new BoxShadow(
                       color: Colors.black45,
                       blurRadius: 20.0,
                     ),]
                 ),child:Text(usere!.customerConsentOtpResponse.customerConsentOtpResponseBody.validationToken,
               style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w700),)) :Container(),
           // high ==true ?Text(usere!.customerConsentOtpResponse.customerConsentOtpResponseBody.validationToken,
             // style: TextStyle(fontSize: 10),) :Container(),
            SizedBox(
              height: 12,
            ),
            Container(
                decoration: new BoxDecoration(
                    color: Colors.black,
                    boxShadow: [new BoxShadow(
                      color: Colors.black,
                      blurRadius: 20.0,
                    ),]
                ),
              child:RaisedButton(
              onPressed: () {
                setState(() {
                  high = true;
                });
              },
              child: const Text('Submit'),

            ),)
           /* Text(
              usere!.customerConsentOtpResponse.customerConsentOtpResponseBody.validationToken,
              style: TextStyle(fontSize: 10),
            ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: makePostRequest,
        tooltip: 'Increment',
        foregroundColor: Colors.greenAccent,
        child: const Icon(Icons.add,color: Colors.grey,),
        backgroundColor: Colors.tealAccent,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
