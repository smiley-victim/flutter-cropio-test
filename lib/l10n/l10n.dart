// import 'package:flutter/material.dart';

// class AppLocalizations {
//   AppLocalizations(this.locale);

//   final Locale locale;

//   static AppLocalizations of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
//   }

//   static Map<String, Map<String, String>> _localizedValues = {
//     'en': {
//       'appTitle': 'App Title',
//     },
//     'hi': {
//       'appTitle': 'ऐप शीर्षक',
//     },
//     'bn': {
//       'appTitle': 'অ্যাপ শিরোনাম',
//     },
//     'te': {
//       'appTitle': 'అనువర్తన శీర్షిక',
//     },
//     'mr': {
//       'appTitle': 'अ‍ॅप शीर्षक',
//     },
//     'ta': {
//       'appTitle': 'பயன்பாட்டு தலைப்பு',
//     },
//     'gu': {
//       'appTitle': 'એપ્લિકેશન શીર્ષક',
//     },
//     'kn': {
//       'appTitle': 'ಅಪ್ಲಿಕೇಶನ್ ಶೀರ್ಷಿಕೆ',
//     },
//     'ml': {
//       'appTitle': 'ആപ്ലിക്കേഷൻ ശീർഷകം',
//     },
//     'pa': {
//       'appTitle': 'ਐਪ ਟਾਈਟਲ',
//     },
//     'ur': {
//       'appTitle': 'ایپ کا عنوان',
//     },
//     'or': {
//       'appTitle': 'ଆପ୍ଲିକେସନ୍ ଶୀର୍ଷକ',
//     },
//     'as': {
//       'appTitle': 'এপ্লিকেচন শিৰোনাম',
//     },
//     'sa': {
//       'appTitle': 'अनुप्रयोग शीर्षक',
//     },
//   };

//   String get appTitle {
//     return _localizedValues[locale.languageCode]!['appTitle']!;
//   }
// }

// class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//   const AppLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) {
//     return _localizedValues.keys.contains(locale.languageCode);
//   }

//   @override
//   Future<AppLocalizations> load(Locale locale) {
//     return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
//   }

//   @override
//   bool shouldReload(AppLocalizationsDelegate old) => false;
// }

// // Usage in MaterialApp:
// // localizationsDelegates: [
// //   AppLocalizationsDelegate(),
// //   GlobalMaterialLocalizations.delegate,
// //   GlobalWidgetsLocalizations.delegate,
// //   GlobalCupertinoLocalizations.delegate,
// // ],
// // supportedLocales: [
// //   const Locale('en', ''), // English
// //   const Locale('hi', ''), // Hindi
// //   const Locale('bn', ''), // Bengali
// //   const Locale('te', ''), // Telugu
// //   const Locale('mr', ''), // Marathi
// //   const Locale('ta', ''), // Tamil
// //   const Locale('gu', ''), // Gujarati
// //   const Locale('kn', ''), // Kannada
// //   const Locale('ml', ''), // Malayalam
// //   const Locale('pa', ''), // Punjabi
// //   const Locale('ur', ''), // Urdu
// //   const Locale('or', ''), // Odia
// //   const Locale('as', ''), // Assamese
// //   const Locale('sa', ''), // Sanskrit
// // ],