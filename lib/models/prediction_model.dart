// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Prediction extends Equatable {
  final String label;
  final double? confidence;
  const Prediction({
    required this.label,
    this.confidence,
  });

  factory Prediction.fromMap(dynamic map) {
    return Prediction(
      label: map['label'] as String? ?? 'Unknown',
      confidence: map['confidence'],
    );
  }

  @override
  List<Object> get props => [label, if (confidence != null) confidence!];
}
