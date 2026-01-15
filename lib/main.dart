import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/ChipHabilidad.dart';
import 'widgets/ItemLista.dart';
import 'widgets/SeccionCV.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CV Jesús Regueira",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const PantallaCV(),
    );
  }
}

//StatefulWidget para manejar el estado (requisito 10)
class PantallaCV extends StatefulWidget {
  const PantallaCV({super.key});

  @override
  State<PantallaCV> createState() => _PantallaCVState();
}

class _PantallaCVState extends State<PantallaCV> {
  //Guardar el idioma seleccionado
  String idiomaSeleccionado = "Español";
  final List<String> idiomas = ["Español", "English", "Galego"];
  bool mostrarMasInfo = false;

  //Mapas con los textos traducidos
  final Map<String, Map<String, String>> sobreMiTextos = {
    "Español": {
      "corto":
          "Soy estudiante de Desarrollo de Aplicaciones Multiplataforma, con pasión por el skateboard. Mi objetivo es ser desarrollador backend y especializrme en ciberseguridad. ",
      "largo":
          "Soy estudiante de Desarrollo de Aplicaciones Multiplataforma,con una gran pasión por el skateboarding. Actualmente, he convertido mi hobby en mi trabajo, impartiendo clases deskateboard a niños y adultos. Esta experiencia me ha permitido desarrollar habilidades clave como la comunicación, la paciencia y el liderazgo, que considero muy útiles en el ámbito tecnológico. Mi objetivo es convertirme en desarrollador backend y hacer una especialización en ciberseguridad, donde pueda aplicar mis conocimientos y seguir aprendiendo para crecer y contribuir en el mundo de la tecnología.",
    },
    "English": {
      "corto":
          "I' m a Multiplatform Application Development student, passionate about skateboarding. My goal is to become a backend developer specializing in cybersecurity. ",
      "largo":
          "I' m a Multiplatform Application Development student with a great passion for skateboarding. Currently, I have turned my hobby into my job, teaching skateboarding to children and adults. This experiencie has allowed me to develop key skills such as communication, patience, and leadership, which I consider very useful in the tech world. My goal is to become a backend developer and specialize in cybersecurity, where i can apply my knowledge and keep learning to grow and contribute to the tech world. ",
    },
    "Galego": {
      "corto":
          "Son estudante de DAM, apaixonado polo skateboard. O meu obxectivo é ser desenvolvedor backend especializado en ciberseguridade.",
      "largo":
          "Son estudante de Desarrollo de Aplicacións Multiplataforma, cunha gran paixón polo skateboarding. Actualmente, convertín a miña afección no meu traballo, impartindo clases de skateboard a nenos e adultos. Esta experiencia permitiume desenvolver habilidades clave como a comunicaión, a paciencia e o liderado, que considero moi útiles no ámbito tecnolóxico. O meu obxectivo é converterme en desenvolvedor backend e especializarme en ciberseguridade, onde podo aplicar os meus coñecementos e seguir aprendendo para crecer e contribuir no mundo da tecnoloxía. ",
    },
  };

