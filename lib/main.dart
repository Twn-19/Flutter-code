import 'dart:convert'; // สำหรับการอ่าน JSON
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // สำหรับ rootBundle เพื่อโหลดไฟล์ assets
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FlowerShopApp());
}

class FlowerShopApp extends StatelessWidget {
  const FlowerShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ร้านขายดอกไม้',
      theme: ThemeData(
        textTheme: GoogleFonts.fredokaTextTheme(), // ใช้ฟอนต์ Fredoka ทั่วแอป
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffac8256)),
        scaffoldBackgroundColor:
            const Color(0xffebcbac), // สีพื้นหลังของทุกหน้า
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xffac8256), // สีเดียวกันบน AppBar
          titleTextStyle: GoogleFonts.fredoka(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xff7a4c0b),
          ), // ฟอนต์ Fredoka สำหรับชื่อบน AppBar
        ),
        useMaterial3: true,
      ),
      home: const FlowerHomePage(title: 'Twn Flowers'),
    );
  }
}

class FlowerHomePage extends StatefulWidget {
  const FlowerHomePage({super.key, required this.title});
  final String title;

  @override
  State<FlowerHomePage> createState() => _FlowerHomePageState();
}

class _FlowerHomePageState extends State<FlowerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // ใช้สีและฟอนต์จาก Theme
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Flower Shop',
              style: GoogleFonts.fredoka(fontSize: 30),
            ),
            const SizedBox(height: 10),
            Image.network(
              'https://assets.metrobi.com/wp-content/uploads/2024/05/Craft-an-inviting-flower-shop-layout.webp',
              width: 300,
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              'The Flower Beautiful As You',
              style: GoogleFonts.fredoka(fontSize: 15),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductsPage()),
                );
              },
              child: const Text('View all products'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts(); // เรียกใช้ฟังก์ชันเพื่อโหลดสินค้า
  }

  // ฟังก์ชันสำหรับโหลดข้อมูลจากไฟล์ product.json
  Future<void> _loadProducts() async {
    final String response = await rootBundle.loadString('assets/product.json');
    final data = await json.decode(response);
    setState(() {
      products = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'), // หัวข้อใช้ฟอนต์ Fredoka
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // รูปภาพของสินค้า
                  ClipRRect(
  borderRadius: BorderRadius.circular(10),
  child: Image.network(
    'https://cors-anywhere.herokuapp.com/${product['imageUrl']}', // แก้ไขให้โหลดผ่าน proxy
    width: double.infinity,
    height: 350,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(
        Icons.error,
        color: Colors.red,
        size: 100,
      );
    },
  ),
),

                  const SizedBox(height: 10),
                  // ชื่อสินค้า
                  Text(
                    product['name'],
                    style: GoogleFonts.fredoka(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  // ราคาสินค้า
                  Text(
                    'Price: ${product['price']}',
                    style: GoogleFonts.fredoka(
                        fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 10),
                  // ปุ่มดูรายละเอียด
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: product),
                          ),
                        );
                      },
                      child: const Text('View Details'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']), // ใช้ฟอนต์จาก Theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // แสดงรูปภาพในหน้ารายละเอียด
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product['imageUrl'],
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // ชื่อสินค้า
            Text(
              product['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // ราคา
            Text(
              'Price: ${product['price']}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
