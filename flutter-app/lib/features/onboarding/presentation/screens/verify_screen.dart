import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:nexus/core/components/nexus_button.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';
import 'package:nexus/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final TextEditingController _emailController = TextEditingController(
    text: 'aarav@uni.edu',
  );
  final TextEditingController _otpController = TextEditingController(
    text: '123456',
  );

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (BuildContext context, OnboardingState state) {
        if (state is OtpVerified) {
          context.go('/onboarding/profile-setup');
        }
        if (state is OnboardingError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (BuildContext context, OnboardingState state) {
        final bool otpSent =
            state is OtpSent || state is OtpVerifying || state is OtpVerified;
        return Scaffold(
          appBar: AppBar(title: const Text('Verify your campus email')),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: <Widget>[
              Text(
                'Use your university email to unlock the student-only network.',
                style: NexusTextStyles.body.copyWith(
                  color: NexusColors.warmGrey,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'University email',
                  hintText: 'name@university.edu',
                ),
              ),
              const SizedBox(height: 16),
              NexusButton.primary(
                label: otpSent ? 'Resend OTP' : 'Send OTP',
                isLoading: state is OtpSending,
                onTap: () => context.read<OnboardingCubit>().sendOtp(
                      _emailController.text.trim(),
                    ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _otpController,
                maxLength: 6,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '6-digit OTP',
                  hintText: '123456',
                ),
              ),
              const SizedBox(height: 8),
              AnimatedScale(
                scale: state is OtpVerified ? 1 : 0.8,
                duration: const Duration(milliseconds: 220),
                child: AnimatedOpacity(
                  opacity: state is OtpVerified ? 1 : 0,
                  duration: const Duration(milliseconds: 220),
                  child: const Icon(
                    Icons.verified_rounded,
                    color: NexusColors.yellow,
                    size: 44,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              NexusButton.outlined(
                label: 'Verify OTP',
                isLoading: state is OtpVerifying,
                onTap: () => context.read<OnboardingCubit>().verifyOtp(
                      _otpController.text.trim(),
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
