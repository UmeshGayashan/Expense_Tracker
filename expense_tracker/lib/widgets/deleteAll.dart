import 'package:flutter/material.dart';

class DeleteAllConfirmation extends StatefulWidget {
  const DeleteAllConfirmation({Key? key}) : super(key: key);

  @override
  State<DeleteAllConfirmation> createState() => _DeleteAllConfirmationState();
}

class _DeleteAllConfirmationState extends State<DeleteAllConfirmation> {
  bool showButton = true;

  @override
  Widget build(BuildContext context) {
    return showButton
        ? SizedBox(
            width: 70, // Set your desired width
            height: 25,  // Set your desired height
            child: ElevatedButton(
              onPressed: () {
                _showDeleteConfirmationDialog(context);
              },
              child: const Text('Delete All'),
            ),
          )
        : Container(); // Empty container when button is hidden
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete All Confirmation'),
          content: const Text('Are you sure you want to delete all items?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _hideButton(); // Hide the button
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform the delete all action
                // Add your logic here

                Navigator.of(context).pop(); // Close the dialog
                _hideButton(); // Hide the button
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _hideButton() {
    setState(() {
      showButton = false;
    });
  }
}
