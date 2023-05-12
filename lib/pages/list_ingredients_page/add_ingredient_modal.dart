import 'package:flutter/material.dart';

class AddIngredientModal extends StatefulWidget {
  final Function(String) addIngredient;
  const AddIngredientModal({super.key, required this.addIngredient});

  @override
  State<AddIngredientModal> createState() => _AddIngredientModalState();
}

class _AddIngredientModalState extends State<AddIngredientModal> {
  String nome = "";
  void closeModal() {
    Navigator.pop(context);
  }

  void changeName(String newName) {
    nome = newName;
  }

  void confirm() {
    widget.addIngredient(nome);
    closeModal();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Adicionar novo ingrediente",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                onChanged: (value) => changeName(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome",
                ), 
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    closeModal();
                  },
                  child: const Text("Cancelar"),
                ),
                const SizedBox(
                  width: 12,
                ),
                FilledButton(
                  onPressed: () {confirm();},
                  child: const Text("Confirmar"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
