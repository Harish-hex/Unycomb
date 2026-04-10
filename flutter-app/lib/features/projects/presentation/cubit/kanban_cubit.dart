import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nexus/domain/repositories/project_repository.dart';
import 'package:nexus/shared/models/project_model.dart';
import 'package:nexus/shared/models/task_model.dart';

part 'kanban_state.dart';

class KanbanCubit extends Cubit<KanbanState> {
  KanbanCubit({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository,
        super(const KanbanLoading());

  final ProjectRepository _projectRepository;

  Future<void> load(String projectId) async {
    emit(const KanbanLoading());
    try {
      final ProjectModel? project = await _projectRepository.getProjectById(
        projectId,
      );
      if (project == null) {
        emit(const KanbanError('Project not found.'));
        return;
      }
      emit(KanbanLoaded(project));
    } catch (error) {
      emit(KanbanError(error.toString()));
    }
  }

  Future<void> moveTask({
    required String projectId,
    required String taskId,
    required TaskStatus status,
  }) async {
    await _projectRepository.updateTaskStatus(
      projectId: projectId,
      taskId: taskId,
      status: status,
    );
    await load(projectId);
  }
}
