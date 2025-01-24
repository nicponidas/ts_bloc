import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/client_bloc.dart';
import 'package:time_sheet/bloc/job_bloc.dart';
import 'package:time_sheet/bloc/task_bloc.dart';
import 'package:time_sheet/bloc/task_type_bloc.dart';
import 'package:time_sheet/pages/home_page.dart';
import 'package:time_sheet/repositories/client_repository.dart';
import 'package:time_sheet/repositories/job_repository.dart';
import 'package:time_sheet/repositories/task_repository.dart';
import 'package:time_sheet/repositories/task_type_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClientBloc(clientRepository: ClientRepository())
            ..add(ClientLoad()),
        ),
        BlocProvider(
          create: (context) =>
              JobBloc(jobRepository: JobRepository())..add(JobLoad()),
        ),
        BlocProvider(
          create: (context) =>
              TaskBloc(taskRepository: TaskRepository())..add(TaskLoad()),
        ),
        BlocProvider(
            create: (context) =>
                TaskTypeBloc(taskTypeRepository: TaskTypeRepository())
          ..add(TaskTypeLoad())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
