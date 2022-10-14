import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:super_widgets/utils/http_overrides.dart';

class MainApp extends StatelessWidget {
  ///region Vars
  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? lightTheme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final CustomTransition? customTransition;
  final Color? color;
  final Map<String, Map<String, String>>? translationsKeys;
  final Translations? translations;
  final TextDirection? textDirection;
  final Locale? locale;
  final Locale? fallbackLocale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final ScrollBehavior? scrollBehavior;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final Map<Type, Action<Intent>>? actions;
  final bool debugShowMaterialGrid;
  final ValueChanged<Routing?>? routingCallback;
  final Transition? defaultTransition;
  final bool? opaqueRoute;
  final VoidCallback? onInit;
  final VoidCallback? onReady;
  final VoidCallback? onDispose;
  final bool? enableLog;
  final LogWriterCallback? logWriterCallback;
  final bool? popGesture;
  final SmartManagement smartManagement;
  final Bindings? initialBinding;
  final Duration? transitionDuration;
  final bool? defaultGlobalState;
  final List<GetPage>? getPages;
  final GetPage? unknownRoute;
  late final RouteInformationProvider? routeInformationProvider;
  late final RouteInformationParser<Object>? routeInformationParser;
  late final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final bool useInheritedMediaQuery;

  ///endregion Vars

  ///region _internal
  MainApp._internal(
    this.routeInformationProvider,
    RouteInformationParser<Object>? routeInformationParser,
    RouterDelegate<Object>? routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title,
    this.onGenerateTitle,
    this.color,
    this.lightTheme,
    this.darkTheme,
    this.useInheritedMediaQuery,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales,
    this.debugShowMaterialGrid,
    this.showPerformanceOverlay,
    this.checkerboardRasterCacheImages,
    this.checkerboardOffscreenLayers,
    this.showSemanticsDebugger,
    this.debugShowCheckedModeBanner,
    this.shortcuts,
    this.scrollBehavior,
    this.actions,
    this.customTransition,
    this.translationsKeys,
    this.translations,
    this.textDirection,
    this.fallbackLocale,
    this.routingCallback,
    this.defaultTransition,
    this.opaqueRoute,
    this.onInit,
    this.onReady,
    this.onDispose,
    this.enableLog,
    this.logWriterCallback,
    this.popGesture,
    this.smartManagement,
    this.initialBinding,
    this.transitionDuration,
    this.defaultGlobalState,
    this.getPages,
    this.navigatorObservers,
    this.unknownRoute,
    this.scaffoldMessengerKey,
    this.navigatorKey,
    this.home,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
  )   : routerDelegate = routerDelegate ??= Get.createDelegate(
          notFoundRoute: unknownRoute,
        ),
        routeInformationParser = routeInformationParser ??= Get.createInformationParser(
          initialRoute: getPages?.first.name ?? '/',
        ) {
    Get.routerDelegate = routerDelegate;
    Get.routeInformationParser = routeInformationParser;
  }

  ///endregion _internal

  static late final MainApp _instance;

