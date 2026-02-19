import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // const TransactionForm({super.key});
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    // final value = double.tryParse(valueController.text) ?? 999;
    final raw = valueController.text.replaceAll(',', '.');
    final value = double.tryParse(raw) ?? 999;
    final date = _selectedDate;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: valueController,
                onSubmitted: (value) => _submitForm(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data selecionada: ${DateFormat('d/MMM/y').format(_selectedDate!)}',
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white, // Define o fundo branco
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ), // Garante um respiro para o texto
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // Deixa as bordas levemente arredondadas
                        ),
                      ),
                      child: Text(
                        'Selecionar data',
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _showDatePicker,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.purple, // Define o fundo branco
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ), // Garante um respiro para o texto
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // Deixa as bordas levemente arredondadas
                      ),
                    ),
                    child: Text(
                      'nova Transação',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
