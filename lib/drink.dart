import 'package:flutter/material.dart'; // Importa la librería de Flutter

class Drink {
  String name; // Nombre del piloto
  String conName; // Nombre del personaje (apellido)
  String backgroundImage; // Imagen de fondo
  String cupImage; // Imagen de la copa
  String imageBlur; // Imagen difusa
  String imageSmall; // Imagen pequeña
  String funkoImage; // Imagen de Funko Pop
  String description; // Descripción del piloto
  Color lightColor; // Color claro asociado al piloto
  Color darkColor; // Color oscuro asociado al piloto

  Drink(
    this.name,
    this.conName,
    this.backgroundImage,
    this.cupImage,
    this.imageSmall,
    this.imageBlur,
    this.funkoImage,
    this.description,
    this.lightColor,
    this.darkColor,
  );
}
