import 'package:flutter/material.dart';

//Widget contenedeor para  secciones (placehodler)

class SeccionCV extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final List<Widget> contenido;

  const SeccionCV({
    Key? key,
    required this.titulo,
    required this.icono,
    required this.contenido,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icono, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ...contenido,
        ],
      ),
    );
  }
}