
extension IntExtensions on int {
   String putZeroInSingleDigit() {
    if (this < 10) {
      return '0$this';
    }
    return '$this';
  }
} 
