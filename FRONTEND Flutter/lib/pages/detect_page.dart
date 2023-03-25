import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klasifikasi_tanaman_herbal/api/api_service.dart';
import 'package:klasifikasi_tanaman_herbal/models/predict_model.dart';
import 'package:klasifikasi_tanaman_herbal/pages/home_page.dart';

import '../theme.dart';

class DetectPage extends StatefulWidget {
  const DetectPage({super.key});

  static const routeName = '/detect';

  @override
  State<DetectPage> createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  Future imageToBase64(XFile image) async {
    Uint8List imagebytes = await image.readAsBytes();
    String base64string = base64.encode(imagebytes);
    return base64string;
  }

  PredictModel? dataPredict;

  @override
  Widget build(BuildContext context) {
    final dataImage = ModalRoute.of(context)!.settings.arguments as XFile;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cWhite,
        elevation: 1,
        leading: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomePage.routeName,
                (route) => false,
              );
            },
            child: Image.asset(
              'assets/ic_arrow_left.png',
              width: 24,
            ),
          ),
        ),
        title: const Text(
          'Detect',
          style: TextStyle(
            fontSize: 20,
            color: cDarkGrenn,
            letterSpacing: 1,
            fontWeight: semiBold,
          ),
        ),
        titleSpacing: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // NOTE : Section Title ===================================
              const SizedBox(height: 20),
              const Text(
                'Identifikasi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: semiBold,
                  color: cDarkGrenn,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 20),
              // NOTE : Section Image ===================================
              Stack(
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: cGray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(dataImage.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  dataPredict != null
                      ? Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            color: cBlack.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'AKURASI :',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: semiBold,
                                  color: cWhite,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${dataPredict!.probability}%',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: semiBold,
                                  color: cWhite,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              // NOTE : Section Result =================================
              const SizedBox(height: 20),
              dataPredict != null
                  ? Text(
                      dataPredict!.nama.replaceAll('_', ' ').toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: semiBold,
                        color: cDarkGrenn,
                        letterSpacing: 1,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
              // NOTE : Section Button ================================
              GestureDetector(
                onTap: () async {
                  await imageToBase64(dataImage).then((value) {
                    ApiService().predict(value).then((result) {
                      if (result.status == '200') {
                        setState(() {
                          dataPredict = result;
                        });
                      }
                    });
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cGreen,
                  ),
                  child: const Center(
                    child: Text(
                      'Mulai',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: semiBold,
                        color: cWhite,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
