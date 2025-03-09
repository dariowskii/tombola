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