  factory MainApp({
    routeInformationProvider,
    RouteInformationParser<Object>? routeInformationParser,
    RouterDelegate<Object>? routerDelegate,
    backButtonDispatcher,
    builder,
    required title,
    onGenerateTitle,
    color,
    lightTheme,
    darkTheme,
    useInheritedMediaQuery,
    highContrastTheme,
    highContrastDarkTheme,
    themeMode,
    locale=const Locale('en'),
    localizationsDelegates,
    localeListResolutionCallback,
    localeResolutionCallback,
    supportedLocales=const <Locale>[
  Locale('ar'),
  Locale('en'),
  ],
    debugShowMaterialGrid,
    showPerformanceOverlay,
    checkerboardRasterCacheImages,
    checkerboardOffscreenLayers,
    showSemanticsDebugger,
    debugShowCheckedModeBanner,
    shortcuts,
    scrollBehavior,
    actions,
    customTransition,
    translationsKeys,
    translations,
    textDirection,
    fallbackLocale,
    routingCallback,
    defaultTransition,
    opaqueRoute,
    onInit,
    onReady,
    onDispose,
    enableLog,
    logWriterCallback,
    popGesture,
    smartManagement,
    initialBinding,
    transitionDuration,
    defaultGlobalState,
    getPages,
    navigatorObservers,
    unknownRoute,
    scaffoldMessengerKey,
    navigatorKey,
    home,
    routes,
    initialRoute,
    onGenerateRoute,
    onGenerateInitialRoutes,
    onUnknownRoute,
  }) {
    _instance = MainApp._internal(
      routeInformationProvider,
      routeInformationParser,
      routerDelegate,
      backButtonDispatcher,
      builder,
      title,
      onGenerateTitle,
      color,
      lightTheme,
      darkTheme,
      useInheritedMediaQuery,
      highContrastTheme,
      highContrastDarkTheme,
      themeMode,
      locale,
      localizationsDelegates,
      localeListResolutionCallback,
      localeResolutionCallback,
      supportedLocales,
      debugShowMaterialGrid,
      showPerformanceOverlay,
      checkerboardRasterCacheImages,
      checkerboardOffscreenLayers,
      showSemanticsDebugger,
      debugShowCheckedModeBanner,
      shortcuts,
      scrollBehavior,
      actions,
      customTransition,
      translationsKeys,
      translations,
      textDirection,
      fallbackLocale,
      routingCallback,
      defaultTransition,
      opaqueRoute,
      onInit,
      onReady,
      onDispose,
      enableLog,
      logWriterCallback,
      popGesture,
      smartManagement,
      initialBinding,
      transitionDuration,
      defaultGlobalState,
      getPages,
      navigatorObservers,
      unknownRoute,
      scaffoldMessengerKey,
      navigatorKey,
      home,
      routes,
      initialRoute,
      onGenerateRoute,
      onGenerateInitialRoutes,
      onUnknownRoute,
    );
    return _instance;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: key,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: title,
      translations: translations,
      color: color,
      actions: actions,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      customTransition: customTransition,
      debugShowMaterialGrid: debugShowMaterialGrid,
      defaultGlobalState: defaultGlobalState,
      enableLog: enableLog,
      fallbackLocale: fallbackLocale,
      highContrastDarkTheme: highContrastDarkTheme,
      highContrastTheme: highContrastTheme,
      home: home,
      initialBinding: initialBinding,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      logWriterCallback: logWriterCallback,
      onDispose: onDispose,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onGenerateRoute: onGenerateRoute,
      onGenerateTitle: onGenerateTitle,
      onInit: onInit,
      onReady: onReady,
      onUnknownRoute: onUnknownRoute,
      opaqueRoute: opaqueRoute,
      popGesture: popGesture,
      routes: routes ?? {},
      routingCallback: routingCallback,
      scaffoldMessengerKey: scaffoldMessengerKey,
      shortcuts: shortcuts,
      showPerformanceOverlay: showPerformanceOverlay,
      showSemanticsDebugger: showSemanticsDebugger,
      smartManagement: smartManagement,
      textDirection: textDirection,
      translationsKeys: translationsKeys,
      unknownRoute: unknownRoute,
      useInheritedMediaQuery: useInheritedMediaQuery,

      ///region Routing
      initialRoute: initialRoute,
      getPages: getPages,

      ///region Routing

      ///region Themes
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,

      ///endregion Themes

      ///region Locales
      supportedLocales:supportedLocales,
      locale: locale,
      localizationsDelegates: localizationDelegates,

      ///endregion Locales

      ///endregion UI
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: mainResponsiveBuilder,
      scrollBehavior: scrollBehavior,
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 100),

      ///endregion UI
    );
  }
}

Widget mainResponsiveBuilder(BuildContext context, Widget? child) {
  final smartDialog = FlutterSmartDialog.init();
  child = smartDialog(context, child);
  child = ResponsiveWrapper.builder(
    ClampingScrollWrapper(child: child),
    minWidth: 480,
    maxWidth: 1600,
    mediaQueryData: MediaQuery.of(context).copyWith(textScaleFactor: 1),
    defaultScale: true,
    breakpoints: const [
      ResponsiveBreakpoint.autoScale(480, name: MOBILE),
      ResponsiveBreakpoint.autoScale(700, name: TABLET),
      ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
      ResponsiveBreakpoint.autoScale(2460, name: '4K'),
    ],
  );
  return child;
}

const localizationDelegates = [
  DefaultWidgetsLocalizations.delegate,
  DefaultMaterialLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  FormBuilderLocalizations.delegate,
];

var scrollBehavior = const MaterialScrollBehavior().copyWith(
  dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
);
