import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Gemini gemini = Gemini.instance;
  final TextEditingController _promptController = TextEditingController();
  String? result;
  File? selectedImage;
  bool isLoading = false;
  bool withImage = false;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Study-Buddy",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue[50]!,
              Colors.lightBlue[100]!,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (result != null || isLoading)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.lightBlue,
                                  ),
                                )
                              : SelectableText(
                                  result!,
                                  style: const TextStyle(fontSize: 16),
                                ),
                        ),
                      const SizedBox(height: 20),
                      // Image preview area
                      if (selectedImage != null)
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: FileImage(selectedImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedImage = null;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              // Bottom input area
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Camera button
                        IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.lightBlue),
                          onPressed: () => _getImage(ImageSource.camera),
                        ),
                        // Gallery button
                        IconButton(
                          icon: const Icon(Icons.photo, color: Colors.lightBlue),
                          onPressed: () => _getImage(ImageSource.gallery),
                        ),
                        // Text input field
                        Expanded(
                          child: TextField(
                            controller: _promptController,
                            decoration: const InputDecoration(
                              hintText: "Ask me anything related to Skin...",
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                          ),
                        ),
                        // Send button
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.lightBlue),
                          onPressed: _sendPrompt,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source, 
      imageQuality: 70
    );
    
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void _sendPrompt() async {
    final promptText = _promptController.text.trim();
    if (promptText.isEmpty) return;

    setState(() {
      isLoading = true;
      result = null;
    });

    try {
      if (selectedImage != null) {
        final imageBytes = await selectedImage!.readAsBytes();
        final response = await gemini.textAndImage(
          text: promptText,
          images: [imageBytes],
        );
        setState(() {
          result = response?.output ?? "No response received";
          isLoading = false;
        });
      } else {
        final response = await gemini.text(promptText);
        setState(() {
          result = response?.output ?? "No response received";
          isLoading = false;
        });
      }
      
      _promptController.clear();
    } catch (e) {
      setState(() {
        result = "Error: ${e.toString()}";
        isLoading = false;
      });
    }
  }
}
