import 'package:get/get.dart';

import '../bindings/root_bindings.dart';

import '../view/home/bottombar.dart';

class AppPage {
  static var list = [
    GetPage(
        name: "/", page: () =>  BottomBar(), binding: RootBinding()),
    //  GetPage(
    //   name: "/checkout",
    //   page: () => CheckOut(),

    // ),
    // GetPage(
    //   name: "/webview",
    //   page: () => webView(
    //     url: '',
    //     type: '',
    //   ),
    // ),
    // GetPage(
    //     name: "/eventDetail/:id",
    //     page: () => EventDetails(),
    //     binding: EventBindings()),
    //      GetPage(
    //     name: "/vendorDeatils",
    //     page: () => VendorDetails(),
    //     binding: VendorBinding()),
    // GetPage(
    //   name: "/ticketDetails/:id",
    //   page: () => TicketDetails(),
    //   binding: TicketDetailsBinding(),
    //   transition: Transition.zoom,
    //   transitionDuration: Duration(milliseconds: 300),
    //   fullscreenDialog: true,
    // ),
  ];
}
