

import 'package:flutter/material.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  final List<Map<String, String>> _languages = [
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇺🇸'
    },
    {
      'code': 'es',
      'name': 'Spanish',
      'nativeName': 'Español',
      'flag': '🇪🇸'
    },
    {
      'code': 'fr',
      'name': 'French',
      'nativeName': 'Français',
      'flag': '🇫🇷'
    },
    {
      'code': 'ar',
      'name': 'Arabic',
      'nativeName': 'العربية',
      'flag': '🇸🇦'
    },
    {
      'code': 'hi',
      'name': 'Hindi',
      'nativeName': 'हिन्दी',
      'flag': '🇮🇳'
    },
    {
      'code': 'zh',
      'name': 'Chinese',
      'nativeName': '中文',
      'flag': '🇨🇳'
    },
    {
      'code': 'sw',
      'name': 'Swahili',
      'nativeName': 'Kiswahili',
      'flag': '🇰🇪'
    },
    {
      'code': 'pt',
      'name': 'Portuguese',
      'nativeName': 'Português',
      'flag': '🇧🇷'
    },
    
    {
      'code': 'hi',
      'name': 'Hindi',
      'nativeName': 'हिन्दी',
      'region': 'North India',
      'flag': '🇮🇳'
    },
    {
      'code': 'mr',
      'name': 'Marathi',
      'nativeName': 'मराठी',
      'region': 'Maharashtra',
      'flag': '🇮🇳'
    },
    {
      'code': 'te',
      'name': 'Telugu',
      'nativeName': 'తెలుగు',
      'region': 'Andhra Pradesh, Telangana',
      'flag': '🇮🇳'
    },
    {
      'code': 'ta',
      'name': 'Tamil',
      'nativeName': 'தமிழ்',
      'region': 'Tamil Nadu, Sri Lanka',
      'flag': '🇮🇳'
    },
    {
      'code': 'bn',
      'name': 'Bengali',
      'nativeName': 'বাংলা',
      'region': 'West Bengal, Bangladesh',
      'flag': '🇮🇳'
    },
    {
      'code': 'kn',
      'name': 'Kannada',
      'nativeName': 'ಕನ್ನಡ',
      'region': 'Karnataka',
      'flag': '🇮🇳'
    },
    {
      'code': 'ml',
      'name': 'Malayalam',
      'nativeName': 'മലയാളം',
      'region': 'Kerala',
      'flag': '🇮🇳'
    },
    {
      'code': 'gu',
      'name': 'Gujarati',
      'nativeName': 'ગુજરાતી',
      'region': 'Gujarat',
      'flag': '🇮🇳'
    },
    {
      'code': 'or',
      'name': 'Odia',
      'nativeName': 'ଓଡ଼ିଆ',
      'region': 'Odisha',
      'flag': '🇮🇳'
    },
    {
      'code': 'pa',
      'name': 'Punjabi',
      'nativeName': 'ਪੰਜਾਬੀ',
      'region': 'Punjab',
      'flag': '🇮🇳'
    },
    {
      'code': 'as',
      'name': 'Assamese',
      'nativeName': 'অসমীয়া',
      'region': 'Assam',
      'flag': '🇮🇳'
    },
    {
      'code': 'mr',
      'name': 'Maithili',
      'nativeName': 'মৈথিলী',
      'region': 'Bihar, Nepal',
      'flag': '🇮🇳'
    },
    {
      'code': 'sa',
      'name': 'Sanskrit',
      'nativeName': 'संस्कृत',
      'region': 'Classical Language',
      'flag': '🇮🇳'
    },
    {
      'code': 'ne',
      'name': 'Nepali',
      'nativeName': 'नेपाली',
      'region': 'Sikkim, Nepal Border',
      'flag': '🇮🇳'
    },
    {
      'code': 'doi',
      'name': 'Dogri',
      'nativeName': 'डोगरी',
      'region': 'Jammu and Kashmir',
      'flag': '🇮🇳'
    },
    {
      'code': 'ks',
      'name': 'Kashmiri',
      'nativeName': 'کٲشُر',
      'region': 'Jammu and Kashmir',
      'flag': '🇮🇳'
    },
    {
      'code': 'sd',
      'name': 'Sindhi',
      'nativeName': 'सिंधी',
      'region': 'Sindh, Gujarat',
      'flag': '🇮🇳'
    },
    {
      'code': 'ko',
      'name': 'Konkani',
      'nativeName': 'कोंकणी',
      'region': 'Goa, Maharashtra',
      'flag': '🇮🇳'
    },
    {
      'code': 'bo',
      'name': 'Bodo',
      'nativeName': 'बड़ो',
      'region': 'Assam',
      'flag': '🇮🇳'
    },
    {
      'code': 'sat',
      'name': 'Santali',
      'nativeName': 'ᱥᱟᱱᱛᱟᱲᱤ',
      'region': 'Tribal Regions',
      'flag': '🇮🇳'
    },
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
      'region': 'Official/Business Language',
      'flag': '🇬🇧'
    },
    {
      'code': 'ur',
      'name': 'Urdu',
      'nativeName': 'اردو',
      'region': 'North India',
      'flag': '🇮🇳'
    }
  ];
  

  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('Select Language'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Language Selection Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Choose Your Preferred Language',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ),

          // Language List
          Expanded(
            child: ListView.builder(
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final language = _languages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, 
                    vertical: 8.0
                  ),
                  child: Card(
                    elevation: _selectedLanguage == language['code'] ? 4 : 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: _selectedLanguage == language['code']
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = language['code'];
                        });
                      },
                      leading: Text(
                        language['flag']!, 
                        style: TextStyle(fontSize: 32),
                      ),
                      title: Text(
                        language['name']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        language['nativeName']!,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: _selectedLanguage == language['code']
                        ? Icon(
                            Icons.check_circle, 
                            color: Theme.of(context).primaryColor
                          )
                        : null,
                    ),
                  ),
                );
              },
            ),
          ),

          // Continue Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _selectedLanguage != null
                ? () {
                    // TODO: Implement language change logic
                    // Example:
                    // AppLocalizations.changeLanguage(context, _selectedLanguage!);
                    // Navigator.of(context).pushReplacement(...);
                  }
                : null,
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
