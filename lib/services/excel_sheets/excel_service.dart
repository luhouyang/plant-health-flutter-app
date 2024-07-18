import 'dart:io';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:plant_health_data/entities/plant_entity.dart';

class ExcelService {
  final PlantEntity plantEntity;

  ExcelService({required this.plantEntity});

  // download
  Future<void> downloadSheets() async {
    var excel = Excel.createExcel();

    excel.rename("Sheet1", plantEntity.plantName);

    Sheet sheetObject = excel[plantEntity.plantName];

    sheetObject.appendRow([const TextCellValue("Features..., Label, Location, ImagePath, ImageData")]);

    for (String rowData in plantEntity.data) {
      List<CellValue> dataList = [TextCellValue(rowData)];
      sheetObject.appendRow(dataList);
    }

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

    var fileBytes = excel.save();

    File(downloadDirectory! + '/output_file_name.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    debugPrint('$downloadDirectory/output_file_name.xlsx');
  }
}
