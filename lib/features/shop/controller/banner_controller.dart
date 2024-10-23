import 'package:get/get.dart';

import '../../../data/repositories/banners/banner_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../model/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();

    super.onInit();
  }

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  /// fetch Banners
  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final bannerRepo =
          Get.put(BannerRepository()); // Or inject as a dependency
      final banners = await bannerRepo.fetchBanners();
      print('okieeeeeeeeeeeeee');
      this.banners.assignAll(banners);
      print('===========??????????????????Banner controller');
      // Signal state change
    } catch (e) {
      print('Error fetching banners: ${e.toString()}');
      TLoader.errorSnackBar(
          title: 'Oh Snap!!', message: 'Something went wrong.');
    } finally {
      isLoading.value = false;
      // refresh();
    }
  }
}
