import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fourm/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main(List <String> args) async{
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  }

  else{
    await Firebase.initializeApp();
  }

  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  final name=TextEditingController();
  final email=TextEditingController();
  final mobile=TextEditingController();
  final purpose=TextEditingController();

  String dValue="A";
  List d1=["A","B","C"];

  String personValue="Mr.A";

  List list1=["Mr.A","Mr.B","Mr.C"];
  void listchoose(String dValue) {
    if (dValue == "A") {
      setState(() {
        personValue = "Mr.A";
        list1 = ["Mr.A", "Mr.B", "Mr.C"];
      });
    } else if (dValue == "B") {
      setState(() {
        personValue = "Mr.D";
        list1 = ["Mr.D", "Mr.E", "Mr.F"];
      });
    } else if (dValue == "C") {
      setState(() {
        personValue = "Mr.G";
        list1 = ["Mr.G", "Mr.H", "Mr.I"];
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(

      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar:AppBar(
          title: const Text ("Visiting Form"),

        ),
        body:  Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(

                    child: TextField(
                          controller: name,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: const TextStyle(
                          fontFamily: 'Times New Roman',
                          fontSize: 15.0,
                          fontWeight:FontWeight.w500,
                        ),
                        border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: (){
                              name.clear();
                            },
                            icon: const Icon(Icons.clear),
                          )
                      ),
                      autofillHints: const [AutofillHints.name],
                    ),

                  ),//name
                Card(
                    child: TextField(
                            controller: mobile,
                            decoration: InputDecoration(
                              hintText: 'Mobile No.',
                              hintStyle: const TextStyle(
                                fontFamily: 'Times New Roman',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ) ,
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                    mobile.clear();
                                },
                                icon: const Icon(Icons.clear),

                              ),
                            ),
                      autofillHints: const [AutofillHints.telephoneNumber],
                    ),

                  ),//mobile no.
                Card(
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ) ,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          email.clear();
                        },
                        icon: const Icon(Icons.clear),

                      ),
                    ),
                    autofillHints: const [AutofillHints.email],
                  ),
                ),//Email
                Container(
                        padding:const EdgeInsets.symmetric(horizontal: 12,),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),color:Colors.white10,
                            border: Border.all(color: Colors.white54)
                        ),

                          child: DropdownButton(value: dValue,
                            items: d1.map((e)
                            {
                              return DropdownMenuItem(value: e, child: Text(e));
                            }
                            ).toList(),

                            underline: Container(),
                            isExpanded: true,
                            style: const TextStyle(
                              fontFamily: 'Times New Roman',
                              fontSize: 15.0,
                              fontWeight:FontWeight.w500,
                              color: Colors.white60
                            ),
                            onChanged: (val){
                            setState(() {
                              dValue= val as String;
                              listchoose(dValue);
                            },
                            );
                            }
                      ),

                      ),//Department
                Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),color:Colors.white10,
                          border: Border.all(color: Colors.white54)
                        ),

                          child: DropdownButton(value: personValue,
                              items: list1.map((e)
                              {
                                return DropdownMenuItem(value: e, child: Text(e));
                              }).toList(),
                              isExpanded: true,
                              underline: Container(),
                              style: const TextStyle(
                                fontFamily: 'Times New Roman',
                                fontSize: 15.0,
                                fontWeight:FontWeight.w500,
                                color: Colors.white60,
                              ),
                              onChanged: (val){
                                setState(() {
                                  personValue= val as String;
                                },
                                );
                              }
                          ),

                      ),//Whom to meet
                Card(
                    child: TextField(
                      controller: purpose,
                      decoration: InputDecoration(
                        hintText: 'Purpose of meet',
                        hintStyle: const TextStyle(
                          fontFamily: 'Times New Roman',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ) ,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            purpose.clear();
                          },
                          icon: const Icon(Icons.clear),

                        ),
                      ),
                    ),
                  ),//Purpose
                ElevatedButton(
                    onPressed: (){
                    CollectionReference collRef = FirebaseFirestore.instance.collection('Client');
                    collRef.add({
                      'name' : name.text,
                      'email' : email.text,
                      'mobile no.' : mobile.text,
                      'purpose' : purpose.text,
                      'time' : FieldValue.serverTimestamp(),
                    }
                    );
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child:const Text('Enter')
                      ),

              ],
            ),
        ),
        ),


    );
  }
}