part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => <Object?>[];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

class OtpSending extends OnboardingState {
  const OtpSending();
}

class OtpSent extends OnboardingState {
  const OtpSent({required this.email});

  final String email;

  @override
  List<Object?> get props => <Object?>[email];
}

class OtpVerifying extends OnboardingState {
  const OtpVerifying();
}

class OtpVerified extends OnboardingState {
  const OtpVerified();
}

class ProfileSaving extends OnboardingState {
  const ProfileSaving();
}

class OnboardingComplete extends OnboardingState {
  const OnboardingComplete();
}

class OnboardingError extends OnboardingState {
  const OnboardingError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
