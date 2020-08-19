import 'dart:math';

import 'package:despesas_pessoais/components/chart.dart';
import 'package:despesas_pessoais/components/form_transacao.dart';
import 'package:despesas_pessoais/components/lista_transacao.dart';
import 'package:despesas_pessoais/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DespesasHome extends StatefulWidget {
  @override
  _DespesasHomeState createState() => _DespesasHomeState();
}

class _DespesasHomeState extends State<DespesasHome> {
  final List<Transacao> _transacoes = [
    Transacao(
        id: 't1', title: 'Calça jeans', valor: 80.00, data: DateTime.now().subtract(Duration(days: 3))),
    Transacao(
        id: 't2', title: 'Calça ', valor: 800.00, data: DateTime.now().subtract(Duration(days: 33))),
    Transacao(
        id: 't3', title: 'Conta de água', valor: 100.90, data: DateTime.now().subtract(Duration(days: 4)))
  ];

  List<Transacao> get _recenteTransacoes {
    return _transacoes.where((element){
      return element.data.isAfter(DateTime.now().subtract(
        Duration(days: 7)
      ));
    }).toList();
  }
  addTransacao(String title, double value) {
    final novaTransacao = Transacao(
      id: Random().nextDouble().toString(),
      title: title,
      valor: value,
      data: DateTime.now(),
    );

    setState(() {
      _transacoes.add(novaTransacao);
    });

    Navigator.of(context).pop();
  }

  _modalFormTransacao(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return FormTransacao(addTransacao);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f7fa),
      appBar: AppBar(
        backgroundColor: Color(0xFFff500f),
        title: Text("Despesas Pessoais ",
        style: GoogleFonts.inter(),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add
            ),
            onPressed: () => _modalFormTransacao(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recenteTransacoes),
            ListaTransacao(_transacoes),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF8dc63f),
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _modalFormTransacao(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
