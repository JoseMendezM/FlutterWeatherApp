import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  Timer? _timer;

  void run(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(
      const Duration(seconds: 1),
      callback,
    );
  }
}

// Example: Estamos escribiendo algo en un text box. Ingresamos primero la letra a, estamos declarando que se espere para ver si el usuario no ingresa otra cosa, si el usuario ahora escribe adicionalmente la letra b (ab) se reiniciaria el contador y esperaria nuevamente a esperar a que pase el tiempo establecido de espera o que el usuario haya terminado. Con la finalidad de no saturar los servidores, porque cada vez que el usuario ingrese un valor. El servidor haria una busqueda o consulta por cada valor que ingresemos, 1 a 2 ab 3 abc y asi sucesivamente. Causando un colapso