import 'dart:core';

import 'package:e_commerce/features/shop/model/banner_model.dart';
import 'package:e_commerce/features/shop/model/brand_model.dart';
import 'package:e_commerce/features/shop/model/product_attribute_model.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/features/shop/model/product_variation_model.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/enums.dart';

class TDummyData {
  /// Banners
  static final List<BannerModel> banners = [
    BannerModel(
        imageUrl: TImages.bodyBanner1,
        targetScreen: TRoutes.order,
        active: false),
    BannerModel(
        imageUrl: TImages.bodyBanner2,
        targetScreen: TRoutes.cart,
        active: true),
    BannerModel(
        imageUrl: TImages.bodyBanner3,
        targetScreen: TRoutes.favourites,
        active: true),
    BannerModel(
        imageUrl: TImages.bodyBanner4,
        targetScreen: TRoutes.search,
        active: true),
    BannerModel(
        imageUrl: TImages.bodyBanner1,
        targetScreen: TRoutes.settings,
        active: true),
    BannerModel(
        imageUrl: TImages.bodyBanner1,
        targetScreen: TRoutes.userAddress,
        active: true),
    BannerModel(
        imageUrl: TImages.bodyBanner1,
        targetScreen: TRoutes.checkout,
        active: false),
  ];

  /// List of all Products
  static final List<ProductModel> products = [
    ProductModel(
        id: '001',
        title: 'Blue Nike Sports Shoes',
        stock: 15,
        price: 135,
        thumbnail: TImages.nike_blue_shoes,
        description: 'Blue nike sports shoes',
        brand: BrandModel(
            id: '1',
            image: TImages.nike_logo,
            productsCount: 265,
            isFeatured: true,
            name: 'Nike'),
        images: [
          TImages.nike_blue_shoes,
          TImages.nike_jordan,
          TImages.shoes_image
        ],
        salePrice: 30,
        sku: 'ABR4568',
        isFeatured: true,
        categoryId: '1',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Black', 'Red']),
          ProductAttributeModel(
              name: 'Size', values: ['EU 30', 'EU 34', 'EU 36']),
        ],
        productVariations: [
          ProductVariationModel(
              id: '1',
              stock: 34,
              price: 134,
              salePrice: 122.6,
              image: TImages.nike_jordan,
              description: 'This is Product Description for Nike Jordan Shoe.',
              attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '2',
              stock: 14,
              price: 234,
              salePrice: 232.6,
              image: TImages.nike_jordan,
              description: 'This is Product Description for Nike Jordan Shoe.',
              attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '3',
              stock: 44,
              price: 434,
              salePrice: 232.6,
              image: TImages.nike_jordan,
              description: 'This is Product Description for Nike Jordan Shoe.',
              attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
        ],
        productType: ProductType.variable.toString()),
    ProductModel(
        id: '001',
        title: 'Blue Nike Sports Shoes',
        stock: 15,
        price: 135,
        thumbnail: TImages.nike_blue_shoes,
        description: 'Blue nike sports shoes',
        brand: BrandModel(
            id: '1',
            image: TImages.nike_logo,
            productsCount: 265,
            isFeatured: true,
            name: 'Nike'),
        images: [
          TImages.nike_blue_shoes,
          TImages.nike_jordan,
          TImages.shoes_image
        ],
        salePrice: 30,
        sku: 'ABR4568',
        isFeatured: true,
        categoryId: '1',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Black', 'Red']),
          ProductAttributeModel(
              name: 'Size', values: ['EU 30', 'EU 34', 'EU 36']),
        ],
        productVariations: [
          ProductVariationModel(
              id: '1',
              stock: 34,
              price: 134,
              salePrice: 122.6,
              image: TImages.nike_jordan,
              description: 'This is Product Description for Nike Jordan Shoe.',
              attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '2',
              stock: 14,
              price: 234,
              salePrice: 232.6,
              image: TImages.nike_jordan,
              description: 'This is Product Description for Nike Jordan Shoe.',
              attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '3',
              stock: 44,
              price: 434,
              salePrice: 232.6,
              image: TImages.nike_jordan,
              description: 'This is Product Description for Nike Jordan Shoe.',
              attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
        ],
        productType: ProductType.variable.toString()),
  ];
}

/// List of all Products
