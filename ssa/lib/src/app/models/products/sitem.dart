import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/products/sitem_detail.dart';

part 'sitem.g.dart';

@JsonSerializable()
class Sitem {
  Sitem({
    required this.sysSitemId,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.tax,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.price4,
    required this.price5,
    required this.specialPrice1,
    required this.specialPrice2,
    required this.specialPrice3,
    required this.specialPrice4,
    required this.specialPrice5,
    required this.enabled,
    required this.scale,
    required this.isCondimentChain,
    required this.condimentEntry,
    required this.hasImage,
    required this.sysStoreCategory,
    required this.sysStoreCategoryId,
    required this.sysCondimentTableId,
    required this.sysCondimentChainId,
    required this.stockCount,
  });

  Sitem.copy(Sitem value)
      : this(
          sysSitemId: value.sysSitemId,
          name: value.name,
          shortDescription: value.shortDescription,
          description: value.description,
          tax: value.tax,
          price1: value.price1,
          price2: value.price2,
          price3: value.price3,
          price4: value.price4,
          price5: value.price5,
          specialPrice1: value.specialPrice1,
          specialPrice2: value.specialPrice2,
          specialPrice3: value.specialPrice3,
          specialPrice4: value.specialPrice4,
          specialPrice5: value.specialPrice5,
          enabled: value.enabled,
          scale: value.scale,
          isCondimentChain: value.isCondimentChain,
          condimentEntry: value.condimentEntry,
          hasImage: value.hasImage,
          sysStoreCategory: value.sysStoreCategory,
          sysStoreCategoryId: value.sysStoreCategoryId,
          sysCondimentTableId: value.sysCondimentTableId,
          sysCondimentChainId: value.sysCondimentChainId,
          stockCount: value.stockCount,
        );

  factory Sitem.fromJson(Map<String, dynamic> json) => _$SitemFromJson(json);

  Sitem.fromSitemDetail(SitemDetail sitemDetail)
      : sysSitemId = sitemDetail.sysSitemId,
        name = sitemDetail.name,
        shortDescription = sitemDetail.shortDescription,
        description = sitemDetail.description,
        tax = sitemDetail.tax,
        price1 = sitemDetail.price1,
        price2 = sitemDetail.price2,
        price3 = sitemDetail.price3,
        price4 = sitemDetail.price4,
        price5 = sitemDetail.price5,
        specialPrice1 = sitemDetail.specialPrice1,
        specialPrice2 = sitemDetail.specialPrice2,
        specialPrice3 = sitemDetail.specialPrice3,
        specialPrice4 = sitemDetail.specialPrice4,
        specialPrice5 = sitemDetail.specialPrice5,
        enabled = sitemDetail.enabled,
        scale = sitemDetail.scale,
        isCondimentChain = sitemDetail.isCondimentChain,
        condimentEntry = sitemDetail.condimentEntry,
        hasImage = sitemDetail.hasImage,
        sysStoreCategory = sitemDetail.sysStoreCategory,
        sysStoreCategoryId = sitemDetail.sysStoreCategoryId,
        sysCondimentTableId = sitemDetail.sysCondimentTableId,
        sysCondimentChainId = sitemDetail.sysCondimentChainId,
        stockCount = sitemDetail.stockCount;

  Map<String, dynamic> toJson() => _$SitemToJson(this);

  final String sysSitemId;
  final String name;
  final String shortDescription;
  final String description;
  final int tax;
  final double price1;
  final double price2;
  final double price3;
  final double price4;
  final double price5;
  final double? specialPrice1;
  final double? specialPrice2;
  final double? specialPrice3;
  final double? specialPrice4;
  final double? specialPrice5;
  final bool enabled;
  final bool scale;
  final bool isCondimentChain;
  final bool condimentEntry;
  final bool hasImage;
  final String sysStoreCategory;
  final String sysStoreCategoryId;
  final String? sysCondimentTableId;
  final String? sysCondimentChainId;
  final int? stockCount;

  bool get hasCondimentChain => !(sysCondimentChainId?.isEmpty ?? true) && isCondimentChain;

  bool get hasCondimentTable => !(sysCondimentTableId?.isEmpty ?? true) && !isCondimentChain;

  bool get available {
    if (stockCount == null) {
      return true;
    } else {
      return stockCount! > 0;
    }
  }

  String get availableDisplay {
    if (stockCount == null) {
      return 'Available';
    } else {
      if (stockCount! > 0) {
        return '$stockCount in stock';
      } else {
        return 'Unavailable';
      }
    }
  }

  bool isOnSpecial(int priceLevel) {
    switch (priceLevel) {
      case 2:
        {
          return specialPrice2 != null;
        }

      case 3:
        {
          return specialPrice3 != null;
        }
      case 4:
        {
          return specialPrice4 != null;
        }
      case 5:
        {
          return specialPrice5 != null;
        }

      default:
        {
          return specialPrice1 != null;
        }
    }
  }

  double price(int priceLevel) {
    if (isOnSpecial(priceLevel)) {
      switch (priceLevel) {
        case 2:
          {
            return specialPrice2!;
          }

        case 3:
          {
            return specialPrice3!;
          }
        case 4:
          {
            return specialPrice4!;
          }
        case 5:
          {
            return specialPrice5!;
          }

        default:
          {
            return specialPrice1!;
          }
      }
    } else {
      switch (priceLevel) {
        case 2:
          {
            return price2;
          }

        case 3:
          {
            return price3;
          }
        case 4:
          {
            return price4;
          }
        case 5:
          {
            return price5;
          }

        default:
          {
            return price1;
          }
      }
    }
  }

  double regularPrice(int priceLevel) {
    switch (priceLevel) {
      case 2:
        {
          return price2;
        }

      case 3:
        {
          return price3;
        }
      case 4:
        {
          return price4;
        }
      case 5:
        {
          return price5;
        }

      default:
        {
          return price1;
        }
    }
  }
}
