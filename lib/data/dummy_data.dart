import 'package:e_commerce/features/shop/model/brand_model.dart';
import 'package:e_commerce/features/shop/model/product_attribute_model.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/features/shop/model/product_variation_model.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';

class DummyData {
  static final List<ProductModel> products = [
    ProductModel(
      id: '001',
      title: 'Blue Nike sports shoe',
      stock: 15,
      price: 135,
      thumbnail: TImages.nike_blue_shoes,
      isFeatured: true,
      description: 'Blue Nike sports shoe',
      brand: BrandModel(
        id: '1',
        image: TImages.nike_jordan,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [TImages.bodyBanner1, TImages.bodyBanner2, TImages.bodyBanner3],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(
            name: 'Size', values: ['EU 30', 'EU 34', 'Eu 32']),
      ],
      productVariations: [
        ProductVariationModel(
            id: '1',
            stock: 34,
            price: 134,
            salePrice: 122.6,
            image: TImages.nike_blue_shoes,
            description:
                'This is a Product description for Blue Nike sports shoe.',
            attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '2',
            stock: 15,
            price: 144,
            salePrice: 122.6,
            image: TImages.nike_jordan,
            description: 'This is a Product description for Nike jordan shoe.',
            attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
      ],
      productType: 'ProductType.variable',
    ),
  ];
}
