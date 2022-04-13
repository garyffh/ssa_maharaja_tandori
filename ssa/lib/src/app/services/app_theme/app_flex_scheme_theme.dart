import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:single_store_app/src/app/services/app_theme/models/flex_schemes/app_flex_scheme.dart';
import 'package:single_store_app/src/app/services/app_theme/models/flex_schemes/flex_scheme_1.dart';
import 'package:single_store_app/src/app/services/app_theme/models/flex_schemes/flex_scheme_2.dart';
import 'package:single_store_app/src/app/services/app_theme/models/flex_schemes/flex_scheme_3.dart';
import 'package:single_store_app/src/app/services/app_theme/models/flex_schemes/flex_scheme_purple.dart';

class AppSchemeTheme {
  AppSchemeTheme._();

  // static const int version = 311;
  // static const double maxBodyWidth = 1280;
  // static const int debounceInterval = 750;

  static FlexSchemeData flexSchemeFromTheme(String theme) {
    switch (theme.toLowerCase()) {
      case 'blue':
        return _getFlexScheme(AppFlexScheme.blue);

      case 'brown':
        return _getFlexScheme(AppFlexScheme.purpleBrown);

      case 'green':
        return _getFlexScheme(AppFlexScheme.green);

      case 'grey':
        return _getFlexScheme(AppFlexScheme.greyLaw);

      case 'pink':
        return _getFlexScheme(AppFlexScheme.sakura);

      case 'purple':
        return _getFlexScheme(AppFlexScheme.purple);

      case 'orange':
        return _getFlexScheme(AppFlexScheme.amber);

      case 'espresso':
        return _getFlexScheme(AppFlexScheme.espresso);

      case 'ebony':
        return _getFlexScheme(AppFlexScheme.ebonyClay);

      default:
        return _getFlexScheme(AppFlexScheme.blue);
    }
  }

