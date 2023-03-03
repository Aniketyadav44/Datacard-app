import 'package:flutter/material.dart';

import 'loader.dart';
import 'logo.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Logo(),
              SizedBox(
                height: 40,
              ),
              Loader(),
            ],
          ),
        ),
      ),
    );
  }
}
