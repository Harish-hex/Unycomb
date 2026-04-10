import 'package:equatable/equatable.dart';

enum OpportunityType { hackathon, collab, competition }

class OpportunityModel extends Equatable {
  const OpportunityModel({
    required this.id,
    required this.title,
    required this.source,
    required this.sourceLogoUrl,
    required this.deadline,
    required this.tags,
    required this.description,
    required this.type,
  });

  final String id;
  final String title;
  final String source;
  final String sourceLogoUrl;
  final DateTime deadline;
  final List<String> tags;
  final String description;
  final OpportunityType type;

  bool get isClosingSoon => deadline.difference(DateTime.now()).inDays < 7;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'source': source,
      'sourceLogoUrl': sourceLogoUrl,
      'deadline': deadline.toIso8601String(),
      'tags': tags,
      'description': description,
      'type': type.name,
    };
  }

  factory OpportunityModel.fromJson(Map<String, dynamic> json) {
    return OpportunityModel(
      id: json['id'] as String,
      title: json['title'] as String,
      source: json['source'] as String,
      sourceLogoUrl: json['sourceLogoUrl'] as String? ?? '',
      deadline: DateTime.parse(json['deadline'] as String),
      tags: List<String>.from(json['tags'] as List<dynamic>? ?? <String>[]),
      description: json['description'] as String,
      type: OpportunityType.values.firstWhere(
        (OpportunityType value) => value.name == json['type'],
        orElse: () => OpportunityType.hackathon,
      ),
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        source,
        sourceLogoUrl,
        deadline,
        tags,
        description,
        type,
      ];
}
