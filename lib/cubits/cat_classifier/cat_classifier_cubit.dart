import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cat_classifier/core/enums/state_status.dart';
import 'package:cat_classifier/models/prediction_model.dart';
import 'package:equatable/equatable.dart';
import 'package:tflite/tflite.dart';

part 'cat_classifier_state.dart';

class CatClassifierCubit extends Cubit<CatClassifierState> {
  CatClassifierCubit() : super(const CatClassifierState());

  void loadModel({
    required String modelPath,
    required String labelsPath,
  }) async {
    Tflite.close();
    String? status;
    status = (await Tflite.loadModel(
      model: modelPath,
      labels: labelsPath,
    ));

    log(status.toString());
  }

  void imageClassification(File image) async {
    try {
      final List<dynamic>? recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      if (recognitions != null) {
        emit(state.copyWith(
          status: StateStatus.loaded,
          predictions: recognitions
              .map(
                (e) => Prediction.fromMap(
                  e
                ),
              )
              .toList(),
        ));
        return;
      }
      emit(state.copyWith(
        errorMessage: 'Seomthing went wrong',
        status: StateStatus.error,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: StateStatus.error,
      ));
    }
  }
}
