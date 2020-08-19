import 'package:flutter/material.dart';

class FormTransacao extends StatefulWidget {
  final void Function(String, double) onSubmit;

  FormTransacao(this.onSubmit);

  @override
  _FormTransacaoState createState() => _FormTransacaoState();
}

class _FormTransacaoState extends State<FormTransacao> {
  final titleController = TextEditingController();

  final valorController = TextEditingController();

  _submitForm () {
    final title = titleController.text;
    final value = double.tryParse(valorController.text) ?? 0.0;

    if(title.isEmpty || value <= 0){
      return;
    }
    widget.onSubmit(title, value);
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
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(labelText: 'Título: '),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              controller: valorController,
              decoration: InputDecoration(labelText: 'Valor (R\$): '),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
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
