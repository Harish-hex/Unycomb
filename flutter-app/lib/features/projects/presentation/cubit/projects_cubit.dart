import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nexus/domain/repositories/project_repository.dart';
import 'package:nexus/shared/models/project_model.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository,
        super(const ProjectsLoading());

  final ProjectRepository _projectRepository;

  Future<void> load() async {
    emit(const ProjectsLoading());
    try {
      final List<ProjectModel> projects =
          await _projectRepository.getProjects();
      emit(ProjectsLoaded(projects));
    } catch (error) {
      emit(ProjectsError(error.toString()));
    }
  }
}
