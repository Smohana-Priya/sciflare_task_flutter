// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
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
        title: const Text('Data from local database'),
      ),
      body: Center(
        child: responseData != null
            ? ListView(
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
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
