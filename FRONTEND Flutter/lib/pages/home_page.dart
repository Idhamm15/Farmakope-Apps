import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klasifikasi_tanaman_herbal/pages/detect_page.dart';
// import 'package:klasifikasi_tanaman_herbal/widgets/item_tanaman.dart';

import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  Future getImageWithGallery() async {
    final gambar = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = gambar;
    });
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cGreen,
        title: const Text(
          'Herbal Plant',
          style: TextStyle(
            fontSize: 20,
            color: cWhite,
            letterSpacing: 1,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NOTE : Section Identifikasi ==========================
              const SizedBox(height: 30),
              const Text(
                'Identifikasi',
                style: TextStyle(
                  fontSize: 18,
                  color: cDarkGrenn,
                  fontWeight: semiBold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Ayo! mulai identifikasi tanaman kamu',
                style: TextStyle(
                  fontSize: 14,
                  color: cGray,
                  fontWeight: regular,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 15),
              // NOTE : Section Button =================================
              GestureDetector(
                onTap: () {
                  getImageWithGallery().then(
                    (value) {
                      if (value == null) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomePage.routeName,
                          (route) => false,
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          DetectPage.routeName,
                          arguments: value,
                        );
                      }
                    },
                  );
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
                      'Ambil Gambar',
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
              // NOTE : Section Judul Tanaman ==============================
              const SizedBox(height: 20),
              const Text(
                'Tanaman',
                style: TextStyle(
                  fontSize: 18,
                  color: cDarkGrenn,
                  fontWeight: semiBold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Daftar jenis-jenis tanaman herbal',
                style: TextStyle(
                  fontSize: 14,
                  color: cGray,
                  fontWeight: regular,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 15),
              // NOTE : Section Daftar Tanaman =============================
              SizedBox(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/img_daun_belimbing.jpg',
                              width: 100,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Daun Belimbing',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: medium,
                                  color: cDarkGrenn,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Tanaman Herbal',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: light,
                                  color: cGray,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                    // ItemTanaman(
                    //   image: 'assets/img_daun_mint.png',
                    //   title: 'Daun Mint',
                    // ),
                    // ItemTanaman(
                    //   image: 'assets/img_daun_mint.png',
                    //   title: 'Daun Kari',
                    // ),
                    // ItemTanaman(
                    //   image: 'assets/img_daun_mint.png',
                    //   title: 'Daun Kemangi',
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
