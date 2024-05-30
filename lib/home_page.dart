import 'package:flutter/material.dart';
import 'package:row_city/const.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maroon,
        automaticallyImplyLeading: false,
        title: const Text("Row City", style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
