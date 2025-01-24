import 'package:time_sheet/dummy_data/dummy_data.dart';
import 'package:time_sheet/models/task_type_model.dart';

class TaskTypeRepository {
  final List<TaskTypeModel> _taskTypes = listOfTaskType;
  
  Future<List<TaskTypeModel>> getType () async => _taskTypes..sort((e1, e2) => e1.name.compareTo(e2.name)) ;

  void taskTypeAdd(TaskTypeModel taskType)=> _taskTypes.add(taskType);

  void taskTypeUpdate(TaskTypeModel taskType){
    final index = _taskTypes.indexWhere((e)=> e.id == taskType.id);
    if (index != -1){
      _taskTypes[index] = taskType;
    }
  }
}
