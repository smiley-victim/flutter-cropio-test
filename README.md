<h1 align="center">Cropio</h1>
<div align="center">A application for the Farmers</div>

![Project IDX Community Templates](./intro.png)

<a href="https://idx.google.com/import?url=https%3A%2F%2Fgithub.com%2FFinding-new-code%2Fproject-Ghassphuss.git">
  <picture>
    <source
      media="(prefers-color-scheme: dark)"
      srcset="https://cdn.idx.dev/btn/continue_dark_32.svg">
    <source
      media="(prefers-color-scheme: light)"
      srcset="https://cdn.idx.dev/btn/continue_light_32.svg">
    <img
      height="32"
      alt="Continue in IDX"
      src="https://cdn.idx.dev/btn/continue_purple_32.svg">
  </picture>
</a>

## Our Vision

This is the new application aimed for helping farmers in the field of agriculture

## File Structure

The project is structured as follows:
```
 📁 lib/
│  ├── 📁 l10n/
│  │  └── 📄 l10n.dart
│  ├── 📁 Features/
│  │  ├── 📁 Camera/
│  │  │  ├── 📁 Data/
│  │  │  │  ├── 📁 modals/
│  │  │  │  │  └── 📄 plantdatamodal.dart
│  │  │  │  └── 📁 DataSource/
│  │  │  │      ├── 📄 plant_analysis.dart
│  │  │  │      └── 📄 database.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Widgets/
│  │  │      │  ├── 📄 plant_analysis_detail_view.dart
│  │  │      │  ├── 📄 analysis_view.dart
│  │  │      │  └── 📄 analysis_info_dialog.dart
│  │  │      └── 📁 Pages/
│  │  │          └── 📄 camera_page.dart
│  │  ├── 📁 Calculator/
│  │  │  ├── 📁 controller/
│  │  │  │  └── 📄 fertilizer_calculator.dart
│  │  │  ├── 📁 widget/
│  │  │  │  └── 📄 btn_widget.dart
│  │  │  └── 📁 screen/
│  │  │      └── 📄 fertilizer_calculator_screen.dart
│  │  ├── 📁 Home/
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Widgets/
│  │  │      │  ├── 📄 do_you_know.dart
│  │  │      │  ├── 📄 app_drawer.dart
│  │  │      │  ├── 📄 bottom_bar.dart
│  │  │      │  ├── 📄 calender_card.dart
│  │  │      │  ├── 📄 coachmarkaer.dart
│  │  │      │  ├── 📄 square_card_button.dart
│  │  │      │  └── 📄 profile_img_stack.dart
│  │  │      └── 📁 Pages/
│  │  │          ├── 📄 homepage.dart
│  │  │          ├── 📄 homepage_v2.dart
│  │  │          ├── 📄 responsive_homepage.dart
│  │  │          ├── 📄 series_of_pages.dart
│  │  │          └── 📄 blank.dart
│  │  ├── 📁 AI chat interaction/
│  │  │  ├── 📁 Data/
│  │  │  │  └── 📄 chatservice.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Widgets/
│  │  │      │  └── 📄 ai_voice_bottomsheet.dart
│  │  │      └── 📁 Pages/
│  │  │          ├── 📄 ai_home_page.dart
│  │  │          ├── 📄 chat_history.dart
│  │  │          └── 📄 chat_page.dart
│  │  ├── 📁 Community/
│  │  │  ├── 📁 Data/
│  │  │  │  ├── 📁 Models/
│  │  │  │  │  ├── 📄 post_model.dart
│  │  │  │  │  └── 📄 comment_model.dart
│  │  │  │  └── 📄 community_services.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Widgets/
│  │  │      │  ├── 📄 comment_section.dart
│  │  │      │  ├── 📄 custom_appbar.dart
│  │  │      │  └── 📄 post_container.dart
│  │  │      └── 📁 Pages/
│  │  │          ├── 📄 community_screen.dart
│  │  │          ├── 📄 bottom_navbar_screen.dart
│  │  │          └── 📄 create_post_screen.dart
│  │  ├── 📁 Carbon Reward/
│  │  │  ├── 📁 Data/
│  │  │  │  └── 📁  modals/
│  │  │  │      └── 📄 sustainanble_practice_modal.dart
│  │  │  └── 📁 Presentation/
│  │  │      └── 📁 Pages/
│  │  │          └── 📄 carbon_reward_view.dart
│  │  ├── 📁 Garden/
│  │  │  ├── 📁 Data/
│  │  │  │  └── 📁 modala/
│  │  │  │      └── 📄 garden_plants.dart
│  │  │  └── 📁 Presentation/
│  │  │      └── 📁 Pages/
│  │  │          ├── 📄 crop_list_page.dart
│  │  │          ├── 📄 garden_page.dart
│  │  │          ├── 📄 garden_detail_page_test.dart
│  │  │          └── 📄 garden_plant_detail_page.dart
│  │  ├── 📁 Weather/
│  │  │  ├── 📁 Data/
│  │  │  │  ├── 📁 Datasource/
│  │  │  │  │  └── 📄 data.dart
│  │  │  │  └── 📁 Modals/
│  │  │  │      └── 📄 weather_data.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Widgets/
│  │  │      │  ├── 📄 rise_set_timings.dart
│  │  │      │  ├── 📄 days_today.dart
│  │  │      │  ├── 📄 other_temps.dart
│  │  │      │  ├── 📄 daily_summary.dart
│  │  │      │  ├── 📄 hourly_weather.dart
│  │  │      │  ├── 📄 tabs.dart
│  │  │      │  ├── 📄 weather_details.dart
│  │  │      │  ├── 📄 weather_detail_widget.dart
│  │  │      │  ├── 📄 weather_detail_current.dart
│  │  │      │  ├── 📄 loader.dart
│  │  │      │  ├── 📄 day.dart
│  │  │      │  ├── 📄 frosted_glass_current.dart
│  │  │      │  └── 📄 frosted_glass.dart
│  │  │      └── 📁 Pages/
│  │  │          └── 📄 weather_page.dart
│  │  ├── 📁 Reminder/
│  │  │  ├── 📁 Data/
│  │  │  │  ├── 📁 modals/
│  │  │  │  │  └── 📄 plantevent_model.dart
│  │  │  │  └── 📁 DataSource/
│  │  │  │      └── 📄 reminder_database_helper.dart
│  │  │  ├── 📁 Domain/
│  │  │  │  └── 📄 plantevent_service.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 bloc/
│  │  │      │  ├── 📄 reminder_bloc.dart
│  │  │      │  ├── 📄 reminder_state.dart
│  │  │      │  └── 📄 reminder_event.dart
│  │  │      └── 📁 Pages/
│  │  │          ├── 📄 event_card.dart
│  │  │          └── 📄 reminder.dart
│  │  ├── 📁 Plant info panel/
│  │  │  └── 📁 Presentations/
│  │  │      ├── 📁 Widget/
│  │  │      │  └── 📄 feature_card.dart
│  │  │      └── 📁 Pages/
│  │  │          ├── 📄 plant_info_listview.dart
│  │  │          └── 📄 plants_info_detailview.dart
│  │  ├── 📁 Search/
│  │  │  ├── 📁 Data/
│  │  │  │  ├── 📁 model/
│  │  │  │  │  ├── 📄 plant_info.g.dart
│  │  │  │  │  ├── 📄 plant_info.dart
│  │  │  │  │  └── 📄 all_plant_name_model.dart
│  │  │  │  └── 📁 services/
│  │  │  │      ├── 📄 search_service.dart
│  │  │  │      └── 📄 fetch_all_plant_name.dart
│  │  │  └── 📁 Presentations/
│  │  │      ├── 📁 Widgets/
│  │  │      │  └── 📄 search_chips.dart
│  │  │      └── 📁 Pages/
│  │  │          └── 📄 search_page_mobile.dart
│  │  ├── 📁 Languages/
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Widgets/
│  │  │      │  └── 📄 lang_search_page.dart
│  │  │      └── 📁 Pages/
│  │  │          └── 📄 language_selection_page.dart
│  │  ├── 📁 Auth/
│  │  │  ├── 📁 Data/
│  │  │  │  ├── 📁 Models/
│  │  │  │  │  └── 📄 usermodel.dart
│  │  │  │  └── 📁 DataSource/
│  │  │  │      └── 📄 authservice.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Widgets/
│  │  │      │  ├── 📄 auth_page_illustration.dart
│  │  │      │  └── 📄 signboard.dart
│  │  │      └── 📁 Pages/
│  │  │          ├── 📄 login_signup_page.dart
│  │  │          ├── 📄 auth_page.dart
│  │  │          ├── 📄 onboarding_page.dart
│  │  │          └── 📄 forgot_password_screen.dart
│  │  ├── 📁 Profile/
│  │  │  ├── 📁 Data/
│  │  │  │  └── 📁 Modals/
│  │  │  │      └── 📄 user_profile_model.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Widgets/
│  │  │      │  └── 📄 shapes_widgets.dart
│  │  │      └── 📁 Pages/
│  │  │          └── 📄 profile_page.dart
│  │  └── 📁 Maps/
│  │      ├── 📁 Data/
│  │      ├── 📁 Domain/
│  │      └── 📁 Presentation/
│  │          ├── 📁 Widgets/
│  │          │  ├── 📄 walkthough_guide.dart
│  │          │  └── 📄 infocard.dart
│  │          └── 📁 Pages/
│  │              └── 📄 map.dart
│  ├── 📁 Core/
│  │  ├── 📁 Get_it/
│  │  │  └── 📄 get_it.dart
│  │  └── 📁 Constants/
│  │      └── 📄 appconstants.dart
│  └── 📄 main.dart

```
## Getting Started

**Prerequisites:**

* VS Code or Flutter SDK
* Git


**Installation:**

1. Clone the repository: `git clone https://github.com/Finding-new-code/project-Ghassphuss.git`
2. Navigate to the project directory: `cd project-Ghassphuss`
3. update dependencies using `flutter pub get`
4. Run the app:  `flutter run `

## License

This project is licensed under the [**Apache MIT License**].

[**Apache MIT License**]: https://www.apache.org/licenses/LICENSE-2.0