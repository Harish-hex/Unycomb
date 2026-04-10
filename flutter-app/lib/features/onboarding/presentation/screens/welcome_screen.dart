import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:nexus/core/components/nexus_button.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showWordmark = false;

  @override
  void initState() {
    super.initState();
    unawaited(
      Future<void>.delayed(
        const Duration(milliseconds: 120),
        () => mounted ? setState(() => _showWordmark = true) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(),
              Wrap(
                children: 'NEXUS'.split('').asMap().entries.map((entry) {
                  return AnimatedOpacity(
                    opacity: _showWordmark ? 1 : 0,
                    duration: Duration(milliseconds: 600 + (entry.key * 40)),
                    curve: Curves.easeOut,
                    child: AnimatedSlide(
                      offset:
                          _showWordmark ? Offset.zero : const Offset(0, 0.15),
                      duration: Duration(milliseconds: 500 + (entry.key * 40)),
                      curve: Curves.easeOutCubic,
                      child: Text(
                        entry.value,
                        style: NexusTextStyles.display.copyWith(
                          fontSize: 42,
                          color: NexusColors.yellow,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                'Build with the best minds on campus',
                style: NexusTextStyles.heading,
              ),
              const SizedBox(height: 12),
              Text(
                'A student-first collaboration space for finding ambitious teammates, projects, and opportunities.',
                style: NexusTextStyles.body.copyWith(
                  color: NexusColors.warmGrey,
                ),
              ),
              const Spacer(),
              NexusButton.primary(
                label: 'Continue',
                onTap: () => context.go('/onboarding/verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
