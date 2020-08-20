import 'package:despesas_pessoais/components/chart_bar.dart';
import 'package:despesas_pessoais/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transacao> transacaoRecente;

  Chart(this.transacaoRecente);

  List<Map<String, Object>> get transacaoAgrupada {
    return List.generate(7, (index) {
      final dias = DateTime.now().subtract(Duration(days: index));

      double soma = 0.0;

      for (var i = 0; i < transacaoRecente.length; i++) {
        bool mesmoDia = transacaoRecente[i].data.day == dias.day;
        bool mesmoMes = transacaoRecente[i].data.month == dias.month;
        bool mesmoAno = transacaoRecente[i].data.year == dias.year;

        if (mesmoDia && mesmoMes && mesmoAno) {
          soma += transacaoRecente[i].valor;
        }
      }

      return {'dia': DateFormat.E().format(dias)[0], 'valor': soma};
    }).reversed.toList();
  }

  double get _valorTotSemana {
    return transacaoAgrupada.fold(0, (soma, tr) {
      return soma + tr['valor'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: transacaoAgrupada.map((tr) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: tr['dia'],
                  valor: tr['valor'],
                  percentual: _valorTotSemana == 0 ? 0 : (tr['valor'] as double) / _valorTotSemana,
                ),
              );
            }).toList()),
      ),
    );
  }
}
