import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_service_base.dart';
import 'theme_service_prefs.dart';

/// The ThemeController is used by many Widgets that users can interact with.
/// Widgets can read user theme settings, set user theme settings and listen
/// to user's theme changes.
///
/// The controller glues data Services to Flutter Widgets. The ThemeController
/// uses the ThemeService to save and load theme settings.
///
// ignore:prefer_mixin
class ThemeService extends GetxController implements GetxService {
  static ThemeService get to {
    if(!Get.isRegistered<ThemeService>()){
      Get.put(ThemeService(),permanent: true);
    }
    return Get.find();
  }

  @override
  void onInit() {
    initAll();
    super.onInit();
  }

  initAll() async {
    await themeService.init();
    await loadAll();
  }

  // Make the ThemeService private so it cannot be used directly.
  // final ThemeServiceBase themeService;

  final Rx<ThemeServiceBase> _themeService = ThemeServicePrefs().obs;

  ThemeServiceBase get themeService => _themeService.value;

  set themeService(ThemeServiceBase val) => _themeService.value = val;

  /// Load all ThemeController settings from the ThemeService. It may load from
  /// app defaults, a local database or the internet. The controller only knows
  /// it can load all the settings from the service.
  Future<void> loadAll() async {
    _themeMode = await themeService.themeMode();
    _useSubThemes = await themeService.useSubThemes();
    _useTextTheme = await themeService.useTextTheme();
    usedScheme = await themeService.usedScheme();
    schemeIndex = await themeService.schemeIndex();
    _interactionEffects = await themeService.interactionEffects();
    _useDefaultRadius = await themeService.useDefaultRadius();
    _cornerRadius = await themeService.cornerRadius();
    _inputDecoratorIsFilled = await themeService.inputDecoratorIsFilled();
    _inputDecoratorBorderType = await themeService.inputDecoratorBorderType();
    _inputDecoratorUnfocusedHasBorder = await themeService.inputDecoratorUnfocusedHasBorder();
    _surfaceMode = await themeService.surfaceMode();
    _blendLevel = await themeService.blendLevel();
    _lightAppBarStyle = await themeService.lightAppBarStyle();
    _darkAppBarStyle = await themeService.darkAppBarStyle();
    _appBarOpacity = await themeService.appBarOpacity();
    _appBarElevation = await themeService.appBarElevation();
    _navBarStyle = await themeService.navBarStyle();
    _useNavDivider = await themeService.useNavDivider();
    _transparentStatusBar = await themeService.transparentStatusBar();
    _tabBarStyle = await themeService.tabBarStyle();
    _bottomNavigationBarOpacity = await themeService.bottomNavigationBarOpacity();
    _bottomNavigationBarElevation = await themeService.bottomNavigationBarElevation();
    _tooltipsMatchBackground = await themeService.tooltipsMatchBackground();
    _swapLightColors = await themeService.swapLightColors();
    _swapDarkColors = await themeService.swapDarkColors();
    _lightIsWhite = await themeService.lightIsWhite();
    _darkIsTrueBlack = await themeService.darkIsTrueBlack();
    _useToDarkMethod = await themeService.useToDarkMethod();
    _darkMethodLevel = await themeService.darkMethodLevel();
    _useFlexColorScheme = await themeService.useFlexColorScheme();
    _blendLightOnColors = await themeService.blendLightOnColors();
    _blendDarkOnColors = await themeService.blendDarkOnColors();
    _blendLightTextTheme = await themeService.blendLightTextTheme();
    _blendDarkTextTheme = await themeService.blendDarkTextTheme();
    _fabUseShape = await themeService.fabUseShape();
    // Custom colors
    _primaryLight = await themeService.primaryLight();
    _primaryVariantLight = await themeService.primaryVariantLight();
    _secondaryLight = await themeService.secondaryLight();
    _secondaryVariantLight = await themeService.secondaryVariantLight();
    _primaryDark = await themeService.primaryDark();
    _primaryVariantDark = await themeService.primaryVariantDark();
    _secondaryDark = await themeService.secondaryDark();
    _secondaryVariantDark = await themeService.secondaryVariantDark();
    // Not using the ThemeService just a local toggle for platform, resets
    // to actual default platform when settings are loaded.
    _platform = defaultTargetPlatform;
    update();
  }

