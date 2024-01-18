import 'package:flutter/material.dart';
import '../widgets/fontSize.dart';
import '../widgets/deleteAll.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "General",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text("Export Records"),
              leading: const Icon(Icons.import_export),
              onTap: () {
                // Handle option 1 tap
              },
            ),
            ListTile(
              title: const Text("Delete & Reset"),
              leading: const Icon(Icons.delete),
              onTap: () {
                // Handle option 2 tap
                
                showDialog(
                  context: context,
                  builder: (context) => DeleteAllConfirmation(),
                );
              },
            ),
            const Divider(),
            const Text(
              "Appearance",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text("Dark Mode"),
              leading: const Icon(Icons.light),
              trailing: Switch(
                value: false, // Replace with your logic for dark mode
                onChanged: (value) {
                  // Handle dark mode switch
                },
              ),
            ),
            ListTile(
              title: const Text("Font Size"),
              leading: const Icon(Icons.font_download),
              onTap: () {
                // Handle font size tap
                showDialog(
                  context: context,
                  builder: (context) => FontSizeChanger(),
                );
              },
            ),
            const Divider(),
            const Text(
              "Application",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text("Like Expense Tracker"),
              leading: const Icon(Icons.thumb_up_sharp),
              // trailing: Switch(
              //   value: false, // Replace with your logic for dark mode
              //   onChanged: (value) {
              //     // Handle dark mode switch
              //   },
              // ),
            ),
            ListTile(
              title: const Text("Feedback"),
              leading: const Icon(Icons.mail),
              onTap: () {
                // Handle font size tap
              },
            ),
            ListTile(
              title: const Text("Developers"),
              leading: const Icon(Icons.developer_board),
              onTap: () {
                // Handle font size tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
