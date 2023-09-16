abstract class BaseCard {
  String? getName();

  String? getId();

  String? getImageUrl({bool? firstFace});

  String? getManaCost();

  String? getType();

  String? getText();

  Map<String, String?> getPrices();
}
