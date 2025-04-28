    import 'package:easy_localization/easy_localization.dart';
    List<double> minv = [1,20,94,126,71,0];

bool enotification = true;
    final fieldsText = {
      'Age'.tr() :100,
      'Fasting Blood Sugar 20-800'.tr():800.00,
      'Resting Blood Pressure 94-200'.tr():200.00,
      'Cholesterol Level 126-564'.tr():564.00,
      'Maximum Heart Rate Achieved 71-202'.tr():202.00,
      'Oldpeak 0.0 - 6.2'.tr():6.2,
    };

        final fieldsOpeions = {
      'Gender'.tr():['Female'.tr(),'Male'.tr()],
      'Chest Pain Type'.tr():['typical angina'.tr(), 'atypical angina'.tr(), 'non-anginal'.tr(), 'asymptomatic'.tr()],
      'Resting Electrocardiographic Results'.tr():['normal'.tr(), 'stt abnormality'.tr(), 'lv hypertrophy'.tr()],
      'Exercise-Induced Angina'.tr():['No'.tr(),'Yes'.tr()],
      'Slope'.tr():['Upsloping'.tr(),'Flat'.tr(),'Downsloping'.tr()],
      'major vessels colored'.tr():['0','1','2','3'],
      'Thalassemia'.tr():['normal'.tr(), 'fixed defect'.tr(), 'reversible defect'.tr(),'severe'.tr()]
        };

        /*Age,Fasting Blood Sugar,Resting Blood Pressure
,Cholesterol Level,Maximum Heart Rate Achieved
,Oldpeak,Gender,Chest Pain Type,Resting Electrocardiographic Results
,Exercise-Induced Angina,Slope,major vessels colored
,Thalassemia*/ 