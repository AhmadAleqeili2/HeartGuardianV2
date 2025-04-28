import 'package:tflite_flutter/tflite_flutter.dart';

class PredictionService {
  late Interpreter interpreter;

  // Load the model
  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset('asset/model/model.tflite');
  }

  // Close the model
  void closeModel() {
    interpreter.close();
  }

  Future<List<double>> predict(List<double> inputs, List<int> newOrder) async {

    if (inputs[1] > 120) {
      inputs[1] = 1;
    } else {
      inputs[1] = 0;
    }
// ignore: avoid_print
print("input$inputs");

    List<double> orderedInputs = List.filled(13, 0.0);
    for (int i = 0; i < 13; i++) {
  orderedInputs[newOrder[i]] = inputs[i];
}

// ignore: avoid_print
print("output$orderedInputs");
    
    List<List<double>> reshapedInputs = [orderedInputs];

    var output = List.generate(1, (index) => List.filled(1, 0.0));

    // predict
    interpreter.run(reshapedInputs, output);
    // ignore: avoid_print
    print(output[0]);

    return output[0];
  }
}
