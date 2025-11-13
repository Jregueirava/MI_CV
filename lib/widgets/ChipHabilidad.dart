import 'package:flutter/material.dart';

//Widget personalizado para chips de habilidades (requisito 9)
class ChipHabilidad extends StatelessWidget {
  final String habilidad;
  final Color? color;

  const ChipHabilidad({super.key, required this.habilidad, this.color});

  @override
  Widget build(BuildContext context) {
    final colorFinal = color ?? Colors.blue;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: colorFinal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorFinal, width: 1.5),
      ),
      child: Text(
        habilidad,
        style: TextStyle(
          color: (colorFinal is MaterialColor)
              ? colorFinal.shade700
              : colorFinal,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}