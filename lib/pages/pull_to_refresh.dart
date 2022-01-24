import 'dart:async';
import 'package:flutter/material.dart';

class PullToRefresh extends StatefulWidget {
  const PullToRefresh({Key? key}) : super(key: key);

  static const String id = "/pull_to_refresh";

  @override
  _PullToRefreshState createState() => _PullToRefreshState();
}

class _PullToRefreshState extends State<PullToRefresh> {
  List data = [];

  Future loadData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      List.generate(10, (index) => data.add(data.length));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pull to Refresh"),
      ),
      body: RefreshIndicator(
        onRefresh: loadData,
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: data.length,
          itemBuilder: (context, index) => userData(data[index]),
        ),
      ),
    );
  }

  Widget userData(int index) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        title: Text("User $index"),
        leading: CircleAvatar(
          radius: 20,
          child: Center(
            child: Text("$index"),
          ),
        ),
      ),
    );
  }
}
