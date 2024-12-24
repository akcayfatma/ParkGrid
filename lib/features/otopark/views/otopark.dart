import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:parkgrid_y/temaBilesenleri/temaBilesenleri_firebase_storage.dart';
import 'package:parkgrid_y/temaBilesenleri/sizes.dart';
import 'package:parkgrid_y/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkgrid_y/features/otopark/controller/otopark_controller.dart';
import 'package:parkgrid_y/features/otopark/repository/otopark_repository.dart';

import 'package:parkgrid_y/temaBilesenleri/renkler.dart';

class Otopark extends ConsumerWidget {
  const Otopark({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: arkaplan,
      appBar: AppBar(
        title: const Text('Otopark Durumu'),
      ),
      body: FutureBuilder<DataSnapshot>(
        future: ref.read(otoparkControllerProvider).getOtoparkData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Hata oluştu. Lütfen tekrar deneyiniz.'),
            );
          } else if (snapshot.hasData) {
            final otoparkData = snapshot.data!.value as Map<dynamic, dynamic>;

            if (otoparkData.isEmpty) {
              return const Center(
                child: Text('Otopark bilgisi bulunamadı.'),
              );
            }

            return ListView.builder(
              itemCount: otoparkData.keys.length,
              itemBuilder: (context, index) {
                final key = otoparkData.keys.elementAt(index);
                final value = otoparkData[key];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Otopark: $key'),
                    subtitle: Text('Durum: ${value['durum']}'),
                    trailing: value['engelli_yeri'] == true
                        ? const Icon(Icons.accessible, color: Colors.green)
                        : const Icon(Icons.car_repair, color: Colors.blue),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Otopark bilgisi alınamadı.'),
            );
          }
        },
      ),
    );
  }
}