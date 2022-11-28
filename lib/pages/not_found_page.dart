import 'package:flutter/material.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  NotFoundPageState createState() => NotFoundPageState();
}

class NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Found"),
      ),
      body: const Center(
        child: Text("Sorry, We couldn't find this page"),
      ),
    );
  }
}
