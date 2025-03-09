const kRaffleCardRowNumber = 3;
const kRaffleCardColumnNumber = 9;
const kRaffleCardSize = 30;

const kMaxExtractableNumbers = 90;

// ASSETS

enum AssetMedia {
  welcomeBackground('assets/img/welcome_bg.jpg');

  const AssetMedia(this.path);
  final String path;
}

// SPACING

enum Spacing {
  small(8.0),
  medium(16.0),
  large(24.0);

  const Spacing(this.value);
  final double value;
}
