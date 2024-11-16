// Kelas ProdukDigital untuk merepresentasikan produk digital dengan atribut seperti nama, harga, kategori, dan jumlah terjual
class ProdukDigital {
  String namaProduk;
  double harga;
  String kategori;
  int jumlahTerjual;

  // Konstruktor untuk inisialisasi produk
  ProdukDigital(this.namaProduk, this.harga, this.kategori, this.jumlahTerjual);

  // Metode untuk menerapkan diskon jika memenuhi syarat tertentu
  void terapkanDiskon() {
    if (kategori == "NetworkAutomation" && jumlahTerjual > 50 && harga >= 200000) {
      harga *= 0.85; // Diskon 15%
      // Jika harga setelah diskon kurang dari 200000, tidak ada aksi tambahan
    }
  }
}

// Enum FaseProyek untuk mendefinisikan tahap-tahap proyek
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

// Kelas Proyek untuk mengelola proyek dengan fase, jumlah hari, dan tim proyek
class Proyek {
  FaseProyek fase;
  int hariBerjalan;
  List<Karyawan> timProyek;

  // Konstruktor untuk inisialisasi proyek
  Proyek(this.fase, this.hariBerjalan, this.timProyek);

  // Metode untuk melanjutkan ke fase berikutnya
  void nextFase() {
    if (fase == FaseProyek.Perencanaan && timProyek.length >= 5) {
      fase = FaseProyek.Pengembangan;
    } else if (fase == FaseProyek.Pengembangan && hariBerjalan > 45) {
      fase = FaseProyek.Evaluasi;
    }
  }
}

// Kelas abstrak Karyawan sebagai template untuk jenis karyawan lainnya
abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  // Konstruktor untuk inisialisasi karyawan
  Karyawan(this.nama, {required this.umur, required this.peran});

  // Metode abstrak bekerja yang akan diimplementasikan pada kelas turunannya
  void bekerja();
}

// Kelas KaryawanTetap sebagai implementasi dari karyawan tetap
class KaryawanTetap extends Karyawan {
  KaryawanTetap(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print("$nama bekerja selama hari kerja reguler.");
  }
}

// Kelas KaryawanKontrak sebagai implementasi dari karyawan kontrak
class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print("$nama bekerja pada proyek khusus.");
  }
}

// Mixin Kinerja untuk menyediakan fungsi produktivitas
mixin Kinerja {
  int produktivitas = 0;
  DateTime? lastUpdate;

  // Metode untuk mengupdate nilai produktivitas
  void updateProduktivitas(int nilai) {
    final now = DateTime.now();
    if (lastUpdate == null || now.difference(lastUpdate!).inDays >= 30) {
      if (nilai >= 0 && nilai <= 100) {
        produktivitas = nilai;
        lastUpdate = now;
      }
    }
  }
}

// Kelas Manager menggunakan mixin Kinerja dan merupakan turunan dari Karyawan
class Manager extends Karyawan with Kinerja {
  Manager(String nama, {required int umur})
      : super(nama, umur: umur, peran: "Manager") {
    // Set nilai produktivitas minimal 85 untuk Manager
    if (produktivitas < 85) produktivitas = 85;
  }

  @override
  void bekerja() {
    print("$nama bekerja sebagai Manager dengan produktivitas $produktivitas.");
  }
}

// Kelas Perusahaan untuk mengelola karyawan aktif dan non-aktif
class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  final int maxKaryawanAktif = 20;

  // Metode untuk menambah karyawan ke daftar karyawan aktif
  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < maxKaryawanAktif) {
      karyawanAktif.add(karyawan);
    } else {
      print("Tidak dapat menambah lebih banyak karyawan aktif.");
    }
  }

  // Metode untuk mengeluarkan karyawan dari daftar aktif dan memindahkannya ke daftar non-aktif
  void resignKaryawan(Karyawan karyawan) {
    if (karyawanAktif.contains(karyawan)) {
      karyawanAktif.remove(karyawan);
      karyawanNonAktif.add(karyawan);
    }
  }
}

void main() {
  // Membuat instance ProdukDigital dan menerapkan diskon jika memenuhi syarat
  var produk1 = ProdukDigital("Sistem Otomasi", 250000, "NetworkAutomation", 60);
  produk1.terapkanDiskon();
  print("Harga setelah diskon: ${produk1.harga}");

  // Membuat instance KaryawanTetap dan Manager
  var karyawan1 = KaryawanTetap("Ahmad", umur: 30, peran: "Developer");
  var karyawan2 = Manager("Siti", umur: 40);
  
  // Menambahkan karyawan ke dalam perusahaan
  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawan1);
  perusahaan.tambahKaryawan(karyawan2);

  // Menjalankan metode bekerja pada masing-masing karyawan
  karyawan1.bekerja();
  karyawan2.bekerja();
}
