// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customerlist_app/app/data/models/customer_model.dart';
import 'package:customerlist_app/util/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerDetailsView extends StatelessWidget {
  const CustomerDetailsView({
    Key? key,
    required this.customer,
    required this.pageNo,
  }) : super(key: key);
  final CustomerList customer;
  final int pageNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "CUSTOMER DETAILS",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //image, name,email,phone
            customerProfileSection(context),
            const SizedBox(
              height: 10,
            ),
            customerDetailSection(context),
          ],
        ),
      ),
    );
  }

  Widget customerProfileSection(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          ClipOval(
            child: customer.imagePath != null
                ? CachedNetworkImage(
                    imageUrl:
                        "https://www.pqstec.com/InvoiceApps${customer.imagePath}",
                    width: 160.w,
                    height: 140.h,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(
                            Colors.red,
                            BlendMode.colorBurn,
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image.network(
                    "https://img.freepik.com/premium-vector/social-media-user-profile-icon-video-call-screen_97886-10046.jpg?w=740",
                    width: 160.w,
                    height: 140.h,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Name: ',
                      style: fontBoldWithColorBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: Text(
                        customer.name ?? '',
                        style: fontBoldWithColorBlack,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                customer.email == null
                    ? const SizedBox()
                    : Row(children: [
                        Text('Email: ', style: fontBoldWithColorBlack),
                        Expanded(
                          child: Text(
                            customer.email!,
                            style: fontBoldWithColorBlack,
                          ),
                        ),
                      ]),
                Row(
                  children: [
                    Text(
                      'Phone: ',
                      style: fontBoldWithColorBlack,
                    ),
                    Text(
                      customer.phone ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: fontBoldWithColorBlack,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customerDetailSection(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60), topRight: Radius.circular(60))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: Text(
                  'Address :',
                  style: fontBoldWithColorGrey,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(customer.primaryAddress ?? ''),
                    Text(customer.secoundaryAddress ?? ''),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'Notes :',
                  style: fontBoldWithColorGrey,
                ),
                subtitle: Text(customer.notes ?? ''),
              ),
              ListTile(
                title: Text(
                  'Customer Type :',
                  style: fontBoldWithColorGrey,
                ),
                subtitle: Text(customer.custType ?? ''),
              ),
              ListTile(
                title: Text(
                  'Parent Customer :',
                  style: fontBoldWithColorGrey,
                ),
                subtitle: Text(customer.parentCustomer ?? ''),
              ),
              ListTile(
                title: Text(
                  'Last Sales Date :',
                  style: fontBoldWithColorGrey,
                ),
                subtitle: Text(customer.lastSalesDate ?? ''),
              ),
              ListTile(
                title: Text(
                  'Last Sold Product :',
                  style: fontBoldWithColorGrey,
                ),
                subtitle: Text(customer.lastSoldProduct ?? ''),
              ),
              ListTile(
                title: Text(
                  'Total Amount Back :',
                  style: fontBoldWithColorGrey,
                ),
                subtitle: Text(customer.totalAmountBack.toString()),
              ),
              ListTile(
                title: Text(
                  'Total Collection :',
                  style: fontBoldWithColorGrey,
                ),
                subtitle: Text(customer.totalCollection.toString()),
              ),
              ListTile(
                title: Text(
                  'Last Transaction Date :',
                  style: fontBoldWithColorGrey,
                ),
                subtitle: Text(customer.lastTransactionDate ?? ''),
              ),
              ListTile(
                title: Text(
                  'Client Company Name :',
                  style: fontBoldWithColorGrey,
                ),
                subtitle: Text(customer.clinetCompanyName ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// },
