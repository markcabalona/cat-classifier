import 'package:cat_classifier/models/prediction_model.dart';
import 'package:flutter/material.dart';

class PredictionWidget extends StatelessWidget {
  const PredictionWidget({
    Key? key,
    required this.prediction,
  }) : super(key: key);
  final Prediction prediction;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  prediction.label.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '${((prediction.confidence ?? 0) * 100).toStringAsFixed(2)}%',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
