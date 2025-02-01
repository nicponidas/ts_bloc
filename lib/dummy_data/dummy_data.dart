import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_sheet/models/client_model.dart';
import 'package:time_sheet/models/job_model.dart';
import 'package:time_sheet/models/task_model.dart';
import 'package:time_sheet/models/task_type_model.dart';
import 'package:time_sheet/models/user_model.dart';

var listOfClient = [
  ClientModel(id: '1', name: 'HP.com', shortName: 'HP', clientColor: Colors.blue),
  ClientModel(id: '2', name: 'RedHat', shortName: 'RH', clientColor: Colors.red),
];
var listOfJobs = [
  JobModel(title: 'job1', id: '1', clientId: '1', jobNumber: 12341, jobUrl: '',),
  JobModel(title: 'job2', id: '2', clientId: '2', jobNumber: 12345, jobUrl: '',),
  JobModel(title: 'job3', id: '3', clientId: '1', jobNumber: 12342, jobUrl: '',),
  JobModel(title: 'job4', id: '4', clientId: '1', jobNumber: 12343, jobUrl: 'https://google.com',),
];
var listOfTask = [
  TaskModel(
      id: '1',
      timeStart: DateTime(2024, 12, 11, 10, 50, 0),
      timeEnd: DateTime(2024, 12, 11, 11, 50, 0),
      timeSummary: 1.00,
      jobId: '1',
      taskTypeId: '1',
      userId: '1'),
  TaskModel(
      id: '1',
      timeStart: DateTime(2025, 01, 06, 10, 50, 0),
      timeEnd: null,
      timeSummary: 0.0,
      jobId: '1',
      taskTypeId: '1',
      userId: '1'),
  TaskModel(
      id: '1',
      timeStart: DateTime(2024, 12, 23, 10, 50, 0),
      timeEnd: DateTime(2024, 12, 24, 10, 55, 0),
      timeSummary: 0.25,
      jobId: '3',
      taskTypeId: '2',
      userId: '1'),
];
var listOfTaskType = [
  TaskTypeModel(id: '1', name: 'page update'),
  TaskTypeModel(id: '2', name: 'publication')
];
var listOfUser = [
  UserModel(
      id: '1',
      fName: 'Paweł',
      lName: 'Jaroń',
      email: 'pawel.jaron@omc.com',
      password: '1234')
];
