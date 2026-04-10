import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nexus/shared/mock/mock_app_store.dart';
import 'package:nexus/shared/models/mentor_model.dart';

part 'mentorship_state.dart';

class MentorshipCubit extends Cubit<MentorshipState> {
  MentorshipCubit({required MockAppStore appStore})
      : _appStore = appStore,
        super(const MentorshipLoading());

  final MockAppStore _appStore;

  Future<void> load() async {
    emit(MentorshipLoaded(_appStore.mentors));
  }
}
