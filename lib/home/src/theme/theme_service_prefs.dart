import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:super_widgets/super_widgets.dart';

import 'theme_service_base.dart';
// ignore_for_file: comment_references

class ThemeServicePrefs implements ThemeServiceBase {
  // Hold an instance to the SharedPreferences store, must be initialized
  // by the init call before accessing the stored data.
  final GetStorage _storage = GetStorage();

  @override
  Future<void> init() async {
    // Get the SharedPreferences instance and assign it to our instance.
  }

  /// Loads the ThemeMode from local storage.
  @override
  Future<ThemeMode> themeMode() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keyThemeMode) ?? ThemeServiceBase.defaultThemeMode.index;

      mPrint('Read ThemeMode $value');
      return ThemeMode.values[value];
    } catch (e) {
      debugPrint(e.toString());
      // If something goes wrong we return the default value.
      return ThemeServiceBase.defaultThemeMode;
    }
  }

  /// Persists the ThemeMode used in examples 2, 3, 4 and 5.
  @override
  Future<void> saveThemeMode(ThemeMode value) async {
    // We store enums as their int index value. This breaks if enum definitions
    // are changed in any other way than adding more enums to the end.
    try {
      await _storage.write(ThemeServiceBase.keyThemeMode, value.index);
      // mPrint('Saved ThemeMode ${value.index}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads the use sub themes setting used in examples 2, 3, 4 and 5.
  @override
  Future<bool> useSubThemes() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyUseSubThemes) ?? ThemeServiceBase.defaultUseSubThemes;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultUseSubThemes;
    }
  }

  /// Persists the use sub themes setting used in examples 2, 3, 4 and 5.
  @override
  Future<void> saveUseSubThemes(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyUseSubThemes, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads the useTextTheme setting in example 5.
  @override
  Future<bool> useTextTheme() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyUseTextTheme) ?? ThemeServiceBase.defaultUseTextTheme;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultUseTextTheme;
    }
  }

  /// Persists the useTextTheme setting in example 5.
  @override
  Future<void> saveUseTextTheme(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyUseTextTheme, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads the used scheme setting used in example 3.
  @override
  Future<FlexScheme> usedScheme() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keyUsedScheme) ?? ThemeServiceBase.defaultUsedScheme.index;
      return FlexScheme.values[value];
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultUsedScheme;
    }
  }

  /// Persists the used scheme setting used in example 3.
  @override
  Future<void> saveUsedScheme(FlexScheme value) async {
    try {
      await _storage.write(ThemeServiceBase.keyUsedScheme, value.index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used scheme index setting used in examples 4 and 5.
  @override
  Future<int> schemeIndex() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keySchemeIndex) ?? ThemeServiceBase.defaultSchemeIndex;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultSchemeIndex;
    }
  }

  /// Persists the used scheme setting used in examples 4 and 5.
  @override
  Future<void> saveSchemeIndex(int value) async {
    try {
      await _storage.write(ThemeServiceBase.keySchemeIndex, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used themed effects setting in example 5.
  @override
  Future<bool> interactionEffects() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyInteractionEffects) ?? ThemeServiceBase.defaultInteractionEffects;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultInteractionEffects;
    }
  }

  /// Persists used themed effects setting in example 5.
  @override
  Future<void> saveInteractionEffects(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyInteractionEffects, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used useDefaultRadius setting in example 5.
  @override
  Future<bool> useDefaultRadius() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyUseDefaultRadius) ?? ThemeServiceBase.defaultUseDefaultRadius;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultUseDefaultRadius;
    }
  }

  /// Persists the useDefaultRadius setting in example 5.
  @override
  Future<void> saveUseDefaultRadius(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyUseDefaultRadius, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used corner radius setting in example 5.
  @override
  Future<double> cornerRadius() async {
    try {
      final double value = _storage.read(ThemeServiceBase.keyCornerRadius) ?? ThemeServiceBase.defaultCornerRadius;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultCornerRadius;
    }
  }

  /// Persists the used corner radius setting in example 5.
  @override
  Future<void> saveCornerRadius(double value) async {
    try {
      await _storage.write(ThemeServiceBase.keyCornerRadius, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used inputDecoratorIsFilled setting in example 5.
  @override
  Future<bool> inputDecoratorIsFilled() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyInputDecoratorIsFilled) ?? ThemeServiceBase.defaultInputDecoratorIsFilled;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultInputDecoratorIsFilled;
    }
  }

  /// Persists used inputDecoratorIsFilled setting in example 5.
  @override
  Future<void> saveInputDecoratorIsFilled(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyInputDecoratorIsFilled, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used inputDecoratorBorderType setting in example 5.
  @override
  Future<FlexInputBorderType> inputDecoratorBorderType() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keyInputDecoratorBorderType) ?? ThemeServiceBase.defaultInputDecoratorBorderType.index;
      return FlexInputBorderType.values[value];
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultInputDecoratorBorderType;
    }
  }

  /// Persists used inputDecoratorBorderType setting in example 5.
  @override
  Future<void> saveInputDecoratorBorderType(FlexInputBorderType value) async {
    try {
      await _storage.write(ThemeServiceBase.keyInputDecoratorBorderType, value.index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used inputDecoratorUnfocusedHasBorder setting in example 5.
  @override
  Future<bool> inputDecoratorUnfocusedHasBorder() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyInputDecoratorUnfocusedHasBorder) ?? ThemeServiceBase.defaultInputDecoratorUnfocusedHasBorder;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultInputDecoratorUnfocusedHasBorder;
    }
  }

  /// Persists used inputDecoratorUnfocusedHasBorder setting in example 5.
  @override
  Future<void> saveInputDecoratorUnfocusedHasBorder(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyInputDecoratorUnfocusedHasBorder, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used surface mode setting in example 5.
  @override
  Future<FlexSurfaceMode> surfaceMode() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keySurfaceMode) ?? ThemeServiceBase.defaultSurfaceMode.index;
      return FlexSurfaceMode.values[value];
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultSurfaceMode;
    }
  }

  /// Persists the used surface mode setting in example 5.
  @override
  Future<void> saveSurfaceMode(FlexSurfaceMode value) async {
    try {
      await _storage.write(ThemeServiceBase.keySurfaceMode, value.index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used surface blend level setting in example 5.

  @override
  Future<int> blendLevel() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keyBlendLevel) ?? ThemeServiceBase.defaultBlendLevel;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultBlendLevel;
    }
  }

  /// Persists the used surface blend level setting in example 5.
  @override
  Future<void> saveBlendLevel(int value) async {
    try {
      await _storage.write(ThemeServiceBase.keyBlendLevel, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used app bar style for light theme setting in example 5.
  @override
  Future<FlexAppBarStyle> lightAppBarStyle() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keyLightAppBarStyle) ?? ThemeServiceBase.defaultLightAppBarStyle.index;
      return FlexAppBarStyle.values[value];
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultLightAppBarStyle;
    }
  }

  /// Persists the used app bar style for light theme setting in example 5.
  @override
  Future<void> saveLightAppBarStyle(FlexAppBarStyle value) async {
    try {
      await _storage.write(ThemeServiceBase.keyLightAppBarStyle, value.index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used app bar style for dark theme setting in example 5.
  @override
  Future<FlexAppBarStyle> darkAppBarStyle() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keyDarkAppBarStyle) ?? ThemeServiceBase.defaultDarkAppBarStyle.index;
      return FlexAppBarStyle.values[value];
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultDarkAppBarStyle;
    }
  }

  /// Persists the used app bar style for dark theme setting in example 5.
  @override
  Future<void> saveDarkAppBarStyle(FlexAppBarStyle value) async {
    try {
      await _storage.write(ThemeServiceBase.keyDarkAppBarStyle, value.index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used app bar opacity setting in example 5.
  @override
  Future<double> appBarOpacity() async {
    try {
      final double value = _storage.read(ThemeServiceBase.keyAppBarOpacity) ?? ThemeServiceBase.defaultAppBarOpacity;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultAppBarOpacity;
    }
  }

  /// Persists the used app bar opacity setting in example 5.
  @override
  Future<void> saveAppBarOpacity(double value) async {
    try {
      await _storage.write(ThemeServiceBase.keyAppBarOpacity, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used app bar elevation setting in example 5.
  @override
  Future<double> appBarElevation() async {
    try {
      final double value = _storage.read(ThemeServiceBase.keyAppBarElevation) ?? ThemeServiceBase.defaultAppBarElevation;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultAppBarElevation;
    }
  }

  /// Persists the used app bar elevation setting in example 5.
  @override
  Future<void> saveAppBarElevation(double value) async {
    try {
      await _storage.write(ThemeServiceBase.keyAppBarElevation, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used status bar transparency setting in example 5.
  @override
  Future<bool> transparentStatusBar() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyTransparentStatusBar) ?? ThemeServiceBase.defaultTransparentStatusBar;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultTransparentStatusBar;
    }
  }

  /// Persists used status bar transparency setting in example 5.
  @override
  Future<void> saveTransparentStatusBar(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyTransparentStatusBar, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used tab bar style setting in example 5.
  @override
  Future<FlexTabBarStyle> tabBarStyle() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keyTabBarStyle) ?? ThemeServiceBase.defaultTabBarStyle.index;
      return FlexTabBarStyle.values[value];
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultTabBarStyle;
    }
  }

  /// Persists used tab bar style setting in example 5.
  @override
  Future<void> saveTabBarStyle(FlexTabBarStyle value) async {
    try {
      await _storage.write(ThemeServiceBase.keyTabBarStyle, value.index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used bottom navigation bar opacity setting in example 5.
  @override
  Future<double> bottomNavigationBarOpacity() async {
    try {
      final double value = _storage.read(ThemeServiceBase.keyBottomNavigationBarOpacity) ?? ThemeServiceBase.defaultBottomNavigationBarOpacity;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultBottomNavigationBarOpacity;
    }
  }

  /// Persists the used app bar opacity setting in example 5.
  @override
  Future<void> saveBottomNavigationBarOpacity(double value) async {
    try {
      await _storage.write(ThemeServiceBase.keyBottomNavigationBarOpacity, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used bottom navigation bar elevation setting in example 5.
  @override
  Future<double> bottomNavigationBarElevation() async {
    try {
      final double value = _storage.read(ThemeServiceBase.keyBottomNavigationBarElevation) ?? ThemeServiceBase.defaultBottomNavigationBarElevation;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultBottomNavigationBarElevation;
    }
  }

  /// Persists the used app bar elevation setting in example 5.
  @override
  Future<void> saveBottomNavigationBarElevation(double value) async {
    try {
      await _storage.write(ThemeServiceBase.keyBottomNavigationBarElevation, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used navBarStyle setting in example 5.
  @override
  Future<FlexSystemNavBarStyle> navBarStyle() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keyNavBarStyle) ?? ThemeServiceBase.defaultNavBarStyle.index;
      return FlexSystemNavBarStyle.values[value];
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultNavBarStyle;
    }
  }

  /// Persists used navBarStyle setting in example 5.
  @override
  Future<void> saveNavBarStyle(FlexSystemNavBarStyle value) async {
    try {
      await _storage.write(ThemeServiceBase.keyNavBarStyle, value.index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used useNavDivider setting in example 5.
  @override
  Future<bool> useNavDivider() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyUseNavDivider) ?? ThemeServiceBase.defaultUseNavDivider;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultUseNavDivider;
    }
  }

  /// Persists useNavDivider setting in example 5.
  @override
  Future<void> saveUseNavDivider(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyUseNavDivider, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads used tooltip style setting in example 5.
  @override
  Future<bool> tooltipsMatchBackground() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyTooltipsMatchBackground) ?? ThemeServiceBase.defaultTooltipsMatchBackground;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultTooltipsMatchBackground;
    }
  }

  /// Persists used tooltip style setting in example 5.
  @override
  Future<void> saveTooltipsMatchBackground(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyTooltipsMatchBackground, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads swap primary/secondary colors in light mode, in example 5.
  @override
  Future<bool> swapLightColors() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keySwapLightColors) ?? ThemeServiceBase.defaultSwapLightColors;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultSwapLightColors;
    }
  }

  /// Persists swap primary/secondary colors in light mode, in example 5.
  @override
  Future<void> saveSwapLightColors(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keySwapLightColors, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads swap primary/secondary colors in dark mode, in example 5.
  @override
  Future<bool> swapDarkColors() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keySwapDarkColors) ?? ThemeServiceBase.defaultSwapDarkColors;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultSwapDarkColors;
    }
  }

  /// Persists swap primary/secondary colors in dark mode, in example 5.
  @override
  Future<void> saveSwapDarkColors(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keySwapDarkColors, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads lightIsWhite setting, in example 5.
  @override
  Future<bool> lightIsWhite() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyLightIsWhite) ?? ThemeServiceBase.defaultLightIsWhite;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultLightIsWhite;
    }
  }

  /// Persists lightIsWhite setting, in example 5.
  @override
  Future<void> saveLightIsWhite(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyLightIsWhite, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads dark uses true black setting in dark mode, in example 5.
  @override
  Future<bool> darkIsTrueBlack() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyDarkIsTrueBlack) ?? ThemeServiceBase.defaultDarkIsTrueBlack;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultDarkIsTrueBlack;
    }
  }

  /// Persists dark uses true black setting in dark mode, in example 5.
  @override
  Future<void> saveDarkIsTrueBlack(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyDarkIsTrueBlack, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads use computed dark mode setting, in example 5.
  @override
  Future<bool> useToDarkMethod() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyUseToDarkMethod) ?? ThemeServiceBase.defaultUseToDarkMethod;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultUseToDarkMethod;
    }
  }

  /// Persists use computed dark mode setting, in example 5.
  @override
  Future<void> saveUseToDarkMethod(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyUseToDarkMethod, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads use computed dark mode level setting, in example 5.
  @override
  Future<int> darkMethodLevel() async {
    try {
      final int value = _storage.read(ThemeServiceBase.keyDarkMethodLevel) ?? ThemeServiceBase.defaultDarkMethodLevel;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultDarkMethodLevel;
    }
  }

  /// Persists use computed dark mode level setting, in example 5.
  @override
  Future<void> saveDarkMethodLevel(int value) async {
    try {
      await _storage.write(ThemeServiceBase.keyDarkMethodLevel, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting that turns ON/OFF FlexColorScheme theme, in example 5.
  @override
  Future<bool> useFlexColorScheme() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyUseFlexColorScheme) ?? ThemeServiceBase.defaultUseFlexColorScheme;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultUseFlexColorScheme;
    }
  }

  /// Persists setting that turns ON/OFF FlexColorScheme theme, in example 5.
  @override
  Future<void> saveUseFlexColorScheme(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyUseFlexColorScheme, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting that blends light colors, in example 5.
  @override
  Future<bool> blendLightOnColors() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyBlendLightOnColors) ?? ThemeServiceBase.defaultBlendLightOnColors;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultBlendLightOnColors;
    }
  }

  /// Persists setting that blends light colors, in example 5.
  @override
  Future<void> saveBlendLightOnColors(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyBlendLightOnColors, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting that blends dark colors, in example 5.
  @override
  Future<bool> blendDarkOnColors() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyBlendDarkOnColors) ?? ThemeServiceBase.defaultBlendDarkOnColors;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultBlendDarkOnColors;
    }
  }

  /// Persists setting that blends dark colors, in example 5.
  @override
  Future<void> saveBlendDarkOnColors(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyBlendDarkOnColors, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting that blends light text theme, in example 5.
  @override
  Future<bool> blendLightTextTheme() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyBlendLightTextTheme) ?? ThemeServiceBase.defaultBlendLightTextTheme;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultBlendLightTextTheme;
    }
  }

  /// Persists setting that blends light text theme, in example 5.
  @override
  Future<void> saveBlendLightTextTheme(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyBlendLightTextTheme, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting that blends dark text theme, in example 5.
  @override
  Future<bool> blendDarkTextTheme() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyBlendDarkTextTheme) ?? ThemeServiceBase.defaultBlendDarkTextTheme;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultBlendDarkTextTheme;
    }
  }

  /// Persists setting that blends dark text theme, in example 5.
  @override
  Future<void> saveBlendDarkTextTheme(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyBlendDarkTextTheme, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting for fabUseShape, in example 5.
  @override
  Future<bool> fabUseShape() async {
    try {
      final bool value = _storage.read(ThemeServiceBase.keyFabUseShape) ?? ThemeServiceBase.defaultFabUseShape;
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultFabUseShape;
    }
  }

  /// Persists setting for fabUseShape, in example 5.
  @override
  Future<void> saveFabUseShape(bool value) async {
    try {
      await _storage.write(ThemeServiceBase.keyFabUseShape, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting for primaryLight color, in example 5.
  @override
  Future<Color> primaryLight() async {
    try {
      final Color value = Color(_storage.read(ThemeServiceBase.keyPrimaryLight) ?? ThemeServiceBase.defaultPrimaryLight.value);
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultPrimaryLight;
    }
  }

  /// Persists setting for primaryLight color, in example 5.
  @override
  Future<void> savePrimaryLight(Color value) async {
    try {
      await _storage.write(ThemeServiceBase.keyPrimaryLight, value.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting for primaryVariantLight color, in example 5.
  @override
  Future<Color> primaryVariantLight() async {
    try {
      final Color value = Color(_storage.read(ThemeServiceBase.keyPrimaryVariantLight) ?? ThemeServiceBase.defaultPrimaryVariantLight.value);
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultPrimaryVariantLight;
    }
  }

  /// Persists setting for primaryVariantLight color, in example 5.
  @override
  Future<void> savePrimaryVariantLight(Color value) async {
    try {
      await _storage.write(ThemeServiceBase.keyPrimaryVariantLight, value.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting for secondaryLight color, in example 5.
  @override
  Future<Color> secondaryLight() async {
    try {
      final Color value = Color(_storage.read(ThemeServiceBase.keySecondaryLight) ?? ThemeServiceBase.defaultSecondaryLight.value);
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultSecondaryLight;
    }
  }

  /// Persists setting for secondaryLight color, in example 5.
  @override
  Future<void> saveSecondaryLight(Color value) async {
    try {
      await _storage.write(ThemeServiceBase.keySecondaryLight, value.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting for secondaryVariantLight color, in example 5.
  @override
  Future<Color> secondaryVariantLight() async {
    try {
      final Color value = Color(_storage.read(ThemeServiceBase.keySecondaryVariantLight) ?? ThemeServiceBase.defaultSecondaryVariantLight.value);
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultSecondaryVariantLight;
    }
  }

  /// Persists setting for secondaryVariantLight color, in example 5.
  @override
  Future<void> saveSecondaryVariantLight(Color value) async {
    try {
      await _storage.write(ThemeServiceBase.keySecondaryVariantLight, value.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting for primaryDark color, in example 5.
  @override
  Future<Color> primaryDark() async {
    try {
      final Color value = Color(_storage.read(ThemeServiceBase.keyPrimaryDark) ?? ThemeServiceBase.defaultPrimaryDark.value);
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultPrimaryDark;
    }
  }

  /// Persists setting for primaryDark color, in example 5.
  @override
  Future<void> savePrimaryDark(Color value) async {
    try {
      await _storage.write(ThemeServiceBase.keyPrimaryDark, value.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting for primaryVariantDark color, in example 5.
  @override
  Future<Color> primaryVariantDark() async {
    try {
      final Color value = Color(_storage.read(ThemeServiceBase.keyPrimaryVariantDark) ?? ThemeServiceBase.defaultPrimaryVariantDark.value);
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultPrimaryVariantDark;
    }
  }

  /// Persists setting for primaryVariantDark color, in example 5.
  @override
  Future<void> savePrimaryVariantDark(Color value) async {
    try {
      await _storage.write(ThemeServiceBase.keyPrimaryVariantDark, value.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting for secondaryDark color, in example 5.
  @override
  Future<Color> secondaryDark() async {
    try {
      final Color value = Color(_storage.read(ThemeServiceBase.keySecondaryDark) ?? ThemeServiceBase.defaultSecondaryDark.value);
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultSecondaryDark;
    }
  }

  /// Persists setting for secondaryDark color, in example 5.
  @override
  Future<void> saveSecondaryDark(Color value) async {
    try {
      await _storage.write(ThemeServiceBase.keySecondaryDark, value.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Loads setting for secondaryVariantDark color, in example 5.
  @override
  Future<Color> secondaryVariantDark() async {
    try {
      final Color value = Color(_storage.read(ThemeServiceBase.keySecondaryVariantDark) ?? ThemeServiceBase.defaultSecondaryVariantDark.value);
      return value;
    } catch (e) {
      debugPrint(e.toString());
      return ThemeServiceBase.defaultSecondaryVariantDark;
    }
  }

  /// Persists setting for secondaryVariantDark color, in example 5.
  @override
  Future<void> saveSecondaryVariantDark(Color value) async {
    try {
      await _storage.write(ThemeServiceBase.keySecondaryVariantDark, value.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