  @override
  Widget build(BuildContext context) {
    //Detectar si es un movil o un ordenador para el responsive
    final anchoPantalla = MediaQuery.of(context).size.width;
    final esMobil = anchoPantalla < 600;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Curriculum Vitae",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          //DropdownButton para cambiar idioma(requisito 11.3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: idiomaSeleccionado,
              icon: const Icon(Icons.language),
              dropdownColor: Colors.blue,
              underline: Container(),
              items: idiomas.map((String idioma) {
                return DropdownMenuItem<String>(
                  value: idioma,
                  child: Text(
                    idioma,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (String? nuevoIdioma) {
                setState(() {
                  idiomaSeleccionado = nuevoIdioma!;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Idioma cambiado a: $nuevoIdioma"),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Cabecera con foto y datos personales
            _construirCabecera(esMobil),
            //Contenido del CV
            _cosntruirContenido(),
            const SizedBox(height: 80), //Espacio para el FAB
          ],
        ),
      ),
      //FloatingActionButton(Requisito 11.2)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _mostrarDialogoContacto();
        },
        icon: const Icon(Icons.contact_mail),
        label: const Text("Contacto"),
        tooltip: "Ver información de contacto completa",
      ),
    );
  }

  //Cabecera con foto y datos personales
  Widget _construirCabecera(bool esMobil) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          if (esMobil) _cabeceraVertical() else _cabeceraHorizontal(),
          const SizedBox(height: 16),

          //ElevatedButton para mostrar mas/menos info (resquisito 11.1)
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                mostrarMasInfo = !mostrarMasInfo;
              });
            },
            icon: Icon(
              mostrarMasInfo ? Icons.visibility_off : Icons.visibility,
            ),
            label: Text(
              mostrarMasInfo ? "Menos inforamción" : "Más información",
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  //Cabecera vertical para movil (Column - requisito 3)
  Widget _cabeceraVertical() {
    return Column(
      children: [
        _construirFotoPerfil(),
        const SizedBox(height: 16),
        _construirDatosPersonales(),
      ],
    );
  }

  //Cabecera horizontal desktop (ROW y Expanded requisitos 3 y6)
  Widget _cabeceraHorizontal() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _construirFotoPerfil(),
        const SizedBox(width: 32),
        Expanded(child: _construirDatosPersonales()),
      ],
    );
  }

  // Foto de perfil con Stack (requisito 7) e imagen(requisito 2)
  Widget _construirFotoPerfil() {
    return Stack(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              "assets/img/fotoPerfil.jpg",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ),
        //Indicador de estado online(demuestra Stack requisito 7)
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
          ),
        ),
      ],
    );
  }

  //Datos personales(Text con style y textAling requisito 1)
  Widget _construirDatosPersonales() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Jesús Regueira Vázquez",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        const Text(
          "ESTUDIANTE DE DAM",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
            letterSpacing: 2.0,
          ),
        ),
        const Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.white70),
            SizedBox(width: 4),
            Text("A Coruña, España", style: TextStyle(color: Colors.white70)),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.email, size: 16, color: Colors.white70),
            SizedBox(width: 4),
            Flexible(
              child: Text(
                "jesusregueiravazquez@gmail.com",
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  //Contenido principal CV
  Widget _cosntruirContenido() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _construirSobreMi(),
          _construirIdiomas(),
          _construirExperiencia(),
          _construirFormacion(),
          _construirLenguajes(),
          _construirHerramientas(),
          _construirHabilidades(),
          _construirHobbies(),
          _construirCarnet(),
        ],
      ),
    );
  }

  //Seccion Sobre Mi(Container decoration(requisito 4))

  Widget _construirSobreMi() {
    final textosIdioma =
        sobreMiTextos[idiomaSeleccionado] ?? sobreMiTextos["Español"]!;
    final textoMostrar = mostrarMasInfo
        ? textosIdioma["largo"]!
        : textosIdioma["corto"]!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.blue, size: 24),
                SizedBox(width: 8),
                Text(
                  idiomaSeleccionado == "English"
                      ? "About Me"
                      : idiomaSeleccionado == "Galego"
                      ? "Sobre min"
                      : "Sobre Mí",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 8),
            Text(
              textoMostrar,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  // Seccion idiomas (Padding explicito reequisito 5)
  Widget _construirIdiomas() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SeccionCV(
        titulo: "Idiomas",
        icono: Icons.language,
        contenido: [
          _construirBarraIdioma("Español", "Nativo", 1.0),
          _construirBarraIdioma("inglés", "B2(First Certificate)", 0.8),
          _construirBarraIdioma("Gallego", "CELGA 4", 0.85),
        ],
      ),
    );
  }

  Widget _construirBarraIdioma(String idioma, String nivel, double progreso) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                idioma,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                nivel,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progreso,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }

  //Seccion Experiencia (ListView.builder requisito 8)
  Widget _construirExperiencia() {
    final experiencias = [
      {
        "titulo": "Instructor de Skateboarding",
        "lugar": "NothSide Skatepark",
        "periodo": "2024-Actualidad",
        "descripcion":
            "Clases particulares y grupales para niños y adultos."
            " Planificación de sesiones adaptadas a diferentes niveles",
      },
    ];
    return SeccionCV(
      titulo: "Experiencia laboral",
      icono: Icons.work,
      contenido: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: experiencias.length,
          itemBuilder: (context, index) {
            final exp = experiencias[index];
            return ItemLista(
              titulo: exp["titulo"]!,
              subtitulo: exp["lugar"]!,
              periodo: exp["periodo"]!,
              descripcion: exp["descripcion"]!,
            );
          },
        ),
        if (mostrarMasInfo)
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Experiencia y habilidades desarrolladas:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("- Planificación y ejecución de sesiones adaptadas"),
                Text("- Desarrollo de programas personalizados"),
                Text("- Fomento de ambiente seguro y motivador"),
                Text("- Feedback y seguimiento del progreso"),
              ],
            ),
          ),
      ],
    );
  }

  //Seccion Formacion

  Widget _construirFormacion() {
    final formaciones = [
      {
        "titulo": "Técnico Superior en DAM",
        "lugar": "IES Fernado Wirtz",
        "periodo": "Sep 2023 - Actualidad",
        "descripcion": "Desarrollo de Aplicaciones Multiplataforma",
      },
      {
        "titulo": "Bachillerato",
        "lugar": "Hogar de Santa Margarita",
        "periodo": "Sep 2020 - Jun 2023",
        "descripcion": "Certificado de Bachiller",
      },
    ];

    return SeccionCV(
      titulo: "Formación Académica",
      icono: Icons.school,
      contenido: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: formaciones.length,
          itemBuilder: (context, index) {
            final exp = formaciones[index];
            return ItemLista(
              titulo: exp["titulo"]!,
              subtitulo: exp["lugar"]!,
              periodo: exp["periodo"]!,
              descripcion: exp["descripcion"]!,
            );
          },
        ),
      ],
    );
  }

  //Seccion lenguajes de Programacion

  Widget _construirLenguajes() {
    final lenguajes = [
      "HTML",
      "XML",
      "CSS",
      "Java",
      "SQL",
      "C#",
      "Kotlin",
      "Dart",
    ];
    return SeccionCV(
      titulo: "Lenguajes de Programación",
      icono: Icons.code,
      contenido: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: lenguajes.map((lenguaje) {
            return ChipHabilidad(habilidad: lenguaje, color: Colors.blue);
          }).toList(),
        ),
      ],
    );
  }

  //Seccion Herramientas

  Widget _construirHerramientas() {
    final herramientas = [
      "NeatBeans",
      "Visual Studio",
      "Android Studio",
      "Unity",
      "JeatBrains",
      "WorkBench",
      "Base X",
      "Git",
      "Docker",
      "Flutter",
      "Spring Boot",
      "MongoDB"
    ];
    return SeccionCV(
      titulo: "IDEs, Gestión de Datos y Tecnologías",
      icono: Icons.build,
      contenido: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: herramientas.map((herramienta) {
            return ChipHabilidad(habilidad: herramienta, color: Colors.blue);
          }).toList(),
        ),
      ],
    );
  }

  //Seccion Habilidades Blandas
  Widget _construirHabilidades() {
    final habilidades = [
      {
        "titulo": "Resolución de problemas",
        "descripcion":
            "Descomponer problemas complejos en tareas más pequeñas.",
      },
      {
        "titulo": "Comunicación",
        "descripcion":
            "Guiar y motivar, desarrollando comunicación clara y efectiva.",
      },
      {
        "titulo": "Planificación y organización",
        "descripcion": "Creación de programas estructurados.",
      },
      {
        "titulo": "Adaptabilidad",
        "descripcion": "Ajuste de técnicas según diferentes niveles.",
      },
    ];

    return SeccionCV(
      titulo: "Habilidades",
      icono: Icons.star,
      contenido: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: habilidades.length,
          itemBuilder: (context, index) {
            final hab = habilidades[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hab["titulo"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (mostrarMasInfo)
                          Text(
                            hab["descripcion"]!,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  //Seccion Hobbies
  Widget _construirHobbies() {
    return SeccionCV(
      titulo: "Hobbies e Intereses",
      icono: Icons.sports,
      contenido: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            ChipHabilidad(habilidad: "Skateboard", color: Colors.orange),
            ChipHabilidad(habilidad: "Videojuegos", color: Colors.purple),
            ChipHabilidad(habilidad: "Deporte", color: Colors.red),
          ],
        ),
      ],
    );
  }

  //Seccion carnet
  Widget _construirCarnet() {
    return SeccionCV(
      titulo: "Carnet de conducir",
      icono: Icons.card_membership,
      contenido: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            ChipHabilidad(habilidad: "Carnet B", color: Colors.teal),
          ],
        ),
      ],
    );
  }

  //Dialogo de contacto completo
  void _mostrarDialogoContacto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.contact_mail, color: Colors.blue),
              SizedBox(width: 8),
              Text("Información de Contacto"),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemContactoDialogo(
                  Icons.email,
                  "Email",
                  "jesusregueiravazquez@gmail.com",
                ),
                const SizedBox(height: 12),
                _itemContactoDialogo(Icons.phone, "Teléfono", "691532853"),
                const SizedBox(height: 12),
                _itemContactoDialogo(
                  Icons.link,
                  "LinkedIn",
                  "linkedin.com/in/jesús-regueira-vázquez-30746a291",
                ),
                const SizedBox(height: 12),
                _itemContactoDialogo(
                  Icons.location_on,
                  "Ubicación",
                  "A Coruña, España",
                ),
              ],
            ),
          ),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Boton copiar email
                ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(
                      const ClipboardData(
                        text: "jesusregueiravazquez@gmail.com",
                      ),
                    );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email copiado al portapapeles"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.email),
                  label: const Text("Cop.Email"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                //Boton copiar linkedIn
                ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(
                      const ClipboardData(
                        text:
                            "https://linkedin.com/in/jesús-regueira-vázquez-30746a291",
                      ),
                    );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Linkedin copiado al portapapeles"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.link),
                  label: const Text("Cop.LinkedIn"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cerrar"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _itemContactoDialogo(IconData icono, String etiqueta, String valor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icono, color: Colors.blue, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  etiqueta,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(valor, style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
