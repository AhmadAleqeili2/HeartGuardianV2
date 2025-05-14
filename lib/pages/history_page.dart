import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:dartz/dartz.dart' hide State;

import 'package:app/models/history_model.dart';
import 'package:app/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<Either<MessageModel, List<HistoryModel>>> _historyFuture;

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getHistory();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<UserCubit,UserState>( listener:(context, state) {

      if (state is GetHistorySuccess) {
        
          _historyFuture = Future.value(Right(state.history));
        
      }else{
        if (state is GetHistoryFailure) {
          _historyFuture = Future.value(Left(state.errMessage));
        }
      }
    }
    
    
    
    ,builder: (context, state) {
      if (state is GetHistoryLoading) {
        _historyFuture = Future.value(Left(MessageModel(message: 'Loading...')));
      } 
      return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Heart Disease History'.tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: !context.read<UserCubit>().loggedIn
          ? Center(child: Text('Please log in to view your history.').tr())
          : FutureBuilder<Either<MessageModel, List<HistoryModel>>>(
              future: _historyFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error loading history records.').tr());
                }

                final result = snapshot.data;
                if (result == null) {
                  return Center(child: Text('No data received.').tr());
                }

                return result.fold(
                  (failure) => Center(child: Text(failure.message).tr()),
                  (histories) {
                    if (histories.isEmpty) {
                      return Center(child: Text('No history records available.').tr());
                    }

                    // ترتيب تنازلي حسب id
                    histories.sort((a, b) => b.id.compareTo(a.id));

                    return ListView.builder(
                      itemCount: histories.length,
                      itemBuilder: (context, index) {
                        final record = histories[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(record.message).tr(),
                            subtitle: Text(
                              '${'Date'.tr()}: ${DateFormat.yMd().add_jm().format(record.date)}\n${record.history.tr()}',
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
    }
    );
  }
}

