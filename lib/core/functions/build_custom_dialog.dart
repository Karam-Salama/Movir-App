import 'package:flutter/material.dart';

import '../widgets/custom_dialog.dart';

void buildCustomDialog(BuildContext context, CustomDialog dialog) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    isScrollControlled: true,
    builder: (context) => dialog,
  );
}
