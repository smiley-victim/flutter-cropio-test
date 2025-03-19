import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Features/Camera/Data/DataSource/plant_analysis.dart';
import 'package:myapp/Features/Camera/Presentation/Widgets/analysis_info_dialog.dart';
import 'package:myapp/Features/Camera/Presentation/Widgets/analysis_view.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final plantAnalysis = PlantAnalysisWithGemini();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    plantAnalysis.initializeAI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.awesome(
        onMediaCaptureEvent: (event) {
          switch ((event.status, event.isPicture, event.isVideo)) {
            case (MediaCaptureStatus.capturing, true, false):
              debugPrint('Capturing picture...');
            case (MediaCaptureStatus.success, true, false):
              event.captureRequest.when(
                single: (single) async {
                  debugPrint('Picture saved: ${single.file?.path}');
                  try {
                    if (event.isPicture) {
                      setState(() => isLoading = true);
                      final response = await plantAnalysis
                          .plantAnalysisV2(single.file!.readAsBytes());

                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          backgroundColor: Colors.white,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.75),
                            child: PlantAnalysisResultView(
                                response: response, image: single.file!.path),
                          ),
                        ),
                      );
                      setState(() => isLoading = false);
                    }
                  } on Exception catch (e) {
                    setState(() => isLoading = false);
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: Text('An error occurred: $e'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    debugPrint('error $e');
                  }
                },
              );
            case (MediaCaptureStatus.failure, true, false):
              debugPrint('Failed to capture picture: ${event.exception}');
            default:
              debugPrint('Unknown event: $event');
          }
        },

        saveConfig: SaveConfig.photo(),
        theme: AwesomeTheme(
          bottomActionsBackgroundColor: Colors.white,
          buttonTheme: AwesomeButtonTheme(
            backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
            iconSize: 26,
            foregroundColor: const Color.fromARGB(255, 210, 100, 67),
            padding: const EdgeInsets.all(16),
            // Tap visual feedback (ripple, bounce...)
            buttonBuilder: (child, onTap) {
              return ClipOval(
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    splashColor: const Color.fromARGB(255, 251, 178, 156),
                    highlightColor: const Color.fromARGB(255, 207, 60, 15),
                    onTap: onTap,
                    child: child,
                  ),
                ),
              );
            },
          ),
        ),
        // Show the filter button on the top part of the screen
        topActionsBuilder: (state) => AwesomeTopActions(
          padding: EdgeInsets.zero,
          state: state,
          children: [
            IconButton.filledTonal(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 255, 254, 253)),
                ),
                onPressed: () => Navigator.pop(context, true),
                icon: Row(
                  children: [Icon(Icons.arrow_back_ios), Text('Back')],
                )),
            AnalysisInfoDialog()
          ],
        ),
        // Show some Text with same background as the bottom part
        middleContentBuilder: (state) {
          return Stack(
            children: [
              Column(
                children: [
                  const Spacer(),
                  // Use a Builder to get a BuildContext below AwesomeThemeProvider widget
                  Builder(builder: (context) {
                    return Container(
                      // Retrieve your AwesomeTheme's background color
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: Text(
                            "Take your best shot! for the AI",
                            style: TextStyle(
                              color: Color.fromARGB(255, 13, 48, 15),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              if (isLoading)
                const Center(
                    child: CircularProgressIndicator(
                  strokeCap: StrokeCap.square,
                  strokeWidth: 3,
                  color: Colors.white,
                )),
            ],
          );
        },
        // Show Flash button on the left and Camera switch button on the right
        bottomActionsBuilder: (state) => AwesomeBottomActions(
            padding: EdgeInsets.only(bottom: 25),
            state: state,
            left: AwesomeFlashButton(
              state: state,
            ),
            right: AwesomeCameraSwitchButton(
              state: state,
              scale: 1.0,
              onSwitchTap: (state) {
                state.switchCameraSensor(
                  aspectRatio: state.sensorConfig.aspectRatio,
                );
              },
            ),
            captureButton: _getCaptureButton(state)),
      ),
    );
  }
}

Widget? _getCaptureButton(CameraState state) {
  return state.when(
    onPhotoMode: (state) =>
        getCustomCaptureButton(state, CaptureMode.photo, false),
    onVideoMode: (state) =>
        getCustomCaptureButton(state, CaptureMode.video, false),
    onVideoRecordingMode: (state) =>
        getCustomCaptureButton(state, CaptureMode.video, true),
  );
}

Widget getCustomCaptureButton(
  CameraState state,
  CaptureMode captureMode,
  bool isRecording,
) {
  return Material(
    shape: const CircleBorder(),
    color: const Color.fromARGB(255, 128, 193, 52), // Light green background
    child: InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => _handleOnPress(state, captureMode, isRecording),
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        child: FittedBox(
            fit: BoxFit.contain,
            child: captureMode == CaptureMode.photo
                ? const Icon(Icons.lens,
                    color: Color.fromARGB(255, 25, 101, 28), size: 60)
                : SizedBox.shrink()),
      ),
    ),
  );
}

void _handleOnPress(
    CameraState state, CaptureMode captureMode, bool isRecording) {
  // Example logic placeholder:
  if (captureMode == CaptureMode.photo) {
    debugPrint("Photo capture initiated");
    state.when(
      onPhotoMode: (state) => state.takePhoto(),
    );
    // Call your method to capture a photo. For example:
  } else {
    if (isRecording) {
      debugPrint("Stopping video recording");
      // Call your method to stop recording.
      // state.stopVideoRecording();
    } else {
      debugPrint("Starting video recording");
      // Call your method to start video recording.
      // state.startVideoRecording();
    }
  }
}
