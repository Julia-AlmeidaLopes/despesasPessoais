import 'package:despesas_pessoais/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListaTransacao extends StatelessWidget {
  final List<Transacao> transacoes;
  final void Function (String) deletar;
  ListaTransacao(this.transacoes, this.deletar);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transacoes.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Nenhuma transação cadastrada',
                  style: GoogleFonts.livvic(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19)), // GoogleFonts
                ),
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.add_box,
                  size: 80,
                  color: Colors.black54,
                )
              ],
            )
          : ListView.builder(
              itemCount: transacoes.length,
              itemBuilder: (ctx, index) {
                final tr = transacoes[index];
                return Card(
                  color: Color(0xFFedeef2),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            'R\$ ${tr.valor.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                    title: Text(tr.title,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFFff500f)),
                        )),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.data).toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () {deletar(tr.id);}    
                    ),
                  ),
                );
              }),
    );
  }
}
