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
├📁 lib/
│  ├── 📁 Features/
│  │  ├── 📁 Reminder/
│  │  │  ├── 📁 Data/
│  │  │  │  └── 📁 modals/
│  │  │  │      └── 📄 plantevent_model.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Pages/
│  │  │      │  └── 📄 reminder_screen.dart
│  │  │      └── 📁 Widgets/
│  │  │          ├── 📄 timeline.dart
│  │  │          ├── 📄 day_button.dart
│  │  │          └── 📄 event_card.dart
│  │  ├── 📁 Auth/
│  │  │  ├── 📁 Data/
│  │  │  │  ├── 📁 DataSource/
│  │  │  │  │  └── 📄 authservice.dart
│  │  │  │  └── 📁 Models/
│  │  │  │      └── 📄 usermodel.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 bloc/
│  │  │      │  ├── 📄 auth_event.dart
│  │  │      │  ├── 📄 auth_state.dart
│  │  │      │  └── 📄 auth_bloc.dart
│  │  │      ├── 📁 Pages/
│  │  │      │  ├── 📄 onboarding_page.dart
│  │  │      │  ├── 📄 login_signup_page.dart
│  │  │      │  ├── 📄 auth_page.dart
│  │  │      │  └── 📄 forgot_password_screen.dart
│  │  │      └── 📁 Widgets/
│  │  │          ├── 📄 auth_page_illustration.dart
│  │  │          └── 📄 signboard.dart
│  │  ├── 📁 Weather/
│  │  │  ├── 📁 Data/
│  │  │  │  ├── 📁 Datasource/
│  │  │  │  │  └── 📄 data.dart
│  │  │  │  └── 📁 Modals/
│  │  │  │      └── 📄 weather_data.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Pages/
│  │  │      │  └── 📄 weather_page.dart
│  │  │      └── 📁 Widgets/
│  │  │          ├── 📄 frosted_glass.dart
│  │  │          ├── 📄 weather_details.dart
│  │  │          ├── 📄 loader.dart
│  │  │          ├── 📄 days_today.dart
│  │  │          ├── 📄 frosted_glass_current.dart
│  │  │          ├── 📄 hourly_weather.dart
│  │  │          ├── 📄 other_temps.dart
│  │  │          ├── 📄 tabs.dart
│  │  │          ├── 📄 day.dart
│  │  │          ├── 📄 daily_summary.dart
│  │  │          ├── 📄 weather_detail_current.dart
│  │  │          ├── 📄 rise_set_timings.dart
│  │  │          └── 📄 weather_detail_widget.dart
│  │  ├── 📁 AI chat interaction/
│  │  │  ├── 📁 Data/
│  │  │  │  └── 📁 models/
│  │  │  │      └── 📄 message_model.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Pages/
│  │  │      │  └── 📄 chat_view.dart
│  │  │      └── 📁 Widgets/
│  │  │          └── 📄 message_bubble.dart
│  │  ├── 📁 Home/
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Pages/
│  │  │      │  ├── 📄 blank.dart
│  │  │      │  ├── 📄 homepage.dart
│  │  │      │  ├── 📄 responsive_homepage.dart
│  │  │      │  └── 📄 series_of_pages.dart
│  │  │      └── 📁 Widgets/
│  │  │          ├── 📄 profile_img_stack.dart
│  │  │          ├── 📄 do_you_know.dart
│  │  │          ├── 📄 square_card_button.dart
│  │  │          ├── 📄 app_drawer.dart
│  │  │          ├── 📄 coachmarkaer.dart
│  │  │          └── 📄 bottom_bar.dart
│  │  ├── 📁 Community/
│  │  │  ├── 📁 Data/
│  │  │  │  └── 📁 Models/
│  │  │  │      └── 📄 post_model.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Pages/
│  │  │      │  └── 📄 community_screen.dart
│  │  │      └── 📁 Widgets/
│  │  │          └── 📄 post_container.dart
│  │  ├── 📁 Languages/
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Pages/
│  │  │      │  └── 📄 language_selection_page.dart
│  │  │      └── 📁 Widgets/
│  │  │          └── 📄 lang_search_page.dart
│  │  ├── 📁 Plant info panel/
│  │  │  ├── 📁 Data/
│  │  │  │  └── 📁 modals/
│  │  │  └── 📁 Presentations/
│  │  │      └── 📁 Pages/
│  │  │          ├── 📄 plants_info_detailview.dart
│  │  │          └── 📄 plant_info_listview.dart
│  │  ├── 📁 Garden/
│  │  │  ├── 📁 Data/
│  │  │  │  └── 📁 modala/
│  │  │  │      └── 📄 garden_plants.dart
│  │  │  └── 📁 Presentation/
│  │  │      └── 📁 Pages/
│  │  │          ├── 📄 gaeden_plant_detail_page.dart
│  │  │          └── 📄 garden_page.dart
│  │  ├── 📁 Search/
│  │  │  └── 📁 Presentations/
│  │  │      ├── 📁 Pages/
│  │  │      │  └── 📄 search_page_mobile.dart
│  │  │      └── 📁 Widgets/
│  │  │          └── 📄 search_chips.dart
│  │  ├── 📁 Camera/
│  │  │  ├── 📁 Data/
│  │  │  │  ├── 📁 DataSource/
│  │  │  │  │  ├── 📄 database.dart
│  │  │  │  │  ├── 📄 plant_analysis.dart
│  │  │  │  │  └── 📄 plantstroage.dart
│  │  │  │  └── 📁 modals/
│  │  │  │      └── 📄 plantdatamodal.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Pages/
│  │  │      │  └── 📄 camera_page.dart
│  │  │      └── 📁 Widgets/
│  │  │          ├── 📄 analysis_view.dart
│  │  │          └── 📄 analysis_info_dialog.dart
│  │  ├── 📁 Profile/
│  │  │  ├── 📁 Data/
│  │  │  │  └── 📁 Modals/
│  │  │  │      └── 📄 user_profile_model.dart
│  │  │  └── 📁 Presentation/
│  │  │      ├── 📁 Pages/
│  │  │      │  └── 📄 profile_page.dart
│  │  │      └── 📁 Widgets/
│  │  │          └── 📄 shapes_widgets.dart
│  │  └── 📁 Carbon Reward/
│  │      ├── 📁 Data/
│  │      │  └── 📁  modals/
│  │      │      └── 📄 sustainanble_practice_modal.dart
│  │      └── 📁 Presentation/
│  │          └── 📁 Pages/
│  │              └── 📄 carbon_reward_view.dart
│  ├── 📁 Core/
│  │  ├── 📁 Constants/
│  │  │  └── 📄 appconstants.dart
│  │  └── 📁 Get_it/
│  │      └── 📄 get_it.dart
│  ├── 📄 main.dart
│  └── 📁 l10n/
│      └── 📄 l10n.dart

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