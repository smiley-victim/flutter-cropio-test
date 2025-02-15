import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/foundation.dart';
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
                      final String response = await plantAnalysis
                          .plantAnalysisV2(single.file!.readAsBytes());
                      showModalBottomSheet(
                          constraints: BoxConstraints.loose(Size(
                              MediaQuery.sizeOf(context).width,
                              MediaQuery.sizeOf(context).height * 0.75)),
                          showDragHandle: true,
                          // ignore: use_build_context_synchronously
                          context: context,
                          isScrollControlled: true,
                          backgroundColor:Colors.transparent,
                          builder: (context) =>
                              PlantAnalysisResultView(response: response));
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
          bottomActionsBackgroundColor:
              const Color.fromARGB(82, 255, 255, 255),
          // Theme.of(context).colorScheme.onPrimaryContainer,
          buttonTheme: AwesomeButtonTheme(
            // backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            iconSize: 26,
            foregroundColor: const Color.fromARGB(255, 207, 60, 15),
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
          children: [AnalysisInfoDialog()],
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
                        color: const Color.fromARGB(81, 255, 255, 255),
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
            captureButton: AwesomeCaptureButton(
              state: state,
            )),
      ),
    );
  }
}
