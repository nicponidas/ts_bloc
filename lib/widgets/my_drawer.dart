import 'package:flutter/material.dart';
import 'package:time_sheet/pages/clients_list_page.dart';
import 'package:time_sheet/pages/home_page.dart';
import 'package:time_sheet/pages/jobs_list_page.dart';
import 'package:time_sheet/pages/report_page.dart';
import 'package:time_sheet/pages/task_type_page.dart';
import 'package:time_sheet/pages/tasks_list_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
            },
            label: Text('Home'),
            icon: Icon(Icons.home),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientsListPage(),
              ),
            ),
            label: Text('Clients'),
            icon: Icon(Icons.people),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JobsListPage(),
              ),
            ),
            label: Text('All Jobs'),
            icon: Icon(Icons.work),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TasksListPage(),
              ),
            ),
            label: Text('Tasks'),
            icon: Icon(Icons.task),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TaskTypePage(),
              ),
            ),
            label: Text('Type of task'),
            icon: Icon(Icons.settings),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ReportPage(),
                ),
              );
            },
            label: Text('Reports'),
            icon: Icon(Icons.report),
          )
        ],
      ),
    ));
  }
}
