// import 'package:flutter/services.dart';
// import 'package:imin_printer/enums.dart';
// import 'package:imin_printer/imin_printer.dart';
// import 'package:imin_printer/imin_style.dart';
// import 'package:intl/intl.dart';

// class Printing {
//   final iminPrinter = IminPrinter();

//   Future<Uint8List> _getImageFromAsset(String iconPath) async {
//     ByteData fileData = await rootBundle.load(iconPath);
//     Uint8List fileUnit8List = fileData.buffer.asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
//     return fileUnit8List;
//   }

//   printSummary({
//     // required Summary summary,
//     required Uint8List picture,
//   }) async {
//     final numberFormat = NumberFormat('#,###.00');
//     final state = await iminPrinter.getPrinterStatus();
//     await iminPrinter.setPageFormat(style: 1 - 58);

//     Uint8List byte = await _getImageFromAsset('assets/icons/Yz0z6U8orvUlRjacSA6BVLGRTIdlnwVs-Photoroom.png');
//     // Uint8List byte2 = await _getImageFromAsset(picture!);
//     await iminPrinter.printSingleBitmap(
//       byte,
//       // alignment: IminPrintAlign.center,
//       pictureStyle: IminPictureStyle(
//         alignment: IminPrintAlign.center,
//       ),
//     );
//     await iminPrinter.printSingleBitmap(
//       picture,
//       // alignment: IminPrintAlign.center,
//       pictureStyle: IminPictureStyle(
//         alignment: IminPrintAlign.center,
//       ),
//     );
//     await iminPrinter.printAndLineFeed();
//     await iminPrinter.printAndFeedPaper(100);

//     // await iminPrinter.printText(
//     //   'รายงาน สรุปยอดแคชเชียร์ (Sales Summary All)',
//     //   style: IminTextStyle(
//     //     wordWrap: true,
//     //     fontSize: 12,
//     //     space: 10,
//     //     align: IminPrintAlign.center,
//     //   ),
//     // );
//     // await iminPrinter.printText(
//     //   'ช่วงวันที่ sss ถึงวันที่ fff',
//     //   style: IminTextStyle(
//     //     wordWrap: true,
//     //     fontSize: 12,
//     //     space: 10,
//     //     align: IminPrintAlign.center,
//     //   ),
//     // );
//     // await iminPrinter.printAndLineFeed();
//     // await iminPrinter.printText(
//     //   'Outlet # All Outlet',
//     //   style: IminTextStyle(
//     //     wordWrap: true,
//     //     fontSize: 12,
//     //     space: 10,
//     //     align: IminPrintAlign.center,
//     //   ),
//     // );
//     // await iminPrinter.printColumnsText(
//     //   cols: [
//     //     ColumnMaker(
//     //       text: 'แคชเชียร์',
//     //       fontSize: 12,
//     //       align: IminPrintAlign.left,
//     //     ),
//     //   ],
//     // );
//     // await iminPrinter.printColumnsText(
//     //   cols: [
//     //     ColumnMaker(
//     //       text: 'ผู้ดึงรายงาน',
//     //       fontSize: 22,
//     //       align: IminPrintAlign.left,
//     //     ),
//     //   ],
//     // );
//   }
// }
