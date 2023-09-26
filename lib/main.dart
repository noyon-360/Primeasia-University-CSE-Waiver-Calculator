import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pau_waiver/sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pau_waiver/Setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PAU Waiver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PAU Waiver'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userSetCredit = '';
  String userSetSemester = '';

  @override
  void initState()
  {
    super.initState();
    loadDefaultValue();
  }

  void loadDefaultValue()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userSetCredit = prefs.getString('uCredit')!;
      userSetSemester = prefs.getString('uSemester')!;
    });
  }

  final textController = TextEditingController();
  final textSecondController = TextEditingController();

  //User input credit and waiver input variable in main.dart home page
  var creditValue = '';
  var waiverValue = '';

  var result = '';

  calculation(){
    int uCreditC = userSetCredit.isNotEmpty ? int.tryParse(userSetCredit) ?? int.parse(userSetCredit) : 2200;
    int uSemC = userSetSemester.isNotEmpty ? int.tryParse(userSetSemester) ?? int.parse(userSetSemester) : 5500;

    var credit = int.parse(creditValue) * uCreditC;
    var waiver = credit * (int.parse(waiverValue) * 0.01);
    var xY = credit - waiver;
    double xYZ = xY + uSemC;
    int total = xYZ.toInt();
    result = total.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          if((userSetCredit != '2200') | (userSetSemester != '5500'))
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Setting()));
            }, icon: const Icon(Icons.change_circle_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(                                                    //Credit Input
                padding: const EdgeInsets.all(15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: textController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Credit',
                    hintText: 'Enter your total credit',
                    suffixIcon: IconButton(onPressed: () {
                      textController.clear();
                      },
                      icon: const Icon(Icons.clear),)
                  ),
                ),
              ),
              Padding(                                                            //Waiver Input
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: textSecondController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Waiver',
                    hintText: 'Enter your total waiver',
                    suffixIcon: IconButton(onPressed: (){
                        textSecondController.clear();
                    },
                      icon: const Icon(Icons.close),)
                  ),
                ),
              ),
              Padding(                                                             // Button Calculate
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                        child: const Text("Calculate",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                        onPressed: (){
                            setState(() {
                              if((textController.text != "") & (textSecondController.text != ""))
                                {
                                  creditValue = textController.text.toString();
                                  waiverValue = textSecondController.text.toString();
                                  calculation();
                                }
                              else {
                                Fluttertoast.showToast(
                                  msg: "No values",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,);
                              }
                            });
                        },
                    ),
                  ),
                ),
              ),

              Padding(                                                          //Button Show Result and Copy
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 1.0),
                child: SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                      padding: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                      onPressed: () async {
                      if(result != '') {
                        await Clipboard.setData(ClipboardData(text: result));
                        Fluttertoast.showToast(
                            msg: "Copy $result",
                            // ignore: use_build_context_synchronously
                            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                            toastLength: Toast.LENGTH_LONG);
                      }
                      else {
                        Fluttertoast.showToast(
                          msg: "No Result",
                          backgroundColor: Theme.of(context).colorScheme.inversePrimary,);
                      }
                      },
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(result.isEmpty)
                            const Center(child: Text("Fee", style: TextStyle(fontSize: 18))),
                          if(result.isNotEmpty)
                            Expanded(child: Center(child: SingleChildScrollView(scrollDirection: Axis.horizontal,child: Text(result, style: const TextStyle(fontSize: 18),)))),
                          if(result != "")
                            const Padding(padding: EdgeInsets.only(left: 10.0),
                              child: Icon(Icons.copy,),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30))
            ],
          ),
        ),
      )
    );
  }
}
