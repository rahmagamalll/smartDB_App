import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/di/dependency_injection.dart';
import 'package:software_project/smart_db.dart';

void main() async{
  await setupGetIt();
  await ScreenUtil.ensureScreenSize();
  runApp(const SmartDB());
}
