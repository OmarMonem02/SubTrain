import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class Ticket extends StatelessWidget {
  const Ticket({super.key});

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
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 1,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              QrImageView(                
                data: 'Ana Bmoooooooooot',
                size: 200,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Name: Omar Abdelmonem',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Time: 09:00',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Gate: 3',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: buttonPrimary,
                child: const Text(
                  'Modify',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {},
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: buttonRed,
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
