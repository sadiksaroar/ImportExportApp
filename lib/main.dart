import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const ImportExportApp());
}

class ImportExportApp extends StatelessWidget {
  const ImportExportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ImportExportScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ImportExportScreen extends StatelessWidget {
  const ImportExportScreen({super.key});

  // File import function (JSON/CSV)
  Future<void> importFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json', 'csv'],
    );

    if (result != null && result.files.single.path != null) {
      String path = result.files.single.path!;
      print('Imported file: $path');
      // TODO: Handle the file (read or parse)
    } else {
      print('Import cancelled');
    }
  }

  // Export directory picker (for export logs or files)
  Future<void> exportFile() async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath != null) {
      print('Export directory: $directoryPath');
      // TODO: Write your export logic here
    } else {
      print('Export cancelled');
    }
  }

  // Reusable button builder
  Widget buildButton(IconData icon, String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          side: const BorderSide(color: Colors.black, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black),
        label: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Import / Export',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            buildButton(Icons.upload, "Export JSON/CSV", exportFile),
            buildButton(Icons.download, "Import JSON/CSV", importFile),
            buildButton(Icons.description_outlined, "Export logs", exportFile),
          ],
        ),
      ),
    );
  }
}
