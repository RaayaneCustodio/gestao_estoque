import 'package:gestao_estoque/views/home_page_screen.dart';
import 'package:gestao_estoque/views/suppliers_register_screen.dart';
import 'package:gestao_estoque/views/suppliers_screen.dart';
import 'package:gestao_estoque/views/products_screen.dart';
import 'package:gestao_estoque/views/add_product_screen.dart';
import 'package:gestao_estoque/views/customers_screen.dart';
import 'package:gestao_estoque/views/customers_register_screen.dart';
import 'package:gestao_estoque/views/sale_screen.dart';
import 'package:gestao_estoque/viewsmodel/suppliers_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/customers_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/products_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:gestao_estoque/views/dashboard_screen.dart';
import 'package:provider/provider.dart';


class Routes {
  static const homePageScreen = '/home-page-screen';
  static const dashboard = '/dashboard';
  static const suppliers = '/suppliers';
  static const suppliersRegister = '/suppliers-register';
  static const products = '/products';
  static const addProduct = '/add-product';
  static const customers = '/customers';
  static const customersRegister = '/customers-register';
  static const sale = '/sale';
}

final routes = GoRouter(
  initialLocation: Routes.homePageScreen,
  routes: [
    GoRoute(
      path: Routes.homePageScreen,
      name: Routes.homePageScreen,
      builder: (context, state) => HomePageScreen(
        
      ),
    ),
    GoRoute(
      path: Routes.dashboard,
      name: Routes.dashboard,
      builder: (context, state) => DashboardScreen(
        
      ),
    ),
    GoRoute(
      path: Routes.suppliers,
      name: Routes.suppliers,
      builder: (context, state) =>
          SuppliersScreen(suppliersViewmodel: context.read()),
    ),
    GoRoute(
      path: Routes.addProduct,
      name: Routes.addProduct,
      builder: (context, state) => AddProductScreen(
        productsViewModel: context.read(),
        suppliersViewModel: context.read<SuppliersViewmodel>(),
      ),
    ),
    GoRoute(
      path: Routes.suppliersRegister,
      name: Routes.suppliersRegister,
      builder: (context, state) =>
          SuppliersRegister(suppliersViewmodel: context.read()),
    ),
    GoRoute(
      path: Routes.products,
      name: Routes.products,
      builder: (context, state) => ProductsScreen(
        productsViewmodel: context.read(),
        suppliersViewmodel: context.read<SuppliersViewmodel>(),
      ),
    ),
    GoRoute(
      path: Routes.customers,
      name: Routes.customers,
      builder: (context, state) =>
          CustomersScreen(customersViewModel: context.read()),
    ),
    GoRoute(
      path: Routes.customersRegister,
      name: Routes.customersRegister,
      builder: (context, state) =>
          CustomersRegister(customersViewModel: context.read()),
    ),
    GoRoute(
      path: Routes.sale,
      name: Routes.sale,
      builder: (context, state) => SaleScreen(
        saleViewModel: context.read(),
        productsViewModel: context.read<ProductsViewModel>(),
        customersViewModel: context.read<CustomersViewModel>(),
      ),
    ),
  ],
);
