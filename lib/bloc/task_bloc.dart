import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_sheet/models/task_model.dart';
import 'package:time_sheet/repositories/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskInitial()) {
    on<TaskLoad>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await _taskRepository.getTasks();
        emit(
          TaskLoaded(tasks: tasks),
        );
      } catch (e) {
        emit(
          TaskError(
            error: e.toString(),
          ),
        );
      }
    });

    on<TaskAdd>(
      (event, emit) async {
        try {
          _taskRepository.addTask(event.task);
          final tasks = await _taskRepository.getTasks();
          emit(
            TaskLoaded(tasks: tasks),
          );
        } catch (e) {
          emit(
            TaskError(
              error: e.toString(),
            ),
          );
        }
      },
    );

    on<TaskUpdate>(
      (event, emit) async {
        try {
          _taskRepository.updateTask(event.task);
          final tasks = await _taskRepository.getTasks();
          emit(
            TaskLoaded(tasks: tasks),
          );
        } catch (e) {
          emit(
            TaskError(
              error: e.toString(),
            ),
          );
        }
      },
    );

    on<TaskRemove>(
      (event, emit) async {
        try {
          _taskRepository.removeTask(event.task);
          final tasks = await _taskRepository.getTasks();
          emit(
            TaskLoaded(tasks: tasks),
          );
        } catch (e) {
          emit(
            TaskError(
              error: e.toString(),
            ),
          );
        }
      },
    );
  }
}
