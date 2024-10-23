import 'package:e_commerce/common/widget/custom_shape/container/circular_container.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/data/repositories/addresses/address_repository.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/features/personalization/screens/address/add_new_address.dart';
import 'package:e_commerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();

  RxBool refreshData = true.obs;
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  GlobalKey<FormState> newAddressKey = GlobalKey<FormState>();

  Future<List<AddressModel>> getAllUserAddress() async {
    try {
      final address = await addressRepository.fetchUserAddress();
      selectedAddress.value = address.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return address;
    } catch (e) {
      TLoader.errorSnackBar(title: 'Oh Snap!!!', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      // Get.defaultDialog(
      //   title: '',
      //   onWillPop: () async {
      //     return false;
      //   },
      //   barrierDismissible: false,
      //   backgroundColor: Colors.transparent,
      //
      //
      //   // content: TCircularContainer(),
      //
      // );
      Get.defaultDialog(
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Material(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "New Address Selected",
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),
                        //Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                child: const Text(
                                  'Done',
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(0, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

      // Clear selected address
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      /// Assign true for new customers
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
      Get.back();
    } catch (e) {
      TLoader.errorSnackBar(title: 'Oh Snap!!!', message: e.toString());
      return [];
    }
  }

  Future addNewAddress() async {
    try {
      TLoader.customToast(message: 'New Address Added Successfully');

      /// Form validation
      if (!newAddressKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = addressRepository.addAddress(address);
      address.id = id as String;
      await selectedAddress(address);

      TLoader.successSnackBar(
          title: 'Congratulation!',
          message: 'Your address has been successfully updated.');

      refreshData.toggle();
      resetFormField();
    } catch (e) {
      print('******* $e');
      throw 'Fail to add new address';
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.all(TSizes.lg),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeading(title: 'Select Address'),
                    FutureBuilder(
                        future: getAllUserAddress(),
                        builder: (_, snapshot) {
                          final response =
                              TCloudHelperFunctions.checkMultiRecordState(
                                  snapshot: snapshot);
                          if (response != null) return response;

                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) => SingleAddress(
                                  address: snapshot.data![index],
                                  onTap: () async {
                                    await selectedAddress(
                                        snapshot.data![index]);
                                    Get.back();
                                  }));
                        }),
                    SizedBox(
                      height: TSizes.defaultSpace * 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => Get.to(() => AddNewAddressScreen()),
                          child: Text('Add new address')),
                    )
                  ],
                ),
              ),
            ));
  }

  void resetFormField() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    newAddressKey.currentState?.reset();
  }
}