  static FlexSchemeData _getFlexScheme(AppFlexScheme flexScheme) {
    switch (flexScheme) {
      case AppFlexScheme.materialHc:
        return const FlexSchemeData(
          name: FlexColor.materialHcName,
          description: FlexColor.materialHcDescription,
          light: FlexSchemeColor(
            primary: FlexColor.materialLightPrimaryHc,
            primaryVariant: FlexColor.materialLightPrimaryVariantHc,
            secondary: FlexColor.materialLightSecondaryHc,
            secondaryVariant: FlexColor.materialLightSecondaryVariantHc,
            appBarColor: FlexColor.materialLightSecondaryVariantHc,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.materialDarkPrimaryHc,
            primaryVariant: FlexColor.materialDarkPrimaryVariantHc,
            secondary: FlexColor.materialDarkSecondaryHc,
            secondaryVariant: FlexColor.materialDarkSecondaryVariantHc,
            appBarColor: FlexColor.materialDarkSecondaryVariantHc,
            error: FlexColor.materialDarkErrorHc,
          ),
        );

      case AppFlexScheme.blue:
        return const FlexSchemeData(
          name: FlexColor.blueName,
          description: FlexColor.blueDescription,
          light: FlexSchemeColor(
            primary: FlexColor.blueLightPrimary,
            primaryVariant: FlexColor.blueLightPrimaryVariant,
            secondary: FlexColor.blueLightSecondary,
            secondaryVariant: FlexColor.blueLightSecondaryVariant,
            appBarColor: FlexColor.blueLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.blueDarkPrimary,
            primaryVariant: FlexColor.blueDarkPrimaryVariant,
            secondary: FlexColor.blueDarkSecondary,
            secondaryVariant: FlexColor.blueDarkSecondaryVariant,
            appBarColor: FlexColor.blueDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.indigo:
        return const FlexSchemeData(
          name: FlexColor.indigoName,
          description: FlexColor.indigoDescription,
          light: FlexSchemeColor(
            primary: FlexColor.indigoLightPrimary,
            primaryVariant: FlexColor.indigoLightPrimaryVariant,
            secondary: FlexColor.indigoLightSecondary,
            secondaryVariant: FlexColor.indigoLightSecondaryVariant,
            appBarColor: FlexColor.indigoLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.indigoDarkPrimary,
            primaryVariant: FlexColor.indigoDarkPrimaryVariant,
            secondary: FlexColor.indigoDarkSecondary,
            secondaryVariant: FlexColor.indigoDarkSecondaryVariant,
            appBarColor: FlexColor.indigoDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );
      case AppFlexScheme.hippieBlue:
        return const FlexSchemeData(
          name: FlexColor.hippieBlueName,
          description: FlexColor.hippieBlueDescription,
          light: FlexSchemeColor(
            primary: FlexColor.hippieBlueLightPrimary,
            primaryVariant: FlexColor.hippieBlueLightPrimaryVariant,
            secondary: FlexColor.hippieBlueLightSecondary,
            secondaryVariant: FlexColor.hippieBlueLightSecondaryVariant,
            appBarColor: FlexColor.hippieBlueLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.hippieBlueDarkPrimary,
            primaryVariant: FlexColor.hippieBlueDarkPrimaryVariant,
            secondary: FlexColor.hippieBlueDarkSecondary,
            secondaryVariant: FlexColor.hippieBlueDarkSecondaryVariant,
            appBarColor: FlexColor.hippieBlueDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.aquaBlue:
        return const FlexSchemeData(
          name: FlexColor.aquaBlueName,
          description: FlexColor.aquaBlueDescription,
          light: FlexSchemeColor(
            primary: FlexColor.aquaBlueLightPrimary,
            primaryVariant: FlexColor.aquaBlueLightPrimaryVariant,
            secondary: FlexColor.aquaBlueLightSecondary,
            secondaryVariant: FlexColor.aquaBlueLightSecondaryVariant,
            appBarColor: FlexColor.aquaBlueLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.aquaBlueDarkPrimary,
            primaryVariant: FlexColor.aquaBlueDarkPrimaryVariant,
            secondary: FlexColor.aquaBlueDarkSecondary,
            secondaryVariant: FlexColor.aquaBlueDarkSecondaryVariant,
            appBarColor: FlexColor.aquaBlueDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.brandBlue:
        return const FlexSchemeData(
          name: FlexColor.brandBlueName,
          description: FlexColor.brandBlueDescription,
          light: FlexSchemeColor(
            primary: FlexColor.brandBlueLightPrimary,
            primaryVariant: FlexColor.brandBlueLightPrimaryVariant,
            secondary: FlexColor.brandBlueLightSecondary,
            secondaryVariant: FlexColor.brandBlueLightSecondaryVariant,
            appBarColor: FlexColor.brandBlueLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.brandBlueDarkPrimary,
            primaryVariant: FlexColor.brandBlueDarkPrimaryVariant,
            secondary: FlexColor.brandBlueDarkSecondary,
            secondaryVariant: FlexColor.brandBlueDarkSecondaryVariant,
            appBarColor: FlexColor.brandBlueDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.deepBlue:
        return const FlexSchemeData(
          name: FlexColor.deepBlueName,
          description: FlexColor.deepBlueDescription,
          light: FlexSchemeColor(
            primary: FlexColor.deepBlueLightPrimary,
            primaryVariant: FlexColor.deepBlueLightPrimaryVariant,
            secondary: FlexColor.deepBlueLightSecondary,
            secondaryVariant: FlexColor.deepBlueLightSecondaryVariant,
            appBarColor: FlexColor.deepBlueLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.deepBlueDarkPrimary,
            primaryVariant: FlexColor.deepBlueDarkPrimaryVariant,
            secondary: FlexColor.deepBlueDarkSecondary,
            secondaryVariant: FlexColor.deepBlueDarkSecondaryVariant,
            appBarColor: FlexColor.deepBlueDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.sakura:
        return const FlexSchemeData(
          name: FlexColor.sakuraName,
          description: FlexColor.sakuraDescription,
          light: FlexSchemeColor(
            primary: FlexColor.sakuraLightPrimary,
            primaryVariant: FlexColor.sakuraLightPrimaryVariant,
            secondary: FlexColor.sakuraLightSecondary,
            secondaryVariant: FlexColor.sakuraLightSecondaryVariant,
            appBarColor: FlexColor.sakuraLightSecondaryVariant,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.sakuraDarkPrimary,
            primaryVariant: FlexColor.sakuraDarkPrimaryVariant,
            secondary: FlexColor.sakuraDarkSecondary,
            secondaryVariant: FlexColor.sakuraDarkSecondaryVariant,
            appBarColor: FlexColor.sakuraDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.mandyRed:
        return const FlexSchemeData(
          name: FlexColor.mandyRedName,
          description: FlexColor.mandyRedDescription,
          light: FlexSchemeColor(
            primary: FlexColor.mandyRedLightPrimary,
            primaryVariant: FlexColor.mandyRedLightPrimaryVariant,
            secondary: FlexColor.mandyRedLightSecondary,
            secondaryVariant: FlexColor.mandyRedLightSecondaryVariant,
            appBarColor: FlexColor.mandyRedLightSecondaryVariant,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.mandyRedDarkPrimary,
            primaryVariant: FlexColor.mandyRedDarkPrimaryVariant,
            secondary: FlexColor.mandyRedDarkSecondary,
            secondaryVariant: FlexColor.mandyRedDarkSecondaryVariant,
            appBarColor: FlexColor.mandyRedDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.red:
        return const FlexSchemeData(
          name: FlexColor.redName,
          description: FlexColor.redDescription,
          light: FlexSchemeColor(
            primary: FlexColor.redLightPrimary,
            primaryVariant: FlexColor.redLightPrimaryVariant,
            secondary: FlexColor.redLightSecondary,
            secondaryVariant: FlexColor.redLightSecondaryVariant,
            appBarColor: FlexColor.redLightSecondaryVariant,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.redDarkPrimary,
            primaryVariant: FlexColor.redDarkPrimaryVariant,
            secondary: FlexColor.redDarkSecondary,
            secondaryVariant: FlexColor.redDarkSecondaryVariant,
            appBarColor: FlexColor.redDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.redWine:
        return const FlexSchemeData(
          name: FlexColor.redWineName,
          description: FlexColor.redWineDescription,
          light: FlexSchemeColor(
            primary: FlexColor.redWineLightPrimary,
            primaryVariant: FlexColor.redWineLightPrimaryVariant,
            secondary: FlexColor.redWineLightSecondary,
            secondaryVariant: FlexColor.redWineLightSecondaryVariant,
            appBarColor: FlexColor.redWineLightSecondaryVariant,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.redWineDarkPrimary,
            primaryVariant: FlexColor.redWineDarkPrimaryVariant,
            secondary: FlexColor.redWineDarkSecondary,
            secondaryVariant: FlexColor.redWineDarkSecondaryVariant,
            appBarColor: FlexColor.redWineDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.purpleBrown:
        return const FlexSchemeData(
          name: FlexColor.purpleBrownName,
          description: FlexColor.purpleBrownDescription,
          light: FlexSchemeColor(
            primary: FlexColor.purpleBrownLightPrimary,
            primaryVariant: FlexColor.purpleBrownLightPrimaryVariant,
            secondary: FlexColor.purpleBrownLightSecondary,
            secondaryVariant: FlexColor.purpleBrownLightSecondaryVariant,
            appBarColor: FlexColor.purpleBrownLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.purpleBrownDarkPrimary,
            primaryVariant: FlexColor.purpleBrownDarkPrimaryVariant,
            secondary: FlexColor.purpleBrownDarkSecondary,
            secondaryVariant: FlexColor.purpleBrownDarkSecondaryVariant,
            appBarColor: FlexColor.purpleBrownDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.green:
        return const FlexSchemeData(
          name: FlexColor.greenName,
          description: FlexColor.greenDescription,
          light: FlexSchemeColor(
            primary: FlexColor.greenLightPrimary,
            primaryVariant: FlexColor.greenLightPrimaryVariant,
            secondary: FlexColor.greenLightSecondary,
            secondaryVariant: FlexColor.greenLightSecondaryVariant,
            appBarColor: FlexColor.greenLightSecondaryVariant,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.greenDarkPrimary,
            primaryVariant: FlexColor.greenDarkPrimaryVariant,
            secondary: FlexColor.greenDarkSecondary,
            secondaryVariant: FlexColor.greenDarkSecondaryVariant,
            appBarColor: FlexColor.greenDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.money:
        return const FlexSchemeData(
          name: FlexColor.moneyName,
          description: FlexColor.moneyDescription,
          light: FlexSchemeColor(
            primary: FlexColor.moneyLightPrimary,
            primaryVariant: FlexColor.moneyLightPrimaryVariant,
            secondary: FlexColor.moneyLightSecondary,
            secondaryVariant: FlexColor.moneyLightSecondaryVariant,
            appBarColor: FlexColor.moneyLightSecondaryVariant,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.moneyDarkPrimary,
            primaryVariant: FlexColor.moneyDarkPrimaryVariant,
            secondary: FlexColor.moneyDarkSecondary,
            secondaryVariant: FlexColor.moneyDarkSecondaryVariant,
            appBarColor: FlexColor.moneyDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.jungle:
        return const FlexSchemeData(
          name: FlexColor.jungleName,
          description: FlexColor.jungleDescription,
          light: FlexSchemeColor(
            primary: FlexColor.jungleLightPrimary,
            primaryVariant: FlexColor.jungleLightPrimaryVariant,
            secondary: FlexColor.jungleLightSecondary,
            secondaryVariant: FlexColor.jungleLightSecondaryVariant,
            appBarColor: FlexColor.jungleLightSecondaryVariant,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.jungleDarkPrimary,
            primaryVariant: FlexColor.jungleDarkPrimaryVariant,
            secondary: FlexColor.jungleDarkSecondary,
            secondaryVariant: FlexColor.jungleDarkSecondaryVariant,
            appBarColor: FlexColor.jungleDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.greyLaw:
        return const FlexSchemeData(
          name: FlexColor.greyLawName,
          description: FlexColor.greyLawDescription,
          light: FlexSchemeColor(
            primary: FlexColor.greyLawLightPrimary,
            primaryVariant: FlexColor.greyLawLightPrimaryVariant,
            secondary: FlexColor.greyLawLightSecondary,
            secondaryVariant: FlexColor.greyLawLightSecondaryVariant,
            appBarColor: FlexColor.greyLawLightSecondaryVariant,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.greyLawDarkPrimary,
            primaryVariant: FlexColor.greyLawDarkPrimaryVariant,
            secondary: FlexColor.greyLawDarkSecondary,
            secondaryVariant: FlexColor.greyLawDarkSecondaryVariant,
            appBarColor: FlexColor.greyLawDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.wasabi:
        return const FlexSchemeData(
          name: FlexColor.wasabiName,
          description: FlexColor.wasabiDescription,
          light: FlexSchemeColor(
            primary: FlexColor.wasabiLightPrimary,
            primaryVariant: FlexColor.wasabiLightPrimaryVariant,
            secondary: FlexColor.wasabiLightSecondary,
            secondaryVariant: FlexColor.wasabiLightSecondaryVariant,
            appBarColor: FlexColor.wasabiLightSecondaryVariant,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.wasabiDarkPrimary,
            primaryVariant: FlexColor.wasabiDarkPrimaryVariant,
            secondary: FlexColor.wasabiDarkSecondary,
            secondaryVariant: FlexColor.wasabiDarkSecondaryVariant,
            appBarColor: FlexColor.wasabiDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.gold:
        return const FlexSchemeData(
          name: FlexColor.goldName,
          description: FlexColor.goldDescription,
          light: FlexSchemeColor(
            primary: FlexColor.goldLightPrimary,
            primaryVariant: FlexColor.goldLightPrimaryVariant,
            secondary: FlexColor.goldLightSecondary,
            secondaryVariant: FlexColor.goldLightSecondaryVariant,
            appBarColor: FlexColor.goldLightSecondaryVariant,
            error: FlexColor.materialLightErrorHc,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.goldDarkPrimary,
            primaryVariant: FlexColor.goldDarkPrimaryVariant,
            secondary: FlexColor.goldDarkSecondary,
            secondaryVariant: FlexColor.goldDarkSecondaryVariant,
            appBarColor: FlexColor.goldDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.mango:
        return const FlexSchemeData(
          name: FlexColor.mangoName,
          description: FlexColor.mangoDescription,
          light: FlexSchemeColor(
            primary: FlexColor.mangoLightPrimary,
            primaryVariant: FlexColor.mangoLightPrimaryVariant,
            secondary: FlexColor.mangoLightSecondary,
            secondaryVariant: FlexColor.mangoLightSecondaryVariant,
            appBarColor: FlexColor.mangoLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.mangoDarkPrimary,
            primaryVariant: FlexColor.mangoDarkPrimaryVariant,
            secondary: FlexColor.mangoDarkSecondary,
            secondaryVariant: FlexColor.mangoDarkSecondaryVariant,
            appBarColor: FlexColor.mangoDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.amber:
        return const FlexSchemeData(
          name: FlexColor.amberName,
          description: FlexColor.amberDescription,
          light: FlexSchemeColor(
            primary: FlexColor.amberLightPrimary,
            primaryVariant: FlexColor.amberLightPrimaryVariant,
            secondary: FlexColor.amberLightSecondary,
            secondaryVariant: FlexColor.amberLightSecondaryVariant,
            appBarColor: FlexColor.amberLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.amberDarkPrimary,
            primaryVariant: FlexColor.amberDarkPrimaryVariant,
            secondary: FlexColor.amberDarkSecondary,
            secondaryVariant: FlexColor.amberDarkSecondaryVariant,
            appBarColor: FlexColor.amberDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.vesuviusBurn:
        return const FlexSchemeData(
          name: FlexColor.vesuviusBurnName,
          description: FlexColor.vesuviusBurnDescription,
          light: FlexSchemeColor(
            primary: FlexColor.vesuviusBurnLightPrimary,
            primaryVariant: FlexColor.vesuviusBurnLightPrimaryVariant,
            secondary: FlexColor.vesuviusBurnLightSecondary,
            secondaryVariant: FlexColor.vesuviusBurnLightSecondaryVariant,
            appBarColor: FlexColor.vesuviusBurnLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.vesuviusBurnDarkPrimary,
            primaryVariant: FlexColor.vesuviusBurnDarkPrimaryVariant,
            secondary: FlexColor.vesuviusBurnDarkSecondary,
            secondaryVariant: FlexColor.vesuviusBurnDarkSecondaryVariant,
            appBarColor: FlexColor.vesuviusBurnDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.deepPurple:
        return const FlexSchemeData(
          name: FlexColor.deepPurpleName,
          description: FlexColor.deepPurpleDescription,
          light: FlexSchemeColor(
            primary: FlexColor.deepPurpleLightPrimary,
            primaryVariant: FlexColor.deepPurpleLightPrimaryVariant,
            secondary: FlexColor.deepPurpleLightSecondary,
            secondaryVariant: FlexColor.deepPurpleLightSecondaryVariant,
            appBarColor: FlexColor.deepPurpleLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.deepPurpleDarkPrimary,
            primaryVariant: FlexColor.deepPurpleDarkPrimaryVariant,
            secondary: FlexColor.deepPurpleDarkSecondary,
            secondaryVariant: FlexColor.deepPurpleDarkSecondaryVariant,
            appBarColor: FlexColor.deepPurpleDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.ebonyClay:
        return const FlexSchemeData(
          name: FlexColor.ebonyClayName,
          description: FlexColor.ebonyClayDescription,
          light: FlexSchemeColor(
            primary: FlexColor.ebonyClayLightPrimary,
            primaryVariant: FlexColor.ebonyClayLightPrimaryVariant,
            secondary: FlexColor.ebonyClayLightSecondary,
            secondaryVariant: FlexColor.ebonyClayLightSecondaryVariant,
            appBarColor: FlexColor.ebonyClayLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.ebonyClayDarkPrimary,
            primaryVariant: FlexColor.ebonyClayDarkPrimaryVariant,
            secondary: FlexColor.ebonyClayDarkSecondary,
            secondaryVariant: FlexColor.ebonyClayDarkSecondaryVariant,
            appBarColor: FlexColor.ebonyClayDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.barossa:
        return const FlexSchemeData(
          name: FlexColor.barossaName,
          description: FlexColor.barossaDescription,
          light: FlexSchemeColor(
            primary: FlexColor.barossaLightPrimary,
            primaryVariant: FlexColor.barossaLightPrimaryVariant,
            secondary: FlexColor.barossaLightSecondary,
            secondaryVariant: FlexColor.barossaLightSecondaryVariant,
            appBarColor: FlexColor.barossaLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.barossaDarkPrimary,
            primaryVariant: FlexColor.barossaDarkPrimaryVariant,
            secondary: FlexColor.barossaDarkSecondary,
            secondaryVariant: FlexColor.barossaDarkSecondaryVariant,
            appBarColor: FlexColor.barossaDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.shark:
        return const FlexSchemeData(
          name: FlexColor.sharkName,
          description: FlexColor.sharkDescription,
          light: FlexSchemeColor(
            primary: FlexColor.sharkLightPrimary,
            primaryVariant: FlexColor.sharkLightPrimaryVariant,
            secondary: FlexColor.sharkLightSecondary,
            secondaryVariant: FlexColor.sharkLightSecondaryVariant,
            appBarColor: FlexColor.sharkLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.sharkDarkPrimary,
            primaryVariant: FlexColor.sharkDarkPrimaryVariant,
            secondary: FlexColor.sharkDarkSecondary,
            secondaryVariant: FlexColor.sharkDarkSecondaryVariant,
            appBarColor: FlexColor.sharkDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.bigStone:
        return const FlexSchemeData(
          name: FlexColor.bigStoneName,
          description: FlexColor.bigStoneDescription,
          light: FlexSchemeColor(
            primary: FlexColor.bigStoneLightPrimary,
            primaryVariant: FlexColor.bigStoneLightPrimaryVariant,
            secondary: FlexColor.bigStoneLightSecondary,
            secondaryVariant: FlexColor.bigStoneLightSecondaryVariant,
            appBarColor: FlexColor.bigStoneLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.bigStoneDarkPrimary,
            primaryVariant: FlexColor.bigStoneDarkPrimaryVariant,
            secondary: FlexColor.bigStoneDarkSecondary,
            secondaryVariant: FlexColor.bigStoneDarkSecondaryVariant,
            appBarColor: FlexColor.bigStoneDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.damask:
        return const FlexSchemeData(
          name: FlexColor.damaskName,
          description: FlexColor.damaskDescription,
          light: FlexSchemeColor(
            primary: FlexColor.damaskLightPrimary,
            primaryVariant: FlexColor.damaskLightPrimaryVariant,
            secondary: FlexColor.damaskLightSecondary,
            secondaryVariant: FlexColor.damaskLightSecondaryVariant,
            appBarColor: FlexColor.damaskLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.damaskDarkPrimary,
            primaryVariant: FlexColor.damaskDarkPrimaryVariant,
            secondary: FlexColor.damaskDarkSecondary,
            secondaryVariant: FlexColor.damaskDarkSecondaryVariant,
            appBarColor: FlexColor.damaskDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.bahamaBlue:
        return const FlexSchemeData(
          name: FlexColor.bahamaBlueName,
          description: FlexColor.bahamaBlueDescription,
          light: FlexSchemeColor(
            primary: FlexColor.bahamaBlueLightPrimary,
            primaryVariant: FlexColor.bahamaBlueLightPrimaryVariant,
            secondary: FlexColor.bahamaBlueLightSecondary,
            secondaryVariant: FlexColor.bahamaBlueLightSecondaryVariant,
            appBarColor: FlexColor.bahamaBlueLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.bahamaBlueDarkPrimary,
            primaryVariant: FlexColor.bahamaBlueDarkPrimaryVariant,
            secondary: FlexColor.bahamaBlueDarkSecondary,
            secondaryVariant: FlexColor.bahamaBlueDarkSecondaryVariant,
            appBarColor: FlexColor.bahamaBlueDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.mallardGreen:
        return const FlexSchemeData(
          name: FlexColor.mallardGreenName,
          description: FlexColor.mallardGreenDescription,
          light: FlexSchemeColor(
            primary: FlexColor.mallardGreenLightPrimary,
            primaryVariant: FlexColor.mallardGreenLightPrimaryVariant,
            secondary: FlexColor.mallardGreenLightSecondary,
            secondaryVariant: FlexColor.mallardGreenLightSecondaryVariant,
            appBarColor: FlexColor.mallardGreenLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.mallardGreenDarkPrimary,
            primaryVariant: FlexColor.mallardGreenDarkPrimaryVariant,
            secondary: FlexColor.mallardGreenDarkSecondary,
            secondaryVariant: FlexColor.mallardGreenDarkSecondaryVariant,
            appBarColor: FlexColor.mallardGreenDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.espresso:
        return const FlexSchemeData(
          name: FlexColor.espressoName,
          description: FlexColor.espressoDescription,
          light: FlexSchemeColor(
            primary: FlexColor.espressoLightPrimary,
            primaryVariant: FlexColor.espressoLightPrimaryVariant,
            secondary: FlexColor.espressoLightSecondary,
            secondaryVariant: FlexColor.espressoLightSecondaryVariant,
            appBarColor: FlexColor.espressoLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.espressoDarkPrimary,
            primaryVariant: FlexColor.espressoDarkPrimaryVariant,
            secondary: FlexColor.espressoDarkSecondary,
            secondaryVariant: FlexColor.espressoDarkSecondaryVariant,
            appBarColor: FlexColor.espressoDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.outerSpace:
        return const FlexSchemeData(
          name: FlexColor.outerSpaceName,
          description: FlexColor.outerSpaceDescription,
          light: FlexSchemeColor(
            primary: FlexColor.outerSpaceLightPrimary,
            primaryVariant: FlexColor.outerSpaceLightPrimaryVariant,
            secondary: FlexColor.outerSpaceLightSecondary,
            secondaryVariant: FlexColor.outerSpaceLightSecondaryVariant,
            appBarColor: FlexColor.outerSpaceLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.outerSpaceDarkPrimary,
            primaryVariant: FlexColor.outerSpaceDarkPrimaryVariant,
            secondary: FlexColor.outerSpaceDarkSecondary,
            secondaryVariant: FlexColor.outerSpaceDarkSecondaryVariant,
            appBarColor: FlexColor.outerSpaceDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );

      case AppFlexScheme.purple:
        return flexSchemePurple;

      case AppFlexScheme.flexScheme1:
        return flexScheme1;

      case AppFlexScheme.flexScheme2:
        return flexScheme2;

      case AppFlexScheme.flexScheme3:
        return flexScheme3;

      default:
        return const FlexSchemeData(
          name: FlexColor.materialName,
          description: FlexColor.materialDescription,
          light: FlexSchemeColor(
            primary: FlexColor.materialLightPrimary,
            primaryVariant: FlexColor.materialLightPrimaryVariant,
            secondary: FlexColor.materialLightSecondary,
            secondaryVariant: FlexColor.materialLightSecondaryVariant,
            appBarColor: FlexColor.materialLightSecondaryVariant,
            error: FlexColor.materialLightError,
          ),
          dark: FlexSchemeColor(
            primary: FlexColor.materialDarkPrimary,
            primaryVariant: FlexColor.materialDarkPrimaryVariant,
            secondary: FlexColor.materialDarkSecondary,
            secondaryVariant: FlexColor.materialDarkSecondaryVariant,
            appBarColor: FlexColor.materialDarkSecondaryVariant,
            error: FlexColor.materialDarkError,
          ),
        );
    }
  }

}
