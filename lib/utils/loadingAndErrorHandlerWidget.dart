import 'package:flutter/material.dart';

class LoadingAndErrorHandlerWidget extends StatelessWidget {
  bool boolCondition;
  Function() onPressedCallBack;
  String message;
  LoadingAndErrorHandlerWidget({
    @required this.boolCondition,
    @required this.onPressedCallBack,
    @required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: boolCondition
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 40,
                  onPressed: onPressedCallBack,
                  icon: Icon(
                    Icons.refresh,
                    size: 35,
                    color: Colors.redAccent,
                  ),
                  // Icon(Icons.refresh),
                ),
                Text("Tap To Refresh"),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    message ?? "Error Fetching API Data",
                    // softWrap: true,
                    // style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            )
          : CircularProgressIndicator(color: Colors.blueAccent),
    );
  }
}
