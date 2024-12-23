import 'package:flutter/material.dart';

class OpenAndCloseSwitch extends StatelessWidget {
  OpenAndCloseSwitch({
    super.key,
    required this.size,
    required this.open,
    required this.showTextClose,
    required this.showTextOpen,
    required this.onChanged,
  });

  final Size size;
  final bool open;
  final String showTextOpen;
  final String showTextClose;
  Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.height * 0.08,
        width: size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            open == true
                ? Expanded(
                    flex: 6,
                    child: Text(
                      showTextOpen,
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansThai',
                      ),
                    ))
                : Expanded(
                    flex: 6,
                    child: Text(
                      showTextClose,
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansThai',
                      ),
                    ),
                  ),
            Expanded(
              child: Switch(
                value: open,
                onChanged: onChanged,
                activeColor: Colors.blue,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              ),
            ),
          ],
        ));
  }
}
