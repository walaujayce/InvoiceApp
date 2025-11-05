import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart ';
import 'package:invoice_app/styles/colors.dart';

class EditPreviewToggleButton extends StatefulWidget {
  const EditPreviewToggleButton({super.key});

  @override
  State<EditPreviewToggleButton> createState() =>
      _EditPreviewToggleButtonState();
}

class _EditPreviewToggleButtonState extends State<EditPreviewToggleButton> {
  final double toggleButtonWidth = 200;
  final double height = 35;

  // Use a boolean state for simplicity
  bool isEdit = true;

  // Calculate the overlapping item positions once
  final double itemWidth = (200 / 2) + 10; // 110
  final double itemPosition = (200 / 2) - 10; // 90

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
      decoration: BoxDecoration(
        color: Color(0xFFF6E8FB),
        borderRadius: BorderRadius.circular(99),
      ),
      height: height,
      width: toggleButtonWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // --- LAYER 1: The Sliding Background ---
          // This widget provides the "translational motion"
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300), // Animation speed
            curve: Curves.easeInOut, // Animation style
            // This is the core logic:
            // If 'isEdit', position it on the left.
            // If not 'isEdit', position it on the right.
            left: isEdit ? 0 : itemPosition,

            child: Container(
              height: height,
              width: itemWidth,
              decoration: BoxDecoration(
                color: AppColor.blue,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),

          // --- LAYER 2: The Text and Tap Handlers ---

          // "Edit" Button (Left side)
          Positioned(
            right: itemPosition,
            child: GestureDetector(
              onTap: () {
                setState(() => isEdit = true);
                if (kDebugMode) print('title: Edit');
              },
              child: Container(
                // Use a transparent container for a larger tap area
                color: Colors.transparent,
                alignment: Alignment.center,
                height: height,
                width: itemWidth,
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 16,
                    // Text color changes based on state
                    color: isEdit ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // "Preview" Button (Right side)
          Positioned(
            left: itemPosition,
            child: GestureDetector(
              onTap: () {
                setState(() => isEdit = false);
                if (kDebugMode) print('title: Preview');
              },
              child: Container(
                // Use a transparent container for a larger tap area
                color: Colors.transparent,
                alignment: Alignment.center,
                height: height,
                width: itemWidth,
                child: Text(
                  "Preview",
                  style: TextStyle(
                    fontSize: 16,
                    // Text color changes based on state
                    color: !isEdit ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
