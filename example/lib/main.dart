import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(App());
}

class App extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {

    // We will insert a value into the storage if it does not already have one, otherwise it will ignore it.
    box.writeIfNull('darkmode', false);
    
    // ValueListenableBuilder is a Flutter widget
    return ValueListenableBuilder(
        valueListenable: box.listenable,
        builder: (c, read, w) {
          bool isDark = box.read('darkmode');
          print(read['darkmode']); // its work too
          return MaterialApp(
            theme: isDark ? ThemeData.dark() : ThemeData.light(),
            home: Scaffold(
              appBar: AppBar(title: Text("Get Storage")),
              body: Center(
                child: SwitchListTile(
                  value: isDark,
                  title: Text("Touch to change ThemeMode"),
                  onChanged: (val) => box.write('darkmode', val),
                ),
              ),
            ),
          );
        });
  }
}
