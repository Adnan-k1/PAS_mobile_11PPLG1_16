import 'package:flutter/material.dart';
import '../model/store_model.dart';

void showProductDetailDialog(BuildContext context, Storemodel p) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(p.title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(p.image, height: 150),
            const SizedBox(height: 8),
            Text(p.description),
            const SizedBox(height: 8),
            Text("Rating: ${p.rating.rate} (${p.rating.count})"),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    ),
  );
}
