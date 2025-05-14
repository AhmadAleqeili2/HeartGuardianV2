import 'package:app/colors.dart';
import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/notification_model.dart';
import 'package:app/widgets/dialog.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late Future<dartz.Either<MessageModel, List<NotificationModel>>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getNotification();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetNotificationSuccess) {
          _notificationsFuture = Future.value(dartz.Right(state.notification));
        } else {
          if (state is GetNotificationFailure) {
            _notificationsFuture = Future.value(dartz.Left(state.message));
          }
        }
      },
      builder: (context, state) {
        if (state is GetNotificationLoading) {
          _notificationsFuture = Future.value(dartz.Left(MessageModel(message: 'Loading...')));
        }
        return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.white)).tr(),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: !context.read<UserCubit>().loggedIn
          ? Center(child: Text('Please log in to view notifications.').tr())
          : FutureBuilder<dartz.Either<MessageModel, List<NotificationModel>>>(
              future: _notificationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading notifications.',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ).tr(),
                  );
                }

                final result = snapshot.data;
                if (result == null) {
                  return Center(
                    child: Text('No data received.', style: TextStyle(color: Colors.grey)).tr(),
                  );
                }

                return result.fold(
                  (failure) => Center(child: Text(failure.message).tr()),
                  (notifications) {
                    if (notifications.isEmpty) {
                      return Center(
                        child: Text(
                          'No notifications.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ).tr(),
                      );
                    }

                    // ترتيب تنازلي حسب id
                    notifications.sort((a, b) => b.id.compareTo(a.id));

                    return ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        final formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(notification.date);

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.notifications, color: Colors.teal, size: 30),
                            title: Text(
                              notification.message.tr(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              formattedDate,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            onTap: () {
                              dialog(
                                context,
                                formattedDate,
                                Colors.teal,
                                notification.message.tr(),
                                Colors.black,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  });

}
}