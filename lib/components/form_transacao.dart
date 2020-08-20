import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FormTransacao extends StatefulWidget {
  final void Function(String, double) onSubmit;

  FormTransacao(this.onSubmit);

  @override
  _FormTransacaoState createState() => _FormTransacaoState();
}

class _FormTransacaoState extends State<FormTransacao> {
  final _titleController = TextEditingController();
  final _valorController = TextEditingController();
  DateTime _dataselecionada;

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valorController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value);
  }

  _abrirDatePicker() {
    showDatePicker(
      cancelText: 'CANCELAR',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) { 
        return;
      }
      setState(() {
        _dataselecionada = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(labelText: 'Título: '),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Valor (R\$): '),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _dataselecionada == null
                          ? 'Nenhuma data selecionada'
                          : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_dataselecionada)}',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 16, color: Color(0xFFff500f))),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Selecionar data',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: Color(0xFF6c757d),
                              fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _abrirDatePicker,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Color(0xFFe1e2e6),
                  onPressed: _submitForm,
                  child: Text(
                    'Nova Transação',
                    style: TextStyle(color: Color(0xFFff500f)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
