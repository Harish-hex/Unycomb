part of 'kanban_cubit.dart';

abstract class KanbanState extends Equatable {
  const KanbanState();

  @override
  List<Object?> get props => <Object?>[];
}

class KanbanLoading extends KanbanState {
  const KanbanLoading();
}

class KanbanLoaded extends KanbanState {
  const KanbanLoaded(this.project);

  final ProjectModel project;

  @override
  List<Object?> get props => <Object?>[project];
}

class KanbanError extends KanbanState {
  const KanbanError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
