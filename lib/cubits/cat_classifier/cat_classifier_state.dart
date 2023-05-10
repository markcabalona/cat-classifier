// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'cat_classifier_cubit.dart';

class CatClassifierState extends Equatable {
  final StateStatus status;
  final List<Prediction>? predictions;
  final String? errorMessage;
  const CatClassifierState({
    this.status = StateStatus.initial,
    this.predictions,
    this.errorMessage,
  });

  CatClassifierState copyWith({
    StateStatus? status,
    List<Prediction>? predictions,
    String? errorMessage,
  }) {
    return CatClassifierState(
      status: status ?? this.status,
      predictions: predictions ?? this.predictions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        if (predictions != null) predictions!,
        if (errorMessage != null) errorMessage!
      ];
}