  /// Reset all values to default values and save as current settings.
  ///
  /// Calls setters with notify = false, and calls notifyListeners once
  /// after all values have been reset and persisted.
  Future<void> resetAllToDefaults() async {
    await setThemeMode(ThemeServiceBase.defaultThemeMode, false);
    await setUseSubThemes(ThemeServiceBase.defaultUseSubThemes, false);
    await setUseTextTheme(ThemeServiceBase.defaultUseTextTheme, false);
    await setUsedScheme(ThemeServiceBase.defaultUsedScheme, false);
    await setSchemeIndex(ThemeServiceBase.defaultSchemeIndex, false);
    await setInteractionEffects(ThemeServiceBase.defaultInteractionEffects, false);
    await setUseDefaultRadius(ThemeServiceBase.defaultUseDefaultRadius, false);
    await setCornerRadius(ThemeServiceBase.defaultCornerRadius, false);
    await setInputDecoratorIsFilled(ThemeServiceBase.defaultInputDecoratorIsFilled, false);
    await setInputDecoratorBorderType(ThemeServiceBase.defaultInputDecoratorBorderType, false);
    await setInputDecoratorUnfocusedHasBorder(ThemeServiceBase.defaultInputDecoratorUnfocusedHasBorder, false);
    await setSurfaceMode(ThemeServiceBase.defaultSurfaceMode, false);
    await setBlendLevel(ThemeServiceBase.defaultBlendLevel, false);
    await setLightAppBarStyle(ThemeServiceBase.defaultLightAppBarStyle, false);
    await setDarkAppBarStyle(ThemeServiceBase.defaultDarkAppBarStyle, false);
    await setAppBarOpacity(ThemeServiceBase.defaultAppBarOpacity, false);
    await setAppBarElevation(ThemeServiceBase.defaultAppBarElevation, false);
    await setTransparentStatusBar(ThemeServiceBase.defaultTransparentStatusBar, false);
    await setTabBarStyle(ThemeServiceBase.defaultTabBarStyle, false);
    await setBottomNavigationBarOpacity(ThemeServiceBase.defaultBottomNavigationBarOpacity, false);
    await setBottomNavigationBarElevation(ThemeServiceBase.defaultBottomNavigationBarElevation, false);
    await setNavBarStyle(ThemeServiceBase.defaultNavBarStyle, false);
    await setUseNavDivider(ThemeServiceBase.defaultUseNavDivider, false);
    await setTooltipsMatchBackground(ThemeServiceBase.defaultTooltipsMatchBackground, false);
    await setSwapLightColors(ThemeServiceBase.defaultSwapLightColors, false);
    await setSwapDarkColors(ThemeServiceBase.defaultSwapDarkColors, false);
    await setLightIsWhite(ThemeServiceBase.defaultLightIsWhite, false);
    await setDarkIsTrueBlack(ThemeServiceBase.defaultDarkIsTrueBlack, false);
    await setUseToDarkMethod(ThemeServiceBase.defaultUseToDarkMethod, false);
    await setDarkMethodLevel(ThemeServiceBase.defaultDarkMethodLevel, false);
    await setUseFlexColorScheme(ThemeServiceBase.defaultUseFlexColorScheme, false);
    await setBlendLightOnColors(ThemeServiceBase.defaultBlendLightOnColors, false);
    await setBlendDarkOnColors(ThemeServiceBase.defaultBlendDarkOnColors, false);
    await setBlendLightTextTheme(ThemeServiceBase.defaultBlendLightTextTheme, false);
    await setBlendDarkTextTheme(ThemeServiceBase.defaultBlendDarkTextTheme, false);
    await setFabUseShape(ThemeServiceBase.defaultFabUseShape, false);
    // Custom colors
    await setPrimaryLight(ThemeServiceBase.defaultPrimaryLight, false);
    await setPrimaryVariantLight(ThemeServiceBase.defaultPrimaryVariantLight, false);
    await setSecondaryLight(ThemeServiceBase.defaultSecondaryLight, false);
    await setSecondaryVariantLight(ThemeServiceBase.defaultSecondaryVariantLight, false);
    await setPrimaryDark(ThemeServiceBase.defaultPrimaryDark, false);
    await setPrimaryVariantDark(ThemeServiceBase.defaultPrimaryVariantDark, false);
    await setSecondaryDark(ThemeServiceBase.defaultSecondaryDark, false);
    await setSecondaryVariantDark(ThemeServiceBase.defaultSecondaryVariantDark, false);
    // Not using ThemeService, just a locally controlled switched.
    await setPlatform(defaultTargetPlatform, false);
    update();
  }

