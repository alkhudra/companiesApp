import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/helpers/contact_helper.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/order_helper.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/helpers/route_helper.dart';
import 'package:khudrah_companies/network/models/orders/order_header.dart';
import 'package:khudrah_companies/network/models/orders/submit_order_success_response_model.dart';
import 'package:khudrah_companies/pages/cart/cart_page.dart';
import 'package:khudrah_companies/pages/dashboard.dart';
import 'package:khudrah_companies/pages/orders/order_details.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderCompletedPage extends StatefulWidget {
  final bool? isSuccess;
  final SubmitOrderSuccessResponseModel? model;

  const OrderCompletedPage({Key? key, this.isSuccess, this.model})
      : super(key: key);

  @override
  _OrderCompletedPageState createState() => _OrderCompletedPageState();
}

class _OrderCompletedPageState extends State<OrderCompletedPage> {
  @override
  Widget build(BuildContext context) {
    String txt = widget.isSuccess!
        ? LocaleKeys.order_complete_successfully.tr()
        : LocaleKeys.order_complete_fail.tr();
    String lottieUrl = widget.isSuccess!
        ? 'images/order_complete.json'
        : 'images/order_fail.json';


    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Lottie.asset(
                    lottieUrl,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    txt,
                    style: TextStyle(
                      color: CustomColors().primaryGreenColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget.isSuccess == true && widget.model != null && widget.model!.orderHeader != null )
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          LocaleKeys.order_no.tr() +
                              '#' +
                              (widget.model!.orderHeader!.invoiceNumber!)
                                  .toString(),
                          style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      greenBtn(LocaleKeys.display_invoice.tr(),
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          () {
                        print(widget.model!.orderHeader!
                            .hasOrderCreatedFromDashboard!);
                        OrderHelper.displayInvoice(
                            widget.model!.invoicePDFPath,
                            widget.model!.orderHeader!
                                .hasOrderCreatedFromDashboard!);
                      }),
                    ],
                  ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    moveToNewStack(context, dashBoardRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(LocaleKeys.main_page.tr(),
                        style: TextStyle(
                            fontSize: 20,
                            color: CustomColors().primaryGreenColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
