// Enum PeminjamanStatus untuk menunjukkan status peminjaman item perpustakaan
enum PeminjamanStatus { DIPINJAM, KEMBALI }

// Kelas abstrak ItemPerpustakaan sebagai template untuk item perpustakaan lainnya
abstract class ItemPerpustakaan {
  String judul;
  String penulis;
  int tahunTerbit;

  // Konstruktor untuk inisialisasi item perpustakaan
  ItemPerpustakaan(this.judul, this.penulis, this.tahunTerbit);

  // Metode abstrak untuk pinjam dan kembalikan, akan diimplementasikan di kelas turunan
  void pinjam();
  void kembalikan();
}

// Mixin PemantauStatus untuk memantau status peminjaman item
mixin PemantauStatus {
  // Status awal adalah KEMBALI
  PeminjamanStatus status = PeminjamanStatus.KEMBALI;

  // Metode untuk menampilkan status peminjaman saat ini
  void tampilkanStatus() {
    print("Status: ${status.toString().split('.').last}");
  }

  // Getter dan Setter untuk status peminjaman
  PeminjamanStatus get getStatus => status;
  set setStatus(PeminjamanStatus newStatus) => status = newStatus;
}

// Kelas Buku sebagai turunan dari ItemPerpustakaan dan menggunakan mixin PemantauStatus
class Buku extends ItemPerpustakaan with PemantauStatus {
  // Konstruktor untuk inisialisasi buku
  Buku(String judul, String penulis, int tahunTerbit) : super(judul, penulis, tahunTerbit);

  @override
  void pinjam() {
    // Mengatur status menjadi DIPINJAM ketika buku dipinjam
    setStatus = PeminjamanStatus.DIPINJAM;
    print("Buku '$judul' dipinjam.");
  }

  @override
  void kembalikan() {
    // Mengatur status menjadi KEMBALI ketika buku dikembalikan
    setStatus = PeminjamanStatus.KEMBALI;
    print("Buku '$judul' telah dikembalikan.");
  }
}

// Kelas Anggota sebagai turunan dari Buku, menambahkan informasi anggota yang meminjam buku
class Anggota extends Buku {
  String namaAnggota;
  int idAnggota;

  // Konstruktor untuk inisialisasi data anggota dan buku
  Anggota(this.namaAnggota, this.idAnggota, String judul, String penulis, int tahunTerbit)
      : super(judul, penulis, tahunTerbit);

  @override
  void tampilkanStatus() {
    // Menampilkan status peminjaman buku beserta nama anggota yang meminjam
    print("Anggota: $namaAnggota, Status Buku: ${getStatus.toString().split('.').last}");
  }
}

void main() {
  // Membuat instance Anggota dengan menggunakan positional dan named arguments
  var buku1 = Anggota("Ali", 1, "Pemrograman Dart", "John Doe", 2020);

  // Meminjam buku, yang akan mengubah status menjadi DIPINJAM
  buku1.pinjam(); 
  // Menampilkan status buku setelah dipinjam
  buku1.tampilkanStatus(); 

  // Mengembalikan buku, yang akan mengubah status kembali menjadi KEMBALI
  buku1.kembalikan();
  // Menampilkan status buku setelah dikembalikan
  buku1.tampilkanStatus(); 
}
