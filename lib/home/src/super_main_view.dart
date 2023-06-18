import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_framework.dart' as rsp;
import 'package:super_widgets/super_widgets.dart';

class SuperMainApp extends StatelessWidget {
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
  SuperMainApp._internal(
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

  static SuperMainApp? _instance;

  ///region factory
  factory SuperMainApp({
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
    useInheritedMediaQuery = false,
    highContrastTheme,
    highContrastDarkTheme,
    themeMode,
    locale,
    localizationsDelegates,
    localeListResolutionCallback,
    localeResolutionCallback,
    supportedLocales = const <Locale>[
      Locale('ar'),
      Locale('en'),
    ],
    debugShowMaterialGrid = false,
    showPerformanceOverlay = false,
    checkerboardRasterCacheImages = false,
    checkerboardOffscreenLayers = false,
    showSemanticsDebugger = false,
    debugShowCheckedModeBanner = true,
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
    enableLog = kDebugMode,
    logWriterCallback,
    popGesture,
    smartManagement = SmartManagement.full,
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
    if (GetPlatform.isMobile) {
      HttpOverrides.global = MyHttpOverrides();
    }
    GetStorage.init();
    Get.put<ThemeService>(ThemeService(), permanent: true);
    Get.put<LanguageService>(LanguageService(), permanent: true);

    if (themeMode != null) {
      ThemeService.to.setThemeMode(themeMode);
    } else {
      themeMode = ThemeService.to.themeMode;
    }
    // if (locale?.languageCode != null) {
    //   LanguageService.to.updateLocale(locale.languageCode);
    // }
    _instance ??= SuperMainApp._internal(
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
    return _instance!;
  }

  ///endregion factory

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageService>(builder: (languageController) {
      return GetBuilder<ThemeService>(builder: (themeController) {
        return AnimatedBuilder(
            animation: themeController,
            builder: (BuildContext context, Widget? child) {
              return GetMaterialApp(
                ///region Others
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
                // onGenerateRoute: onGenerateRoute,
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

                ///endregion others

                ///region Routing
                initialRoute: initialRoute,
                getPages: getPages,

                ///endregion Routing

                ///region Themes
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeController.themeMode,

                ///endregion Themes

                ///region Locales
                supportedLocales: supportedLocales,
                locale: languageController.getLocale,
                localizationsDelegates: [...localizationDelegatesList, ...(localizationsDelegates?.toList() ?? <LocalizationsDelegate>[])],

                ///endregion Locales

                ///region UI
                navigatorObservers: [FlutterSmartDialog.observer],
                builder: mainResponsiveBuilder,
                // onGenerateRoute: (RouteSettings settings) {
                //   // A custom `fadeThrough` route transition animation.
                //   return MaterialPageRoute(builder: (context) {
                //     // The following code implements the legacy ResponsiveWrapper AutoScale functionality
                //     // using the new ResponsiveScaledBox. The ResponsiveScaledBox widget preserves
                //     // the legacy ResponsiveWrapper behavior, scaling the UI instead of resizing.
                //     //
                //     // **MaxWidthBox** - A widget that limits the maximum width.
                //     // This is used to create a gutter area on either side of the content.
                //     //
                //     // **ResponsiveScaledBox** - A widget that  renders its child
                //     // with a FittedBox set to the `width` value. Set the fixed width value
                //     // based on the active breakpoint.
                //     return MaxWidthBox(
                //       maxWidth: 1200,
                //       background: Container(color: const Color(0xFFF5F5F5)),
                //       child: ResponsiveScaledBox(
                //         width: ResponsiveValue<double>(context, conditionalValues: [
                //           const rsp.Condition.equals(name: MOBILE, value: 450),
                //           const rsp.Condition.between(start: 800, end: 1100, value: 800),
                //           const rsp.Condition.between(start: 1000, end: 1200, value: 1000),
                //           // There are no conditions for width over 1200
                //           // because the `maxWidth` is set to 1200 via the MaxWidthBox.
                //         ]).value,
                //         child: BouncingScrollWrapper.builder(context, PageRedirect(settings: settings).page(), dragWithMouse: true),
                //       ),
                //     );
                //   });
                // },
                scrollBehavior: scrollBehavior,
                defaultTransition: Transition.fade,
                transitionDuration: const Duration(milliseconds: 50),

                ///endregion UI
              );
            });
      });
    });
  }
}

Widget mainResponsiveBuilder(BuildContext context, Widget? child) {
  final smartDialog = FlutterSmartDialog.init();
  child = smartDialog(context, child);
  child = ResponsiveWrapper.builder(
    ClampingScrollWrapper(child: child),
    minWidth: 450,
    maxWidth: 1980,
    mediaQueryData: MediaQuery.of(context).copyWith(textScaleFactor: 1),
    defaultScale: true,
    breakpoints: const [
      ResponsiveBreakpoint.resize(450, name: MOBILE),
      ResponsiveBreakpoint.resize(700, name: TABLET),
      ResponsiveBreakpoint.resize(1000, name: DESKTOP),
    ],
  );
  return child;
}

// Widget mainResponsiveBuilder2(BuildContext context, Widget? child) {
//   final smartDialog = FlutterSmartDialog.init();
//   child = smartDialog(context, child);
//   child = ResponsiveBreakpoints.builder(
//     child: ClampingScrollWrapper(child: child),
//     breakpoints: const [
//       Breakpoint(start: 0, end: 450, name: MOBILE),
//       Breakpoint(start: 451, end: 800, name: TABLET),
//       Breakpoint(start: 801, end: 1920, name: DESKTOP),
//       Breakpoint(start: 1921, end: double.infinity, name: '4K'),
//     ],
//   );
//   return child;
// }

const localizationDelegatesList = [
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
