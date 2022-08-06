import 'package:kiwi/kiwi.dart';
import 'app_routes.dart';

class AppInjector {
  /// Singleton class instance provided by the [kiwi] library.
  static KiwiContainer container = KiwiContainer();

  /// Configures the Injector.
  static setUp() async {
    await _configure();
  }

  /// Provides the instances of registered classes from the singleton class [Container].
  static final resolve = container.resolve;

  /// Clears all the instances of registered classes from the singleton class [Container].
  static clear() => container.clear();

  /// Stores the instances of the registered classes in to the singleton class [Container]
  /// provided by the [kiwi] library.
  static _configure() async {
    container.registerSingleton((container) => AppRoutes());
  }
}
