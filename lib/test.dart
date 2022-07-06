import 'package:flutter/material.dart';
import 'package:life_calculator/utils/colors.dart';
import 'package:life_calculator/widgets/app_bar.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '☠💀 Life Calculator 💀☠',
      ).appBar(),
      backgroundColor: AppColors().background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Life Calculator',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                onSubmitted: (String value) async {
                  await showDialog(
                    useSafeArea: true,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Your password'),
                        content: Text(value),
                        actions: [
                          ElevatedButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          )
        ),
      ),
    );
  }
}