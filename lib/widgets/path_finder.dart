import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_layout.dart';

class PathFinder extends StatelessWidget {
  final int pathLength;
  final List<String> path;
  const PathFinder({super.key, required this.pathLength, required this.path});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -15,
          child: Container(
            width: 60,
            height: 7,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 1,
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Path: ${pathLength}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text("📍 ${path.join(' \n📍 ')}"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
