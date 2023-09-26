import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calculate extends StatefulWidget {
  const Calculate({super.key});

  String get title => "Calculate";

  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final totalAmountTextController = TextEditingController();
  final percentageTextController = TextEditingController();

  var totalAmount = '';
  var percentage = '';
  var amount = '';

  percentageCalculation(){
    double pAmount = int.parse(totalAmount)* (int.parse(percentage)*0.01);
    int pAmountInt = pAmount.toInt();
    amount = pAmountInt.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: totalAmountTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Total Amount',
                  hintText: 'Past your total amount',
                  suffixIcon: IconButton(onPressed: (){
                    totalAmountTextController.clear();
                  }, 
                    icon: const Icon(Icons.close),)
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: percentageTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Percentage",
                  hintText: 'Percentage Get',
                  suffixIcon: IconButton(onPressed: (){
                    percentageTextController.clear();
                  },
                    icon: const Icon(Icons.close),)
                ),
              ),
            ),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.only(left: 25, right: 25),
                  ),
                  onPressed: (){
                    setState(() {
                      if((totalAmountTextController.text != '') & (percentageTextController.text != ''))
                        {
                          totalAmount = totalAmountTextController.text.toString();
                          percentage = percentageTextController.text.toString();
                          percentageCalculation();
                        }
                    });
              },
                  child: const Text('Get Percentage',style: TextStyle(fontWeight: FontWeight.w500),)),
            ),

             Padding(
              padding: const EdgeInsets.all(15),
                child: SizedBox(
                  height: 50,
                  width: 170,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                      )
                    ), onPressed: () {},
                    child: Center(child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                          child: Center(child: Text('$amount TK', style: const TextStyle(fontSize: 24, color: Colors.blueAccent),)),
                        )),
                  ),

                ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30))
          ],
        ),
      ),
    );
  }
}

