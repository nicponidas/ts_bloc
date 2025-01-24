import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_sheet/models/task_type_model.dart';
import 'package:time_sheet/repositories/task_type_repository.dart';

part 'task_type_event.dart';

part 'task_type_state.dart';

class TaskTypeBloc extends Bloc<TaskTypeEvent, TaskTypeState> {
  final TaskTypeRepository _taskTypeRepository;

  TaskTypeBloc({required TaskTypeRepository taskTypeRepository})
      : _taskTypeRepository = taskTypeRepository,
        super(TaskTypeInitial()) {
    on<TaskTypeLoad>(
      (event, emit) async {
        emit(TaskTypeLoading());
        try {
          final taskTypes = await _taskTypeRepository.getType();
          emit(TaskTypeLoaded(taskTypes: taskTypes));
        } catch (e) {
          emit(TaskTypeError(error: e.toString()));
        }
      },
    );

    on<TaskTypeAdd>(
      (event, emit) async {
        emit(TaskTypeLoading());
        try {
          _taskTypeRepository.taskTypeAdd(event.taskTypes);
          final taskType = await _taskTypeRepository.getType();
          emit(TaskTypeLoaded(taskTypes: taskType));
        } catch (e) {
          emit(TaskTypeError(error: e.toString()));
        }
      },
    );

    on<TaskTypeUpdate>(
      (event, emit) async {
        emit(TaskTypeLoading());
        try {
          _taskTypeRepository.taskTypeUpdate(event.taskTypes);
          final taskType = await _taskTypeRepository.getType();
          emit(TaskTypeLoaded(taskTypes: taskType));
        } catch (e) {
          emit(
            TaskTypeError(
              error: e.toString(),
            ),
          );
        }
      },
    );
  }
}
