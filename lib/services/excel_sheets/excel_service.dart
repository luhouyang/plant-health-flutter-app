import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:plant_health_data/entities/plant_entity.dart';

class ExcelService {
  // save
  Future<void> saveData(PlantEntity plantEntity) async {
    String? downloadDirectory;
    if (Platform.isAndroid) {
      final externalStorageFolder = await getExternalStorageDirectory();
      if (externalStorageFolder != null) {
        downloadDirectory = p.join(externalStorageFolder.path, "Downloads");
      }
    } else {
      final downloadFolder = await getDownloadsDirectory();
      if (downloadFolder != null) {
        downloadDirectory = downloadFolder.path;
      }
    }

    Excel excel;

    try {
      var file = '${downloadDirectory!}/plant_health_data.xlsx';
      var bytes = File(file).readAsBytesSync();
      excel = Excel.decodeBytes(bytes);
    } catch (e) {
      ByteData data = await rootBundle.load('assets/plant_health_data.xlsx');
      var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      excel = Excel.decodeBytes(bytes);
    }

    List<TextCellValue> rowData = [];
    for (double f in plantEntity.features) {
      rowData.add(TextCellValue(f.toString()));
    }
    rowData.add(TextCellValue(plantEntity.label));
    rowData.add(TextCellValue(plantEntity.location.latitude.toString()));
    rowData.add(TextCellValue(plantEntity.location.longitude.toString()));
    rowData.add(TextCellValue(plantEntity.imageData.toString().replaceAll(",", "").replaceAll("[", "").replaceAll("]", "")));

    for (var table in excel.tables.keys) {
      Sheet sheetObject = excel[table];
      sheetObject.appendRow(rowData);

      // for (var row in excel.tables[table]!.rows) {
      //   for (var cell in row) {
      //     debugPrint(cell!.value.toString());
      //   }
      // }
    }

    var fileBytes = excel.save();

    File('${downloadDirectory!}/plant_health_data.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    debugPrint('$downloadDirectory/plant_health_data.xlsx');
  }

  // load data
  Future<List<PlantEntity>> loadData() async {
    String? downloadDirectory;
    List<PlantEntity> plantList = [];

    if (Platform.isAndroid) {
      final externalStorageFolder = await getExternalStorageDirectory();
      if (externalStorageFolder != null) {
        downloadDirectory = p.join(externalStorageFolder.path, "Downloads");
      }
    } else {
      final downloadFolder = await getDownloadsDirectory();
      if (downloadFolder != null) {
        downloadDirectory = downloadFolder.path;
      }
    }

    Excel excel;

    try {
      var file = '${downloadDirectory!}/plant_health_data.xlsx';
      var bytes = File(file).readAsBytesSync();
      excel = Excel.decodeBytes(bytes);
    } catch (e) {
      ByteData data = await rootBundle.load('assets/plant_health_data.xlsx');
      var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      excel = Excel.decodeBytes(bytes);
    }

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows.skip(1)) {
        // for (var cell in row) {
        //   debugPrint(cell!.value.toString());
        // }
        List<double> features = [];
        for (int i = 0; i < 23; i++) {
          features.add(double.parse(row[i]!.value.toString()));
        }

        String label = row[23]!.value.toString();

        LatLng location = LatLng(double.parse(row[24]!.value.toString()), double.parse(row[25]!.value.toString()));

        List<int> imageInt = [];

        row[26]!.value.toString().split(' ').asMap().forEach(
              (key, value) => imageInt.add(int.parse(value)),
            );

        Uint8List imageData = Uint8List.fromList(imageInt);

        plantList.add(PlantEntity(features: features, label: label, location: location, imageData: imageData));
      }
    }

    return plantList;
  }

  // download
  Future<void> downloadSheets() async {
    String? downloadDirectory;
    if (Platform.isAndroid) {
      final externalStorageFolder = await getExternalStorageDirectory();
      if (externalStorageFolder != null) {
        downloadDirectory = p.join(externalStorageFolder.path, "Downloads");
      }
    } else {
      final downloadFolder = await getDownloadsDirectory();
      if (downloadFolder != null) {
        downloadDirectory = downloadFolder.path;
      }
    }

    Excel excel;

    try {
      var file = '${downloadDirectory!}/plant_health_data.xlsx';
      var bytes = File(file).readAsBytesSync();
      excel = Excel.decodeBytes(bytes);
    } catch (e) {
      ByteData data = await rootBundle.load('assets/plant_health_data.xlsx');
      var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      excel = Excel.decodeBytes(bytes);
    }

    var fileBytes = excel.save();

    File('${downloadDirectory!}/plant_health_data.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    debugPrint('$downloadDirectory/plant_health_data.xlsx');
  }
}
