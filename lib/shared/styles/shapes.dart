import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom Shape untuk [Container]
class CustomShape {
  /// Ensure this class can't be instance
  CustomShape._();

  /// [Container] with [borderRadius] upper rounded shape
  static ShapeBorder topRoundedShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
  );

  /// [Container] with [borderRadius] bottom rounded shape
  static ShapeBorder bottomRoundedShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
  );
}
