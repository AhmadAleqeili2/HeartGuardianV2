import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool _hasSubmittedFeedback = false; 
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().feedBackCheck(); // Check feedback status on page load
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserState>( listener: (context, state) {
      if (state is FeedBackCheckSuccess && !state.isCheck) {
        _hasSubmittedFeedback = !state.isCheck;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You Already Submited Feedback'),
          ),
        );
      } 
      if (state is SentFeedBackSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Feedback Submitted Successfully'),
          ),
        );
        _hasSubmittedFeedback = true; // Update the state to show feedback has been submitted
      } else if (state is SentFeedBackFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to Submit Feedback'),
          ),
        );
      }

    }, builder: (context, state) {
      if (state is FeedBackCheckLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feedback',
          style: TextStyle(color: Colors.white),
        ).tr(),
        backgroundColor: const Color.fromARGB(255, 76, 200, 209),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            // If feedback has been submitted, show a message instead of the text box
            if (_hasSubmittedFeedback) ...[
              const Text(
                "You have already submitted your feedback. Thank you for sharing your experience!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ).tr(),
            ] else ...[
              TextField(
                controller: context.read<UserCubit>().feedbackController, // Use the feedback controller
                decoration:  InputDecoration(
                  labelText: 'Your Feedback'.tr(),
                  labelStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                  border: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                maxLines: 5, 
                maxLength: 120, // Maximum text length of 120 characters
              ),

              Padding(
                padding: EdgeInsets.only(left: 8.0), 
                child: Text(
                  "Share Your Experience",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12),
                ).tr(),
              ),

              const SizedBox(height: 20), 
BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if(state is SentFeedBackLoading) {
              return Center(child: CircularProgressIndicator());}
             return CustomButton(
                label: "Submit".tr(),
                onPressed:(){ context.read<UserCubit>().sentFeedBack();}, // Call the submit function on press
              );})
            ],
          ],
        ),
      ),
    );
    });
  }
}
