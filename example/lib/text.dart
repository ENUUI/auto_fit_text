import 'package:auto_fit_text/auto_fit_text.dart';
import 'package:flutter/material.dart';

import 'constant_text.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    final richSpan = TextSpan(text: text, style: Theme.of(context).textTheme.titleMedium, children: [
      WidgetSpan(
        child: Container(width: 20, height: 20, color: Colors.green),
      ),
      TextSpan(text: text2, style: Theme.of(context).textTheme.bodyLarge),
      TextSpan(text: text2, style: Theme.of(context).textTheme.bodySmall),
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        children: [
          const Divider(),
          Text(
            'Normal Text\n',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Text(
            text2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Divider(),
          Text(
            'AutoFitText Text\n',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          AutoFitText(
            text2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Divider(),
          Text(
            'Normal Text\n',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Text(
            text2 + text2,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Divider(),
          Text(
            'AutoFitText Text\n',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          AutoFitText(
            text2 + text2,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
