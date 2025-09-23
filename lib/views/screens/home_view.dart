import 'package:flutter/material.dart';
import 'package:note_app/views/widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Note')),
      body: HomeViewBody(),
    );
  }
}
