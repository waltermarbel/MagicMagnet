import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataSources = [
      'Google',
      'The Pirate Bay',
      '1337x',
      'Nyaa',
      'EZTV',
      'YTS'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView.builder(
        itemCount: dataSources.length,
        itemBuilder: (context, index) => CheckboxListTile(
          onChanged: (_) {},
          value: false,
          tristate: false,
          title: Text(
            dataSources.elementAt(index),
          ),
        ),
      ),
    );
  }
}