  // Make all ThemeController properties private so they cannot be used
  // directly without also persisting the changes using the ThemeService,
  // by making a setter and getter for each property.

  // Private value, getter and setter for the ThemeMode
  ThemeMode _themeMode = ThemeMode.system;

  /// Getter for the current ThemeMode.
  ThemeMode get themeMode => _themeMode;

  /// Set and persist new ThemeMode value.
  Future<void> setThemeMode(ThemeMode? value, [bool notify = true]) async {
    // No work if null value passed.
    if (value == null) return;
    // Do not perform any work if new and old value are identical.
    if (value == _themeMode) return;
    // Otherwise, assign new value to private property.
    _themeMode = value;
    // Inform all listeners a change has occurred, if notify flag true.
    // Persist the change to whatever storage is used with the ThemeService.
    await themeService.saveThemeMode(value);
    update();
  }

  /// Set and persist new ThemeMode value.
  Future<void> toggleThemeMode() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await themeService.saveThemeMode(_themeMode);
    update();
  }

  // Repeat above pattern for all other theme settings. The properties will
  // not be further explained, property names correspond to equivalent
  // FlexColorScheme properties.
  late bool _useSubThemes;

  bool get useSubThemes => _useSubThemes;

  Future<void> setUseSubThemes(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useSubThemes) return;
    _useSubThemes = value;
    await themeService.saveUseSubThemes(value);
    update();
  }

  late bool _useTextTheme;

  bool get useTextTheme => _useTextTheme;

  Future<void> setUseTextTheme(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useTextTheme) return;
    _useTextTheme = value;
    await themeService.saveUseTextTheme(value);
    update();
  }

  late final Rxn<FlexScheme> _usedScheme = Rxn<FlexScheme>();

  FlexScheme? get usedScheme => _usedScheme.value;

  set usedScheme(FlexScheme? usedScheme) => setUsedScheme(usedScheme);

  Future<void> setUsedScheme(FlexScheme? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == usedScheme) return;
    _usedScheme.value = value;
    await themeService.saveUsedScheme(value);
    update();
  }

  late final Rxn<int> _schemeIndex = Rxn<int>();

  int? get schemeIndex => _schemeIndex.value;

  set schemeIndex(int? x) => setSchemeIndex(x);

  Future<void> setSchemeIndex(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _schemeIndex.value) return;
    _schemeIndex.value = value;
    await themeService.saveSchemeIndex(value);

    setUsedScheme(FlexScheme.values[value % FlexScheme.values.length]);

    update();
  }

  late FlexSurfaceMode _surfaceMode;

  FlexSurfaceMode get surfaceMode => _surfaceMode;

  Future<void> setSurfaceMode(FlexSurfaceMode? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _surfaceMode) return;
    _surfaceMode = value;
    await themeService.saveSurfaceMode(value);
    update();
  }

  late int _blendLevel;

  int get blendLevel => _blendLevel;

  Future<void> setBlendLevel(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendLevel) return;
    _blendLevel = value;
    await themeService.saveBlendLevel(value);
    update();
  }

  late bool _interactionEffects;

  bool get interactionEffects => _interactionEffects;

  Future<void> setInteractionEffects(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _interactionEffects) return;
    _interactionEffects = value;
    await themeService.saveInteractionEffects(value);
    update();
  }

  late bool _useDefaultRadius;

  bool get useDefaultRadius => _useDefaultRadius;

  Future<void> setUseDefaultRadius(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useDefaultRadius) return;
    _useDefaultRadius = value;
    await themeService.saveUseDefaultRadius(value);
    update();
  }

  late double _cornerRadius;

  double get cornerRadius => _cornerRadius;

  Future<void> setCornerRadius(double? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _cornerRadius) return;
    _cornerRadius = value;
    await themeService.saveCornerRadius(value);
    update();
  }

  late bool _inputDecoratorIsFilled;

  bool get inputDecoratorIsFilled => _inputDecoratorIsFilled;

  Future<void> setInputDecoratorIsFilled(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _inputDecoratorIsFilled) return;
    _inputDecoratorIsFilled = value;
    await themeService.saveInputDecoratorIsFilled(value);
    update();
  }

  late FlexInputBorderType _inputDecoratorBorderType;

  FlexInputBorderType get inputDecoratorBorderType => _inputDecoratorBorderType;

  Future<void> setInputDecoratorBorderType(FlexInputBorderType? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _inputDecoratorBorderType) return;
    _inputDecoratorBorderType = value;
    await themeService.saveInputDecoratorBorderType(value);
    update();
  }

  late bool _inputDecoratorUnfocusedHasBorder;

  bool get inputDecoratorUnfocusedHasBorder => _inputDecoratorUnfocusedHasBorder;

  Future<void> setInputDecoratorUnfocusedHasBorder(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _inputDecoratorUnfocusedHasBorder) return;
    _inputDecoratorUnfocusedHasBorder = value;
    await themeService.saveInputDecoratorUnfocusedHasBorder(value);
    update();
  }

  late FlexAppBarStyle _lightAppBarStyle;

  FlexAppBarStyle get lightAppBarStyle => _lightAppBarStyle;

  Future<void> setLightAppBarStyle(FlexAppBarStyle? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _lightAppBarStyle) return;
    _lightAppBarStyle = value;
    await themeService.saveLightAppBarStyle(value);
    update();
  }

  late FlexAppBarStyle _darkAppBarStyle;

  FlexAppBarStyle get darkAppBarStyle => _darkAppBarStyle;

  Future<void> setDarkAppBarStyle(FlexAppBarStyle? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _darkAppBarStyle) return;
    _darkAppBarStyle = value;
    await themeService.saveDarkAppBarStyle(value);
    update();
  }

  late double _appBarOpacity;

  double get appBarOpacity => _appBarOpacity;

  Future<void> setAppBarOpacity(double? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _appBarOpacity) return;
    _appBarOpacity = value;
    await themeService.saveAppBarOpacity(value);
    update();
  }

  late double _appBarElevation;

  double get appBarElevation => _appBarElevation;

  Future<void> setAppBarElevation(double? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _appBarElevation) return;
    _appBarElevation = value;
    await themeService.saveAppBarElevation(value);
    update();
  }

  late bool _transparentStatusBar;

  bool get transparentStatusBar => _transparentStatusBar;

  Future<void> setTransparentStatusBar(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _transparentStatusBar) return;
    _transparentStatusBar = value;
    await themeService.saveTransparentStatusBar(value);
    update();
  }

  late FlexTabBarStyle _tabBarStyle;

  FlexTabBarStyle get tabBarStyle => _tabBarStyle;

  Future<void> setTabBarStyle(FlexTabBarStyle? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _tabBarStyle) return;
    _tabBarStyle = value;
    await themeService.saveTabBarStyle(value);
    update();
  }

  late double _bottomNavigationBarOpacity;

  double get bottomNavigationBarOpacity => _bottomNavigationBarOpacity;

  Future<void> setBottomNavigationBarOpacity(double? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _bottomNavigationBarOpacity) return;
    _bottomNavigationBarOpacity = value;
    await themeService.saveBottomNavigationBarOpacity(value);
    update();
  }

  late double _bottomNavigationBarElevation;

  double get bottomNavigationBarElevation => _bottomNavigationBarElevation;

  Future<void> setBottomNavigationBarElevation(double? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _bottomNavigationBarElevation) return;
    _bottomNavigationBarElevation = value;
    await themeService.saveBottomNavigationBarElevation(value);
    update();
  }

  late FlexSystemNavBarStyle _navBarStyle;

  FlexSystemNavBarStyle get navBarStyle => _navBarStyle;

  Future<void> setNavBarStyle(FlexSystemNavBarStyle? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _navBarStyle) return;
    _navBarStyle = value;
    await themeService.saveNavBarStyle(value);
    update();
  }

  late bool _useNavDivider;

  bool get useNavDivider => _useNavDivider;

  Future<void> setUseNavDivider(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useNavDivider) return;
    _useNavDivider = value;
    await themeService.saveUseNavDivider(value);
    update();
  }

  late bool _tooltipsMatchBackground;

  bool get tooltipsMatchBackground => _tooltipsMatchBackground;

  Future<void> setTooltipsMatchBackground(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _tooltipsMatchBackground) return;
    _tooltipsMatchBackground = value;
    await themeService.saveTooltipsMatchBackground(value);
    update();
  }

  late bool _swapLightColors;

  bool get swapLightColors => _swapLightColors;

  Future<void> setSwapLightColors(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _swapLightColors) return;
    _swapLightColors = value;
    await themeService.saveSwapLightColors(value);
    update();
  }

  late bool _swapDarkColors;

  bool get swapDarkColors => _swapDarkColors;

  Future<void> setSwapDarkColors(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _swapDarkColors) return;
    _swapDarkColors = value;
    await themeService.saveSwapDarkColors(value);
    update();
  }

  late bool _lightIsWhite;

  bool get lightIsWhite => _lightIsWhite;

  Future<void> setLightIsWhite(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _lightIsWhite) return;
    _lightIsWhite = value;
    await themeService.saveLightIsWhite(value);
    update();
  }

  late bool _darkIsTrueBlack;

  bool get darkIsTrueBlack => _darkIsTrueBlack;

  Future<void> setDarkIsTrueBlack(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _darkIsTrueBlack) return;
    _darkIsTrueBlack = value;
    await themeService.saveDarkIsTrueBlack(value);
    update();
  }

  late bool _useToDarkMethod;

  bool get useToDarkMethod => _useToDarkMethod;

  Future<void> setUseToDarkMethod(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useToDarkMethod) return;
    _useToDarkMethod = value;
    await themeService.saveUseToDarkMethod(value);
    update();
  }

  late int _darkMethodLevel;

  int get darkMethodLevel => _darkMethodLevel;

  Future<void> setDarkMethodLevel(int? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _darkMethodLevel) return;
    _darkMethodLevel = value;
    await themeService.saveDarkMethodLevel(value);
    update();
  }

  // This is not a FlexColorScheme property, it is a feature used to turn
  // ON/OFF the usage of FlexColorScheme
  late bool _useFlexColorScheme;

  bool get useFlexColorScheme => _useFlexColorScheme;

  Future<void> setUseFlexColorScheme(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _useFlexColorScheme) return;
    _useFlexColorScheme = value;
    await themeService.saveUseFlexColorScheme(value);
    update();
  }

  // On color blending ON/OFF
  late bool _blendLightOnColors;

  bool get blendLightOnColors => _blendLightOnColors;

  Future<void> setBlendLightOnColors(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendLightOnColors) return;
    _blendLightOnColors = value;
    await themeService.saveBlendLightOnColors(value);
    update();
  }

  late bool _blendDarkOnColors;

  bool get blendDarkOnColors => _blendDarkOnColors;

  Future<void> setBlendDarkOnColors(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendDarkOnColors) return;
    _blendDarkOnColors = value;
    await themeService.saveBlendDarkOnColors(value);
    update();
  }

  // TextThem blending ON/OFF
  late bool _blendLightTextTheme;

  bool get blendLightTextTheme => _blendLightTextTheme;

  Future<void> setBlendLightTextTheme(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendLightTextTheme) return;
    _blendLightTextTheme = value;
    await themeService.saveBlendLightTextTheme(value);
    update();
  }

  late bool _blendDarkTextTheme;

  bool get blendDarkTextTheme => _blendDarkTextTheme;

  Future<void> setBlendDarkTextTheme(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _blendDarkTextTheme) return;
    _blendDarkTextTheme = value;
    await themeService.saveBlendDarkTextTheme(value);
    update();
  }

  late bool _fabUseShape;

  bool get fabUseShape => _fabUseShape;

  Future<void> setFabUseShape(bool? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _fabUseShape) return;
    _fabUseShape = value;
    await themeService.saveFabUseShape(value);
    update();
  }

  late Color _primaryLight;

  Color get primaryLight => _primaryLight;

  Future<void> setPrimaryLight(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _primaryLight) return;
    _primaryLight = value;
    await themeService.savePrimaryLight(value);
    update();
  }

  late Color _primaryVariantLight;

  Color get primaryVariantLight => _primaryVariantLight;

  Future<void> setPrimaryVariantLight(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _primaryVariantLight) return;
    _primaryVariantLight = value;
    await themeService.savePrimaryVariantLight(value);
    update();
  }

  late Color _secondaryLight;

  Color get secondaryLight => _secondaryLight;

  Future<void> setSecondaryLight(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _secondaryLight) return;
    _secondaryLight = value;
    await themeService.saveSecondaryLight(value);
    update();
  }

  late Color _secondaryVariantLight;

  Color get secondaryContainerLight => _secondaryVariantLight;

  Future<void> setSecondaryVariantLight(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _secondaryVariantLight) return;
    _secondaryVariantLight = value;
    await themeService.saveSecondaryVariantLight(value);
    update();
  }

  late Color _primaryDark;

  Color get primaryDark => _primaryDark;

  Future<void> setPrimaryDark(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _primaryDark) return;
    _primaryDark = value;
    await themeService.savePrimaryDark(value);
    update();
  }

  late Color _primaryVariantDark;

  Color get primaryContainerDark => _primaryVariantDark;

  Future<void> setPrimaryVariantDark(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _primaryVariantDark) return;
    _primaryVariantDark = value;
    await themeService.savePrimaryVariantDark(value);
    update();
  }

  late Color _secondaryDark;

  Color get secondaryDark => _secondaryDark;

  Future<void> setSecondaryDark(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _secondaryDark) return;
    _secondaryDark = value;
    await themeService.saveSecondaryDark(value);
    update();
  }

  late Color _secondaryVariantDark;

  Color get secondaryContainerDark => _secondaryVariantDark;

  Future<void> setSecondaryVariantDark(Color? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _secondaryVariantDark) return;
    _secondaryVariantDark = value;
    await themeService.saveSecondaryVariantDark(value);
    update();
  }

  // Get custom scheme data based on currently defined scheme colors.
  FlexSchemeData get customScheme => FlexSchemeData(
        name: FlexColor.customName,
        description: FlexColor.customDescription,
        light: FlexSchemeColor(
          primary: primaryLight,
          primaryContainer: primaryVariantLight,
          secondary: secondaryLight,
          secondaryContainer: secondaryContainerLight,
          appBarColor: secondaryContainerLight,
          error: FlexColor.materialLightError,
        ),
        dark: FlexSchemeColor(
          primary: primaryDark,
          primaryContainer: primaryContainerDark,
          secondary: secondaryDark,
          secondaryContainer: secondaryContainerDark,
          appBarColor: secondaryContainerDark,
          error: FlexColor.materialDarkError,
        ),
      );

  FlexSchemeColor? get currentColors {
    return themeMode == ThemeMode.light ? FlexColor.schemes[usedScheme]?.light : FlexColor.schemes[usedScheme]?.dark;
  }

  // Set the custom scheme colors to the colors scheme FlexSchemeData.
  Future<void> setCustomScheme(FlexSchemeData scheme) async {
    // Don't notify listeners while setting new values for each value.
    await setPrimaryLight(scheme.light.primary, false);
    await setPrimaryVariantLight(scheme.light.primaryContainer, false);
    await setSecondaryLight(scheme.light.secondary, false);
    await setSecondaryVariantLight(scheme.light.secondaryContainer, false);
    await setPrimaryDark(scheme.dark.primary, false);
    await setPrimaryVariantDark(scheme.dark.primaryContainer, false);
    await setSecondaryDark(scheme.dark.secondary, false);
    await setSecondaryVariantDark(scheme.dark.secondaryContainer, false);
    update();
  }

  /// This is just a local controller properties for the Platform menu control.
  /// It is used as input to the theme, but never persisted so it always
  /// defaults to the actual target platform when starting the app.
  /// Being able to toggle it during demos and development is a handy feature.
  late TargetPlatform _platform;

  TargetPlatform get platform => _platform;

  Future<void> setPlatform(TargetPlatform? value, [bool notify = true]) async {
    if (value == null) return;
    if (value == _platform) return;
    _platform = value;
    update();
  }

  // Recently used colors, we keep the list of recently used colors in the
  // color picker for custom colors only during the session we don't persist.
  // It is of course possible to persist, but not needed in ths demo.
  List<Color> _recentColors = <Color>[];

  List<Color> get recentColors => _recentColors;

  // ignore: use_setters_to_change_properties
  void setRecentColors(final List<Color> colors) {
    _recentColors = colors;
    update();
  }
}
