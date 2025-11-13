import 'package:flutter/material.dart';


//Widget personalizado para items de experiencia/formación (requisito 9)
class ItemLista extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String periodo;
  final String descripcion;

  const ItemLista({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.periodo,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$subtitulo - $periodo',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(descripcion, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}