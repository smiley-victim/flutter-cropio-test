// User Profile Data Model
class UserProfile {
  String name;
  String email;
  String phone;
  String landSize;
  String primaryCrop;
  String location;
  List<String> farmingExperience;

  UserProfile({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.landSize = '',
    this.primaryCrop = '',
    this.location = '',
    this.farmingExperience = const [],
  });
}
