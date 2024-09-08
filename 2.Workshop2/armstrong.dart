import 'dart:math';

bool ArmstrongNumber(int number) {
  int originalNumber = number;
  // Girilen sayının basamak sayısı bulunur.
  int digitNumber = number.toString().length;
  //number = 153 ise digitNumber = 3 olur.
  int sum = 0;

  for (int i = 0; i < digitNumber; i++) {
    int digit = (number % 10);
    sum += pow(digit, digitNumber).toInt();
    number = number ~/ 10;
  }

  // digitNUmber=3, 153 % 10 = 3, digit = 3, 3^3 = 27, SUM = 27 oldu, 153 / 10 = 15, number artık 15.
  // digitNUmber=3, 15 % 10 = 5, digit = 5, 5^3 = 125, SUM = 125+27 = 152, 15 /10 = 1, number artık 1.
  // digitNumber=3, 1 % 10 = 1, digit = 1, 1^3 = 1, SUM = 1+125+27 = 153 olur.

  return originalNumber == sum;
}

void main() {
  // Programı test etmek için sayılar belirledim.
  List<int> numberList = [1, 12, 153, 200, 370, 371, 890, 4856, 93084];

  for (int number in numberList) {
    if (ArmstrongNumber(number)) {
      print('$number bir Armstrong sayidir.');
    } else {
      print('$number bir Armstrong sayi değildir.');
    }
  }
}
