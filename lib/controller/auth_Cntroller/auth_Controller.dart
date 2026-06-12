import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../model/user_creat_Model/user_creat_model.dart';
import '../../view/screens/bottomNavigationBar/bottomNavgationBar.dart';
import '../../view/utils/app_Snakbar/ap_Snackbar.dart';

class AuthController extends GetxController {
  final supabase = Supabase.instance.client;
  final _picker = ImagePicker();

  var isLoading = false.obs;
  var isImageLoading = false.obs;
  var currentUser = Rxn<UserModel>();
  var selectedImage = Rxn<File>(); // picked image preview

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUser();
  }

  // ── Load logged-in user ───────────────────────────────────────────────────
  Future<void> _loadCurrentUser() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;
    try {
      final data = await supabase
          .from('users')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();
      if (data != null) currentUser.value = UserModel.fromMap(data);
    } catch (e) {
      print("Load user error: $e");
    }
  }

  // ── Pick image (camera or gallery) ───────────────────────────────────────
  Future<void> pickImage({bool fromCamera = false}) async {
    try {
      final picked = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 600,
      );
      if (picked != null) {
        selectedImage.value = File(picked.path);
      }
    } catch (e) {
      AppSnackbar.error("Could not pick image. Please try again.");
    }
  }

  // ── Upload image to Supabase storage ─────────────────────────────────────
  Future<String?> _uploadProfileImage(String userId, File imageFile) async {
    try {
      isImageLoading.value = true;
      final ext = imageFile.path.split('.').last;
      final path = '$userId/profile.$ext';

      await supabase.storage
          .from('userprofile')
          .upload(
            path,
            imageFile,
            fileOptions: const FileOptions(upsert: true),
          );

      final url = supabase.storage.from('userprofile').getPublicUrl(path);
      return url;
    } catch (e) {
      AppSnackbar.error("Image upload failed: ${e.toString()}");
      return null;
    } finally {
      isImageLoading.value = false;
    }
  }

  // ── Show image source picker dialog ──────────────────────────────────────
  void showImagePickerDialog() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Select Profile Photo",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _imageSourceOption(
                  icon: Icons.camera_alt_rounded,
                  label: "Camera",
                  onTap: () {
                    Get.back();
                    pickImage(fromCamera: true);
                  },
                ),
                _imageSourceOption(
                  icon: Icons.photo_library_rounded,
                  label: "Gallery",
                  onTap: () {
                    Get.back();
                    pickImage(fromCamera: false);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _imageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0).withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: const Color(0xFF1565C0)),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // ── REGISTER ──────────────────────────────────────────────────────────────
  Future<void> register({
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      // 1. Auth signup
      final response = await supabase.auth.signUp(
        email: email.trim(),
        password: password.trim(),
        data: {'username': username.trim()},
      );

      final user = response.user;
      if (user == null) {
        AppSnackbar.error("Registration failed. Please try again.");
        return;
      }

      // 2. Upload image if selected
      String? imageUrl;
      if (selectedImage.value != null) {
        imageUrl = await _uploadProfileImage(user.id, selectedImage.value!);
      }

      // 3. Save to users table
      await supabase.from('users').insert({
        'user_id': user.id,
        'username': username.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'profile_image': imageUrl,
      });

      // 4. Update local state
      currentUser.value = UserModel(
        id: '',
        userId: user.id,
        username: username.trim(),
        email: email.trim(),
        phone: phone.trim(),
        profileImage: imageUrl,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );

      selectedImage.value = null;

      AppSnackbar.success("Account created successfully!", title: "Welcome!");
      Get.offAll(() => const MainScreen());
    } catch (e) {
      AppSnackbar.error(e.toString(), title: "Registration Failed");
    } finally {
      isLoading.value = false;
    }
  }

  // ── LOGIN ─────────────────────────────────────────────────────────────────
  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _loadCurrentUser();
      AppSnackbar.success("Logged in successfully.", title: "Welcome back!");
      Get.offAll(() => const MainScreen());
    } catch (e) {
      AppSnackbar.error(e.toString(), title: "Login Failed");
    } finally {
      isLoading.value = false;
    }
  }

  // ── LOGOUT ────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
      currentUser.value = null;
      selectedImage.value = null;
      Get.offAllNamed('/login');
    } catch (e) {
      AppSnackbar.error("Logout failed. Please try again.");
    }
  }
}
