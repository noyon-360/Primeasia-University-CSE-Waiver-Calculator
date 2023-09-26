import 'package:flutter/material.dart';
import 'package:pau_waiver/calculate.dart';
import 'package:pau_waiver/courseList.dart';
import 'package:pau_waiver/Setting.dart';
import 'package:pau_waiver/erp.dart';

import 'about.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
  Widget buildHeader(BuildContext context) => Container(
    color: Theme.of(context).colorScheme.inversePrimary,
    padding: EdgeInsets.only(
      top: 24 + MediaQuery.of(context).padding.top,
      bottom: 24,
    ),
    child: Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50)
          ),
          child: const Image(image:AssetImage('assets/images/pau_logo_png.png')),
        ),

        const SizedBox(height: 12,),
        const Text(
          'Primeasia University',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        const Text(
          'Waiver Calculation',
          style: TextStyle(fontSize: 18, color: Colors.white),
        )
      ],
    ),
  );
  
  Widget buildMenuItems(BuildContext context) =>Wrap(
    children: [
      ListTile(
        leading: const Icon(Icons.percent_outlined),
        title: const Text("Calculate"),
          onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Calculate()));
          },
        ),
      ListTile(
        leading: const Icon(Icons.list_alt_outlined),
        title: const Text("Course List"),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseList()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.account_box_outlined),
        title: const Text("ERP"),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ERP()));
        },
      ),
      const Divider(color: Colors.blueAccent,),
      ListTile(
        leading: const Icon(Icons.settings_outlined),
        title: const Text("Setting"),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Setting()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.more_vert),
        title: const Text("About"),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
        },
      ),
    ],
  );
}
