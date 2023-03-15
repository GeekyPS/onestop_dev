import 'package:flutter/foundation.dart';
import 'package:onestop_dev/globals/database_strings.dart';
import 'package:onestop_dev/services/api.dart';
import 'package:onestop_dev/services/data_provider.dart';
import 'package:onestop_dev/services/local_storage.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

Map<String, List<String>> recordNames = {
  "food": [DatabaseRecords.restaurant],
  "travel": [DatabaseRecords.busTimings, DatabaseRecords.ferryTimings],
  "menu": [DatabaseRecords.messMenu],
  "contact": [DatabaseRecords.contacts]
};

Future<bool> checkLastUpdated() async {
  Map<String, dynamic>? lastUpdated = await DataProvider.getLastUpdated();

  try {
    Map<String, dynamic> last = await APIService.getLastUpdated();

    if (lastUpdated == null) {
      await LocalStorage.instance.deleteAllRecord();
      await LocalStorage.instance.storeData([last], DatabaseRecords.lastUpdated);
      return true;
    }
    for (var key in lastUpdated.keys) {
      if (lastUpdated[key] != last[key]) {
        recordNames[key]?.forEach((element) async {
          await LocalStorage.instance.deleteRecord(element);
        });
      }
    }
    await LocalStorage.instance.storeData([last], DatabaseRecords.lastUpdated);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  return true;
}
