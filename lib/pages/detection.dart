import 'package:app/controller/add_history.dart';
import 'package:app/controller/add_notification.dart';
import 'package:app/function/decimal_formatter.dart';
import 'package:app/function/predict_service.dart';
import 'package:app/widgets/dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/options_select.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:app/list.dart';


class Detection extends StatefulWidget {
  const Detection({super.key});

  @override
  State<Detection> createState() => _DetectionState();
}

class _DetectionState extends State<Detection> {
  final List<TextEditingController> controllers =
      List.generate(fieldsOpeions.length + fieldsText.length, (index) => TextEditingController());

  final PredictionService predictionService = PredictionService();

  final List<int> newOrder = [0, 5, 3, 4, 7, 9, 1, 2, 6, 8, 10, 11, 12];
  /*
  inputs:
  0age	1fbs	2trestbps	3chol	4thalach	5oldpeak	6sex	7cp	8restecg	9exang	10slope	11ca	12thal

  newOrder:
  0age	1sex	2cp	3trestbps	4chol	5fbs	6restecg	7thalach	8exang	9oldpeak	10slope	11ca	12thal
  */
  
  @override
  void initState() {
    super.initState();
    predictionService.loadModel(); // Load the model
  }

  @override
  void dispose() {
    predictionService.closeModel(); // Close the model
    super.dispose();
  }

  bool isFormValid() {
    // Check if all form fields are filled
    for (int i = 0; i < controllers.length; i++) {
      if (controllers[i].text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  int isGreaterThanMin() {
    double x;
    for (int i = 0; i < 5; i++) {
      x = double.tryParse(controllers[i].text.toString())!;
      if (x < minv[i]) {
        return i;
      }
    }
    return -1;
  }

  Future<void> _predict() async {
    List<double> inputs = controllers
        .map((controller) => double.tryParse(controller.text) ?? 0.0)
        .toList();

    List<double> result = await predictionService.predict(inputs, newOrder);
    
    if(result[0] < 0.65) { //threshold
      addHistory(false);
      if (!mounted) return;
      dialog(
        context,
        'Potential Issues:\n  No significant risk factors detected\n'.tr(),
        Colors.black,
        'Your heart health appears to be good\nConsult your doctor for further evaluation\n'.tr(),
        Color.fromARGB(255, 128, 128, 128),
        end:  'Thank you for choosing our app!'.tr(),
        colorE:  Color.fromARGB(255, 104, 206, 73),
        imagePath: 'asset/Image/Gdiag.png'
      );
    } else {
      addHistory(true);
      if (!mounted) return;
      dialog(
        context,
        'Potential Issues:\n  Significant risk factors detected.\n'.tr(),
        const Color.fromARGB(255, 236, 3, 3),
        'The results of the examination indicate a possibility of having heart disease. Please consult a doctor as soon as possible.\n'.tr(),
        Color.fromARGB(255, 128, 128, 128),
        end: 'Thank you for choosing our app!'.tr(),
        colorE:  Color.fromARGB(255, 104, 206, 73),
        imagePath: 'asset/Image/Bdiag.png'.tr()
      );
    }

    final User? user = FirebaseAuth.instance.currentUser;

    if(user != null) {
      await addNotification('Diagnosis made');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 200, 209),
        title: const Text(
          'Start Diagnosis',
          style: TextStyle(color: Colors.white),
        ).tr(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              color: const Color.fromARGB(255, 76, 200, 209),
              child: const Text(
                'Enter your information and start the diagnosis.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ).tr(),
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < fieldsText.length; i++) ...[
              CustomTextField( 
                max: double.tryParse(fieldsText[fieldsText.keys.toList()[i]]!.toString()),
                keytype: TextInputType.number,
                hintText: fieldsText.keys.toList()[i].toString().tr(),
                controller: controllers[i],
                inputFormatters: [
                  DecimalTextInputFormatter(),
                ],
              ),
              const SizedBox(height: 10),
            ],
            for (int i = fieldsText.length; i < fieldsOpeions.length + fieldsText.length; i++) ...[
              OptionsDropdown(
                label: (fieldsOpeions.keys.toList()[i - fieldsText.length].toString()).tr(),
                options: fieldsOpeions[fieldsOpeions.keys.toList()[i - fieldsText.length]]!,
                controller: controllers[i],
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (isFormValid()) {
                    if(isGreaterThanMin() == -1) {
                      _predict();
                    } else {
                      dialog(
                        context,
                        'Invalid Input'.tr(),
                        const Color.fromARGB(255, 236, 3, 3),
                        '${fieldsText.keys.toList()[isGreaterThanMin()]} cannot be less than (${minv[isGreaterThanMin()].floor()})',
                        Color.fromARGB(255, 128, 128, 128),
                      );
                    }
                  } else {
                    dialog(
                      context,
                      'Invalid Input'.tr(),
                      const Color.fromARGB(255, 236, 3, 3),
                      'Please fill in all the required fields to start the diagnosis.'.tr(),
                      Color.fromARGB(255, 128, 128, 128),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 200, 209),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Start Diagnosis').tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
