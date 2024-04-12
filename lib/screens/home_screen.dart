// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sciflare_task_flutter/const/app_const.dart';
import 'package:sciflare_task_flutter/screens/list_of_users_screen.dart';
import '../service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? responseData;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    ApiService apiService = ApiService();
    responseData = await apiService.retrieveApiResponse();

    if (responseData != null) {
      setState(() {});
    } else {
      print('Failed to retrieve API data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.dataFromLocal),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        responseData != null
            ? Expanded(
                child: ListView(
                  children: responseData!.entries.map((entry) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          entry.key,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          entry.value.toString(),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            : const SpinKitSpinningLines(
                color: Colors.amber,
                size: 50.0,
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListOfUsers()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
              ),
              child: const Text(
                AppConstants.getAllUsers,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
