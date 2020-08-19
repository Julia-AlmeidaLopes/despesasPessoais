import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Transacao{
  final String id;
  final String title;
  final double valor;
  final DateTime data;

  Transacao({
  @required this.id, 
  @required this.title, 
  @required this.valor, 
  @required this.data
  });
}