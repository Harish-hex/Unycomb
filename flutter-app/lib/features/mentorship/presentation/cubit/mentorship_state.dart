part of 'mentorship_cubit.dart';

abstract class MentorshipState extends Equatable {
  const MentorshipState();

  @override
  List<Object?> get props => <Object?>[];
}

class MentorshipLoading extends MentorshipState {
  const MentorshipLoading();
}

class MentorshipLoaded extends MentorshipState {
  const MentorshipLoaded(this.mentors);

  final List<MentorModel> mentors;

  @override
  List<Object?> get props => <Object?>[mentors];
}
