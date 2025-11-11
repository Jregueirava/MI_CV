import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "CV Jesus",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PantallaCV(),
    );
  }
}


class PantallaCV extends StatefulWidget{
  const PantallaCV({super.key});
  
  @override
  State<PantallaCV> createState()=> _PantallaCVState();
  
}

class _PantallaCVState extends State<PantallaCV>{
  //Guardar el idioma seleccionado
  String idiomaSeleccionado = "Español";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Curriculum Vitae"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Nombre estilo/centrado
            const Text(
              "Jesús Regueira Vázquez",
              textAlign: TextAlign.center,
              style: TextStyle( fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),

            //Foto de perfil
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 3),
                image: const DecorationImage(image: 
                AssetImage("assets/img/fotoperfil.jpg"),
                fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            //Datos de contacto en container con el padding y fondo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(crossAxisAlignment: 
              CrossAxisAlignment.start, children: const[
                Text("Contacto", style: TextStyle(fontWeight:
              FontWeight.bold, fontSize: 18)),
              SizedBox(height: 6),
              Text("Correo electrónico: jesusregueiravazquez@gmail.com"),
              Text("Télefono: 691532853"),
              Text("LinkedIn: linkedin.com/in/jesús-regueira-vázquez-30746a291"),
              ]),
            ),

            //sobre mi 
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: 
              Colors.grey.shade200, borderRadius: 
              BorderRadius.circular(10)),
              child: const Text(
                "Soy estudiante de Desarrollo de Aplicaciones Multiplataforma, con una gran pasión por el skateboarding. Actualmente, he convertido mi hobby en mi trabajo, impartiendo clases de sakateboard a niños y adultos. Esta experiencia me ha permitido desarrollar habilidades clave como la comunicación, la paciencia y el liderazgo, que considero muy útiles en el ámbito tecnológico. Mi objetico es convertirme en desarrollador backend y hacer una especialización en ciberseguridad, donde pueda aplicar mis conocimientos y seguir aprendiendo para crecer  contribuir en el mundo de la tecnología."
              ),
            ),
            const SizedBox(height: 16),

            //Experiencia laboral
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: 
              Colors.blue.shade100, borderRadius: 
              BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Experiencia laboral", style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text("Instructor de Skateboarding en Northside"),
                  Text("Clases particuares y grupales para niños y adultos(2024-actulidad)"),
                  
                ],
                ),
            ),

            //Formacion academica

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: 
              BorderRadius.circular(10)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: const[
                Text("Formación Académica", style: 
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text("DAM - Ciclo Superior Desarrollo de Aplicaciones Multiplataforma (2023-Actualidad)"),
                Text("Certificado de Bachiller (2020-2023)"),

              ],
              ),
              ),
              //Habilidades
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(color: 
                Colors.blue.shade100, borderRadius: BorderRadius.circular(10)),
                child: Column(crossAxisAlignment: 
                CrossAxisAlignment.start, children: const [
                  Text("Habilidades", style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  Text("Resolución de problemas"),
                  Text("Comunicación clara y efectiva"),
                  Text("Planificación y organización"),
                  Text("Adaptabilidad"),
                ]),
              ),
              
          ],)
      )
    );
  }
  
}

