/// path assets (svgs and pngs) path
const String baseImagesPath = 'assets/images/';

/// app logo
final String icFlower = 'ic_flower'.png;
final String icArrow = 'ic_arrow'.png;

/// extensions
extension ImageExtension on String {
  // png paths
  String get png => '$baseImagesPath$this.png';
}
