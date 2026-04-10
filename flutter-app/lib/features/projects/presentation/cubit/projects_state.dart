part of 'projects_cubit.dart';

abstract class ProjectsState extends Equatable {
  const ProjectsState();

  @override
  List<Object?> get props => <Object?>[];
}

class ProjectsLoading extends ProjectsState {
  const ProjectsLoading();
}

class ProjectsLoaded extends ProjectsState {
  const ProjectsLoaded(this.projects);

  final List<ProjectModel> projects;

  @override
  List<Object?> get props => <Object?>[projects];
}

class ProjectsError extends ProjectsState {
  const ProjectsError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
