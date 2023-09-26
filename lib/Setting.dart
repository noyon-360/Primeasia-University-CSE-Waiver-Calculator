import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});
  String get title => "Setting";

  @override

  // ignore: no_logic_in_create_state
  State<Setting> createState() => _SettingState(onButtonClicked: () {  });
}

class _SettingState extends State<Setting> {
  final Function() onButtonClicked;
  _SettingState({required this.onButtonClicked});

  final settingCreditController = TextEditingController();
  final settingSemesterController = TextEditingController();

  String userCreditValue = '';
  String userSemesterValue = '';

  //Showing uploaded values in a widget
  String userSetCreditViewing = '';
  String userSetSemesterViewing = '';

  @override
  void initState() {
    super.initState();
    showingUserDefaultValues();
  }

  void showingUserDefaultValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userSetCreditViewing = prefs.getString('uCredit')!;
      userSetSemesterViewing = prefs.getString('uSemester')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    settingCreditController.text = userSetCreditViewing.isNotEmpty ? userSetCreditViewing : '2200';
    settingSemesterController.text = userSetSemesterViewing.isNotEmpty ? userSetSemesterViewing : '5500';

    setUserValue () async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('uCredit', userCreditValue);
      await prefs.setString('uSemester', userSemesterValue);

      Fluttertoast.showToast(
        msg: "Change Complete",
        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      );
      Restart.restartApp(webOrigin: '[your main route]');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(                                                    //User Credit Input
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: settingCreditController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Per Credit',
                        hintText: 'Per Credit Cost',
                        suffixIcon: IconButton(onPressed: (){
                          settingCreditController.clear();
                        },
                            icon: const Icon(Icons.close))
                      ),
                    ),
                  ),
                  Padding(                                                    //User Semester Value
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: settingSemesterController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Semester fee',
                        hintText: 'Varsity Semester Fee',
                        suffixIcon: IconButton(onPressed: (){
                          settingSemesterController.clear();
                        },
                            icon: const Icon(Icons.close))
                      ),
                    ),
                  ),
                  Padding(                                                      //Button Default
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              settingCreditController.text = '2200';
                              settingSemesterController.text = '5500';
                            },
                            child: const Text('Default'),
                          ),
                        ),
                        Padding(                                              //Button Change
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              userCreditValue = settingCreditController.text;
                              userSemesterValue = settingSemesterController.text;
                              if((userCreditValue.isEmpty) & (userSemesterValue.isEmpty))
                                {
                                  Fluttertoast.showToast(
                                    msg: "You do not change anything",
                                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                  );
                                }
                              else{
                                  setUserValue();
                                }
                            },
                            child: const Text('Change'),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
}
}
