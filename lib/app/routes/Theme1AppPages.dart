import 'package:get/get.dart' show GetPage, Transition;
import 'package:my_local_vendor/app/bindings/add_product_binding.dart';
import 'package:my_local_vendor/app/bindings/auth_binding.dart';
import 'package:my_local_vendor/app/bindings/category_binding.dart';
import 'package:my_local_vendor/app/bindings/chat_binding.dart';
import 'package:my_local_vendor/app/bindings/contact_binding.dart';
import 'package:my_local_vendor/app/bindings/credit_binding.dart';
import 'package:my_local_vendor/app/bindings/home_binding.dart';
import 'package:my_local_vendor/app/bindings/my_orders_binding.dart';
import 'package:my_local_vendor/app/bindings/notification_binding.dart';
import 'package:my_local_vendor/app/bindings/paylater_binding.dart';
import 'package:my_local_vendor/app/bindings/payment_binding.dart';
import 'package:my_local_vendor/app/bindings/product_binding.dart';
import 'package:my_local_vendor/app/bindings/product_detail_binding.dart';
import 'package:my_local_vendor/app/bindings/profile_binding.dart';
import 'package:my_local_vendor/app/bindings/reset_password_binding.dart';
import 'package:my_local_vendor/app/bindings/search_binding.dart';
import 'package:my_local_vendor/app/bindings/splash_binding.dart';
import 'package:my_local_vendor/app/bindings/vendor_chat_binding.dart';
import 'package:my_local_vendor/app/bindings/wishlist_binding.dart';
import 'package:my_local_vendor/app/middlewares/auth_middleware.dart';
import 'package:my_local_vendor/app/ui/add_product/add_product_view.dart';
import 'package:my_local_vendor/app/ui/auth/login_view.dart';
import 'package:my_local_vendor/app/ui/auth/signup_view.dart';
import 'package:my_local_vendor/app/ui/category/category_view.dart';
import 'package:my_local_vendor/app/ui/chat/chat_view.dart';
import 'package:my_local_vendor/app/ui/chat/vendor_chatlist_view.dart';
import 'package:my_local_vendor/app/ui/check_credit_score/check_credit_view.dart';
import 'package:my_local_vendor/app/ui/contact/contact_view.dart';
import 'package:my_local_vendor/app/ui/home/home_view.dart';
import 'package:my_local_vendor/app/ui/my_orders/my_orders_view.dart';
import 'package:my_local_vendor/app/ui/my_products/edit_product.dart';
import 'package:my_local_vendor/app/ui/my_products/my_product_view.dart';
import 'package:my_local_vendor/app/ui/notification/notification_view.dart';
import 'package:my_local_vendor/app/ui/pay_later/pay_later_view.dart';
import 'package:my_local_vendor/app/ui/payment/payment_view.dart';
import 'package:my_local_vendor/app/ui/product/product_detail.dart';
import 'package:my_local_vendor/app/ui/product/product_view.dart';
import 'package:my_local_vendor/app/ui/profile/edit_profile_view.dart';
import 'package:my_local_vendor/app/ui/profile/profile_view.dart';
import 'package:my_local_vendor/app/ui/reset_password/check_email_view.dart';
import 'package:my_local_vendor/app/ui/reset_password/create_password.dart';
import 'package:my_local_vendor/app/ui/reset_password/reset_password_view.dart';
import 'package:my_local_vendor/app/ui/review/my_review_view.dart';
import 'package:my_local_vendor/app/ui/root/root_view.dart';
import 'package:my_local_vendor/app/ui/search/search_view.dart';
import 'package:my_local_vendor/app/ui/splash/splash_view.dart';
import 'package:my_local_vendor/app/ui/wishlist/wishlist_view.dart';

import '../bindings/my_product_binding.dart';
import '../bindings/review_binding.dart';
import '../ui/my_orders/vendor_orders_view.dart';
import '../ui/order_detail/order_detal_view.dart';
import '../ui/payment/summary_view.dart';
import '../ui/review/detail_review.dart';
import 'app_routes.dart';

class Theme1AppPages {
  static const INITIAL = Routes.Root;

  static final routes = [
    GetPage(name: Routes.Root, page: () => RootView(),middlewares: [AuthMiddleware()]),
    GetPage(name: Routes.Splash, page: () => SplashView(),binding: SplashBinding()),
    GetPage(name: Routes.Login, page: () => LoginView(),binding: AuthBinding()),
    GetPage(name: Routes.Signup, page: () => SignUpView(),binding: AuthBinding()),
    GetPage(name: Routes.Home, page: () => HomeView(),binding: HomeBinding()),
    GetPage(name: Routes.Category, page: () => CategoryView(),binding: CategoryBinding()),
    GetPage(name: Routes.ProductView, page: () => ProductView(),binding: ProductBinding()),
    GetPage(name: Routes.ProductDetail, page: () => ProductDetail(),binding: ProductDetailBinding()),
    GetPage(name: Routes.CheckCreditView, page: () => CheckCreditView(),binding: CreditBinding()),
    GetPage(name: Routes.PayLaterView, page: () => PayLaterView(),binding: PayLaterBinding()),
    GetPage(name: Routes.PaymentView, page: () => PaymentView(),binding: PaymentBinding()),
    GetPage(name: Routes.MyOrderView, page: () => MyOrdersView(),binding: MyOrdersBinding()),
    GetPage(name: Routes.OrderDetailView, page: () => OrderDetailView(),binding: MyOrdersBinding()),
    GetPage(name: Routes.VendorOrderView, page: () => VendorOrdersView(),binding: MyOrdersBinding()),
    GetPage(name: Routes.WishlistView, page: () => WishlistView(),binding: WishlistBinding()),
    GetPage(name: Routes.ProfileView, page: () => ProfileView(),binding: ProfileBinding()),
    GetPage(name: Routes.EditProfileView, page: () => EditProfileView(),binding: ProfileBinding()),
    GetPage(name: Routes.ContactView, page: () => ContactView(),binding: ContactBinding()),
    GetPage(name: Routes.AddProductView, page: () => AddProductView(),binding: AddProductBinding()),
    GetPage(name: Routes.NotificationView, page: () => NotificationView(),binding: NotificationBinding()),
    GetPage(name: Routes.ResetPassword, page: () => ResetPasswordView(),binding: ResetPAsswordBinding()),
    GetPage(name: Routes.CheckEmailView, page: () => CheckEmailView(),binding: ResetPAsswordBinding()),
    GetPage(name: Routes.CreatePassword, page: () => CreatePasswordView(),binding: ResetPAsswordBinding()),
    GetPage(name: Routes.ChatView, page: () => ChatView(),binding: ChatBinding()),
    GetPage(name: Routes.VendorChats, page: () => VendorChats(),binding: VendorChatBinding()),
    GetPage(name: Routes.Search, page: () => SearchView(),binding: SearchBinding()),
    GetPage(name: Routes.SummaryView, page: () => SummaryView(),binding: PaymentBinding()),
    GetPage(name: Routes.MyReviewView, page: () => MyReviewView(),binding: ReviewBindng()),
    GetPage(name: Routes.DetailReview, page: () => DetailReview(),binding: ReviewBindng()),
    GetPage(name: Routes.MyProductsView, page: () => MyProductView(),binding: MyProductBinding()),
    GetPage(name: Routes.EditProductView, page: () => EditProductView(),binding: MyProductBinding()),
  ];

}
