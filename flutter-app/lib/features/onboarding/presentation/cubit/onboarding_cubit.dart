import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nexus/domain/repositories/auth_repository.dart';
import 'package:nexus/domain/repositories/user_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const OnboardingInitial());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> sendOtp(String email) async {
    emit(const OtpSending());
    try {
      await _authRepository.sendOtp(email);
      emit(OtpSent(email: email));
    } catch (error) {
      emit(OnboardingError(error.toString()));
    }
  }

  Future<void> verifyOtp(String code) async {
    emit(const OtpVerifying());
    try {
      await _authRepository.verifyOtp(code);
      emit(const OtpVerified());
    } catch (error) {
      emit(OnboardingError(error.toString()));
    }
  }

  Future<void> saveProfile({
    required String name,
    required String year,
    required List<String> skills,
    String? avatarUrl,
  }) async {
    emit(const ProfileSaving());
    try {
      await _userRepository.saveProfile(
        name: name,
        year: year,
        skills: skills,
        avatarUrl: avatarUrl,
      );
      emit(const OnboardingComplete());
    } catch (error) {
      emit(OnboardingError(error.toString()));
    }
  }
}
