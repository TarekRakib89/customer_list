import 'package:cached_network_image/cached_network_image.dart';
import 'package:customerlist_app/app/data/models/customer_model.dart';
import 'package:customerlist_app/app/modules/customer_details/view/customer_details_view.dart';
import 'package:customerlist_app/app/modules/home/controller/home_controller.dart';
import 'package:customerlist_app/util/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _homeController = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    _homeController.getCustomerList();
    _homeController.scrollController.addListener(loadMoreData);
  }

  int lengthh = 0;

  void loadMoreData() {
    if (_homeController.scrollController.position.pixels ==
            _homeController.scrollController.position.maxScrollExtent &&
        _homeController.customer.length < _homeController.totalCustomer) {
      _homeController.getCustomerList();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "CUSTOMER LIST",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: false,
                controller: controller.scrollController,
                // scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
                itemBuilder: (contex, index) {
                  var customer = controller.customer[index];
                  return customerListCard(size, customer, index, controller);
                },
                itemCount: controller.customer.length),
          ),
        );
      }),
    );
  }

  Widget customerListCard(
      Size size, CustomerList customer, int index, HomeController controller) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    debugPrint(isPortrait.toString());
    return GestureDetector(
      onTap: () {
        Get.to(
          CustomerDetailsView(
            customer: customer,
            pageNo: controller.pageNo,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: _homeController.loader
            ? Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  width: size.width,
                  height: isPortrait ? size.height * 0.12 : size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    width: size.width,
                    height:
                        isPortrait ? size.height * 0.12 : size.height * 0.25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipOval(
                            child: customer.imagePath != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        "https://www.pqstec.com/InvoiceApps${customer.imagePath}",
                                    width: 80.w,
                                    height: 90.h,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter: const ColorFilter.mode(
                                                Colors.red,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : Image.network(
                                    "https://img.freepik.com/premium-vector/social-media-user-profile-icon-video-call-screen_97886-10046.jpg?w=740",
                                    width: 80.w,
                                    height: 90.h,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(customer.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: fontBoldWithColorBlack),
                                customer.email == null
                                    ? const SizedBox()
                                    : Text(customer.email!,
                                        overflow: TextOverflow.ellipsis,
                                        style: fontSizeSmallGray),
                                Text(
                                  customer.phone ?? '',
                                  style: fontSizeSmallGray,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (index == (controller.customer.length - 1) &&
                      controller.loader)
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SpinKitThreeBounce(
                        color: Colors.purple,
                        size: 40,
                      ),
                    )
                ],
              ),
      ),
    );
  }

  Widget customerListCardInRow(
      Size size, CustomerList customer, int index, HomeController controller) {
    return GestureDetector(
      onTap: () {
        Get.to(
          CustomerDetailsView(
            customer: customer,
            pageNo: controller.pageNo,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: _homeController.loader
            ? Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  width: size.width,
                  height: size.height * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.35,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipOval(
                            child: customer.imagePath != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        "https://www.pqstec.com/InvoiceApps${customer.imagePath}",
                                    width: 90.w,
                                    height: 90.h,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter: const ColorFilter.mode(
                                                Colors.red,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : Image.network(
                                    "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                                    width: 90.w,
                                    height: 90.h,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(customer.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: fontBoldWithColorBlack),
                                customer.email == null
                                    ? const SizedBox()
                                    : Text(customer.email!,
                                        overflow: TextOverflow.ellipsis,
                                        style: fontSizeSmallGray),
                                Text(
                                  customer.phone ?? '',
                                  style: fontSizeSmallGray,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (index == (controller.customer.length - 1) &&
                      controller.loader)
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SpinKitThreeBounce(
                        color: Colors.purple,
                        size: 40,
                      ),
                    )
                ],
              ),
      ),
    );
  }
}
