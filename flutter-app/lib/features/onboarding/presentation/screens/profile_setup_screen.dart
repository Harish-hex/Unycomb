import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:nexus/core/components/nexus_button.dart';
import 'package:nexus/core/components/nexus_tag.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Aarav Raman',
  );
  String _year = '3rd Year';
  final Set<String> _selectedSkills = <String>{'Flutter', 'Product', 'ML'};
  static const List<String> _skillPool = <String>[
    'Flutter',
    'Backend',
    'Design',
    'ML',
    'Mobile',
    'Product',
    'Growth',
    'AI',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (BuildContext context, OnboardingState state) {
        if (state is OnboardingComplete) {
          context.go('/home');
        }
      },
      builder: (BuildContext context, OnboardingState state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Set up profile')),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: NexusColors.carbon,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: NexusColors.ash),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.add_a_photo_outlined,
                          color: NexusColors.yellow,
                        ),
                        SizedBox(height: 8),
                        Text('Profile photo upload'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full name'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _year,
                decoration: const InputDecoration(labelText: 'Academic year'),
                items: const <String>[
                  '1st Year',
                  '2nd Year',
                  '3rd Year',
                  '4th Year',
                ]
                    .map(
                      (String year) => DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() => _year = value);
                  }
                },
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _skillPool.map((String skill) {
                  return NexusTag(
                    label: skill,
                    selected: _selectedSkills.contains(skill),
                    style: TagStyle.accent,
                    onTap: () {
                      setState(() {
                        if (_selectedSkills.contains(skill)) {
                          _selectedSkills.remove(skill);
                        } else {
                          _selectedSkills.add(skill);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              NexusButton.primary(
                label: 'Enter Nexus',
                isLoading: state is ProfileSaving,
                onTap: () => context.read<OnboardingCubit>().saveProfile(
                      name: _nameController.text.trim(),
                      year: _year,
                      skills: _selectedSkills.toList(),
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
