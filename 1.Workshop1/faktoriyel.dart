// Faktoriyel hesaplayan bir program.

import "dart:io";

int factorial(int n) {
  if (n < 0) {
    throw ("Negatif sayilarin faktöriyel degeri hesaplanmaz! Pozitif bir sayi giriniz.");
  } else if (n == 0) {
    return 1;
  } else {
    return n * (factorial(n - 1));
  }
}

void main() {
  stdout.write("Faktoriyelini hesaplamak istediğiniz sayiyi giriniz: ");
  int n = int.parse(stdin.readLineSync()!);
  print("$n! =  ${factorial(n)}");
}
