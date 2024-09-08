// 1'den N'e kadar olan asal sayıları listeleyen program.

import "dart:io";

List<int> asalSayilar(int N) {
  List<int> sayilar = [];

  for (int sayi = 2; sayi <= N; sayi++) {
    bool asal_mi = true;
    for (int bolen = 2; bolen < sayi; bolen++) {
      if (sayi % bolen == 0) {
        asal_mi = false;
        break;
      }
    }
    // Sayi asalsa 'sayilar' listesine sayiyiy ekler.
    if (asal_mi) {
      sayilar.add(sayi);
    }
  }
  return sayilar; // listeyi döndürür.
}

void main() {
  stdout.write("N değerini giriniz: ");
  int N = int.parse(
      stdin.readLineSync()!); // Kullanıcıdan N değerini alır, kaydeder.
  List<int> sayilar = asalSayilar(N);
  print("1'den $N'e kadar olan asal sayilar: $sayilar");
}
