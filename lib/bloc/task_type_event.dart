part of 'task_type_bloc.dart';

abstract class TaskTypeEvent extends Equatable {
  const TaskTypeEvent();

  @override
  List<Object> get props => [];
}

class TaskTypeLoad extends TaskTypeEvent {}

class TaskTypeAdd extends TaskTypeEvent {
  final TaskTypeModel taskTypes;

  const TaskTypeAdd(this.taskTypes);

  @override
  List<Object> get props => [taskTypes];
}

class TaskTypeRemove extends TaskTypeEvent {
  final TaskTypeModel taskTypes;

  const TaskTypeRemove(this.taskTypes);

  @override
  List<Object> get props => [taskTypes];
}
class TaskTypeUpdate extends TaskTypeEvent{
  final TaskTypeModel taskTypes;

  const TaskTypeUpdate(this.taskTypes);

  @override
  List<Object> get props => [taskTypes];
}
