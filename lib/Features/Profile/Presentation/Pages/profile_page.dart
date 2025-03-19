import 'package:flutter/material.dart';

import '../../Data/Modals/user_profile_model.dart';

class FarmerProfilePage extends StatefulWidget {
  const FarmerProfilePage({super.key});

  @override
  State<FarmerProfilePage> createState() => _FarmerProfilePageState();
}

class _FarmerProfilePageState extends State<FarmerProfilePage> {
 
  

  // Initial user profile data
  late UserProfile _userProfile;

  // Profile editing state
  bool _isEditing = false;

  // Form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _landSizeController = TextEditingController();
  final _primaryCropController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    _userProfile = UserProfile(
      name: 'Rajesh Kumar',
      email: 'rajesh.farmer@example.com',
      phone: '+91 9876543210',
      landSize: '5 Acres',
      primaryCrop: 'Rice',
      location: 'Punjab, India',
      farmingExperience: [
        'Rice Cultivation',
        'Organic Farming',
        'Precision Agriculture'
      ],
    );

    // Initialize controllers with current profile data
    _nameController.text = _userProfile.name;
    _emailController.text = _userProfile.email;
    _phoneController.text = _userProfile.phone;
    _landSizeController.text = _userProfile.landSize;
    _primaryCropController.text = _userProfile.primaryCrop;
    _locationController.text = _userProfile.location;
  }

  // Profile Picture Picker
  void _pickProfilePicture() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take Photo'),
                onTap: () {
                  // TODO: Implement camera capture
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  // TODO: Implement gallery selection
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Save Profile Method
  void _saveProfile() {
    setState(() {
      _userProfile = UserProfile(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        landSize: _landSizeController.text,
        primaryCrop: _primaryCropController.text,
        location: _locationController.text,
        farmingExperience: _userProfile.farmingExperience,
      );
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Farmer Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveProfile : () {
              setState(() {
                _isEditing = true;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(16),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Row(
                children: [
                  // Profile Picture
                  GestureDetector(
                    onTap: _pickProfilePicture,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _isEditing
                          ? TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                border: OutlineInputBorder(),
                              ),
                            )
                          : Text(
                              _userProfile.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                        SizedBox(height: 8),
                        _isEditing
                          ? TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                            )
                          : Text(
                              _userProfile.email,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Profile Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Phone Number
                  _buildProfileField(
                    context, 
                    label: 'Phone Number', 
                    value: _userProfile.phone,
                    controller: _phoneController,
                    isEditing: _isEditing,
                    icon: Icons.phone,
                  ),

                  // Land Size
                  _buildProfileField(
                    context, 
                    label: 'Land Size', 
                    value: _userProfile.landSize,
                    controller: _landSizeController,
                    isEditing: _isEditing,
                    icon: Icons.landscape,
                  ),

                  // Primary Crop
                  _buildProfileField(
                    context, 
                    label: 'Primary Crop', 
                    value: _userProfile.primaryCrop,
                    controller: _primaryCropController,
                    isEditing: _isEditing,
                    icon: Icons.agriculture,
                  ),

                  // Location
                  _buildProfileField(
                    context, 
                    label: 'Location', 
                    value: _userProfile.location,
                    controller: _locationController,
                    isEditing: _isEditing,
                    icon: Icons.location_on,
                  ),

                  // Farming Experience
                  SizedBox(height: 16),
                  Text(
                    'Farming Experience',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _userProfile.farmingExperience
                      .map((experience) => Chip(
                        label: Text(experience),
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      ))
                      .toList(),
                  ),

                  // Additional Actions
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement add experience functionality
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Farming Experience'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable profile field builder
  Widget _buildProfileField(
    BuildContext context, {
    required String label,
    required String value,
    required TextEditingController controller,
    required bool isEditing,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          SizedBox(width: 16),
          Expanded(
            child: isEditing
              ? TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: label,
                    border: OutlineInputBorder(),
                  ),
                )
              : Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
          ),
        ],
      ),
    );
  }
}
