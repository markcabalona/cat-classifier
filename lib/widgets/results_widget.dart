import 'package:cat_classifier/core/enums/state_status.dart';
import 'package:cat_classifier/cubits/cat_classifier/cat_classifier_cubit.dart';
import 'package:cat_classifier/widgets/prediction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatClassifierCubit, CatClassifierState>(
      builder: (context, state) {
        if (state.status == StateStatus.loaded) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: 12),
                  child: Text(
                    'Results:',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              ...state.predictions!
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: PredictionWidget(
                        prediction: e,
                      ),
                    ),
                  )
                  .toList(),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
