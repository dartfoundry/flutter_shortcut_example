import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shortcuts Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(body: ShortcutExample()),
    );
  }
}

class ShortcutExample extends StatelessWidget {
  const ShortcutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.keyS, LogicalKeyboardKey.control): const SaveIntent(),
        LogicalKeySet(LogicalKeyboardKey.keyF, LogicalKeyboardKey.control): const SearchIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): const NextIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          SaveIntent: CallbackAction<SaveIntent>(onInvoke: (intent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Save triggered')),
            );
            return null;
          }),
          SearchIntent: CallbackAction<SearchIntent>(onInvoke: (intent) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: Text('Search triggered'),
              ),
            );
            return null;
          }),
          NextIntent: CallbackAction<NextIntent>(onInvoke: (intent) {
            debugPrint('Next item triggered');
            return null;
          }),
        },
        child: Focus(
          autofocus: true,
          child: const Center(
            child: Text('Press Ctrl+S to Save, Ctrl+F to Search, or → to go Next.'),
          ),
        ),
      ),
    );
  }
}

class SaveIntent extends Intent {
  const SaveIntent();
}

class SearchIntent extends Intent {
  const SearchIntent();
}

class NextIntent extends Intent {
  const NextIntent();
}