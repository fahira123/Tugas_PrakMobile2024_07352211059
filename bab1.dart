import 'dart:async';

/// Enum untuk peran pengguna
enum Role { Admin, Customer }

/// Kelas Produk
class Produk {
  final String namaProduk;
  final double harga;
  final bool tersedia;

  Produk({
    required this.namaProduk,
    required this.harga,
    required this.tersedia,
  });
}

/// Kelas abstrak Pengguna
abstract class Pengguna {
  final String nama;
  final int umur;
  Map<String, Produk> daftarProduk = {};

  Pengguna({
    required this.nama,
    required this.umur,
  });

  /// Fungsi untuk melihat daftar produk
  void lihatProduk() {
    if (daftarProduk.isNotEmpty) {
      print("Daftar Produk untuk $nama:");
      daftarProduk.forEach((namaProduk, produk) {
        print('${produk.namaProduk} - Rp ${produk.harga} - ${produk.tersedia ? "Tersedia" : "Tidak Tersedia"}');
      });
    } else {
      print("Belum ada produk untuk $nama.");
    }
  }
}

/// Subkelas AdminPengguna yang bisa mengelola produk
class AdminPengguna extends Pengguna {
  AdminPengguna({required String nama, required int umur}) : super(nama: nama, umur: umur);

  /// Menambah produk ke daftar produk pengguna
  void tambahProduk(Produk produk) {
    if (!produk.tersedia) {
      print("Kesalahan: Produk ${produk.namaProduk} tidak tersedia.");
      return;
    }
    if (!daftarProduk.containsKey(produk.namaProduk)) {
      daftarProduk[produk.namaProduk] = produk;
      print("Produk ${produk.namaProduk} berhasil ditambahkan.");
    } else {
      print("Produk ${produk.namaProduk} sudah ada dalam daftar.");
    }
  }

  /// Menghapus produk dari daftar produk pengguna
  void hapusProduk(String namaProduk) {
    if (daftarProduk.containsKey(namaProduk)) {
      daftarProduk.remove(namaProduk);
      print("Produk $namaProduk berhasil dihapus.");
    } else {
      print("Produk $namaProduk tidak ditemukan dalam daftar.");
    }
  }
}

/// Subkelas CustomerPengguna yang hanya bisa melihat produk
class CustomerPengguna extends Pengguna {
  CustomerPengguna({required String nama, required int umur}) : super(nama: nama, umur: umur);
}

/// Fungsi asinkron untuk mengambil detail produk dari server
Future<void> ambilDetailProduk() async {
  print("Mengambil data produk...");
  await Future.delayed(Duration(seconds: 2)); // Simulasi pengambilan data dari server
  print("Data produk berhasil diambil.");
}

void main() async {
  // Daftar produk
  var produk1 = Produk(namaProduk: "Laptop", harga: 15000000, tersedia: true);
  var produk2 = Produk(namaProduk: "Smartphone", harga: 5000000, tersedia: true);
  var produk3 = Produk(namaProduk: "Kamera", harga: 7000000, tersedia: false);

  // Membuat pengguna admin dan customer
  var admin = AdminPengguna(nama: "Admin 1", umur: 30);
  var customer = CustomerPengguna(nama: "Customer 1", umur: 25);

  // Menambah dan menghapus produk oleh admin
  admin.tambahProduk(produk1);
  admin.tambahProduk(produk2);
  admin.tambahProduk(produk3); // Menangani produk yang tidak tersedia
  admin.lihatProduk();

  admin.hapusProduk("Laptop");
  admin.lihatProduk();

  // Customer melihat produk
  customer.daftarProduk = {
    produk1.namaProduk: produk1,
    produk2.namaProduk: produk2,
  };
  customer.lihatProduk();

  // Mengambil detail produk secara asinkron
  await ambilDetailProduk();
}
