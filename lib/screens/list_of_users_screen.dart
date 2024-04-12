// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sciflare_task_flutter/const/app_const.dart';
import 'package:sciflare_task_flutter/model/user_data_model.dart';

import '../service/api_service.dart';

class ListOfUsers extends StatefulWidget {
  const ListOfUsers({super.key});

  @override
  _ListOfUsersState createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  late Future<List<UserDataModal>> futureData;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureData = apiService.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.userList),
      ),
      body: Center(
        child: FutureBuilder<List<UserDataModal>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitSpinningLines(
                color: Colors.amber,
                size: 50.0,
              );
            } else if (snapshot.hasError) {
              return Text('${AppConstants.error}: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  UserDataModal userData = snapshot.data![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    elevation: 3,
                    child: ListTile(
                      title:
                          Text('${AppConstants.name1}: ${userData.name ?? ''}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${AppConstants.email1}: ${userData.email ?? ''}'),
                          Text(
                              '${AppConstants.mobileNo}: ${userData.mobile ?? ''}'),
                          Text(
                              '${AppConstants.gender1}: ${userData.gender ?? ''}'),
                          Text('${AppConstants.id}: ${userData.id ?? ''}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
