import 'package:flutter/material.dart';
import 'package:time_sheet/pages/clients_list_page.dart';
import 'package:time_sheet/pages/jobs_list_page.dart';
import 'package:time_sheet/pages/report_page.dart';
import 'package:time_sheet/pages/task_type_page.dart';
import 'package:time_sheet/pages/tasks_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      // bottomNavigationBar: BottomBar(),
      body: Center(
        child: Column(
          spacing: 16.0,
          mainAxisSize: MainAxisSize.values.first,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ClientsListPage(),
                  ),
                );
              },
              label: Text('Clients'),
              icon: Icon(Icons.people),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const JobsListPage(),
                  ),
                );
              },
              label: Text('All Jobs'),
              icon: Icon(Icons.work),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TasksListPage(),
                  ),
                );
              },
              label: Text('My Tasks'),
              icon: Icon(Icons.task),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TaskTypePage(),
                  ),
                );
              },
              label: Text('Type of task'),
              icon: Icon(Icons.settings),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ReportPage(),
                  ),
                );
              },
              label: Text('Reports'),
              icon: Icon(Icons.report),
            ),
          ],
        ),
      ),
    );
  }
}
