import 'package:flutter/material.dart';
import 'package:time_sheet/widgets/my_drawer.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Report'),
      ),
    );
  }
}
