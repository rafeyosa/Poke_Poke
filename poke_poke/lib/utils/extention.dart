extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String substringByUrl(String url) {
    return substring(url.length, length-1);
  }
}
