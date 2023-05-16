import 'package:flutter/material.dart';

class AddDishModal extends StatefulWidget {
  final void Function(String) addDish;

  const AddDishModal({super.key, required this.addDish});

  @override
  State<AddDishModal> createState() => _AddDishModalState();
}

class _AddDishModalState extends State<AddDishModal> {
  String name = "";

  void closeModal() {
    Navigator.pop(context);
  }

  void changeName(String newName) {
    name = newName;
  }

  void confirm() {
    widget.addDish(name);
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
              "Adicionar novo prato",
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
                  onPressed: () {
                    confirm();
                  },
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
