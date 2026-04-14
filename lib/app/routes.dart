import 'package:gestao_estoque/views/suppliers_register_screen.dart';
import 'package:gestao_estoque/views/suppliers_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:gestao_estoque/views/dashboard_screen.dart';
import 'package:provider/provider.dart';

class Routes {
  static const dashboard = '/dashboard';
  static const suppliers = '/suppliers';
  static const suppliersRegister = '/suppliers-register';
}

final routes = GoRouter(
  initialLocation: Routes.dashboard,
  routes: [
    GoRoute(
      path: Routes.dashboard,
      name: Routes.dashboard,
      builder: (context, state) => DashboardScreen(
        //productsViewmodel: context.read(),
      ),
    ),
    GoRoute(
      path: Routes.suppliers,
      name: Routes.suppliers,
      builder: (context, state) =>
          SuppliersScreen(suppliersViewmodel: context.read()),
    ),
    GoRoute(
      path: Routes.suppliersRegister,
      name: Routes.suppliersRegister,
      builder: (context, state) =>
          SuppliersRegister(suppliersViewmodel: context.read()),
    ),
  ],
);
