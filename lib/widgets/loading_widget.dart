
import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballRotate,

                        /// Required, The loading type of the widget
                        colors: [Colors.greenAccent[700]!, Colors.red],
                        strokeWidth: 2,

                        /// Optional, The stroke of the line, only applicable to widget which contains line

                        pathBackgroundColor: Colors.black

                        /// Optional, the stroke backgroundColor
                        ),
                  ),
                );
  }
}