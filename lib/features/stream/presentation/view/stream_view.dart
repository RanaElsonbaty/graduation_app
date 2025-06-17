import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/features/stream/presentation/view/widgets/youtube_video.dart';
import 'package:graduation/features/stream/presentation/view_model/cubit/stream_cubit.dart';
import 'package:graduation/features/stream/presentation/view_model/cubit/stream_state.dart';
import 'package:url_launcher/url_launcher.dart';

class StreamScreen extends StatelessWidget {
  final String fileId;

  const StreamScreen({super.key, required this.fileId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StreamCubit()..getVideoStream(fileId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Lecture Viewer"),
          backgroundColor: AppColors.primary,
        ),
        body: BlocBuilder<StreamCubit, StreamState>(
          builder: (context, state) {
            if (state is StreamLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StreamError) {
              return Center(child: Text(state.message));
            } else if (state is StreamEmpty) {
              return const Center(child: Text("No video available"));
            } else if (state is StreamSuccess) {
              final file = state.streamModel.file!;
              final videoStreamUrl = state.streamModel.videoStream;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: videoStreamUrl != null && videoStreamUrl.isNotEmpty
                            ? YoutubePlayerWidget(videoUrl: videoStreamUrl)
                            : const Center(child: Text("No stream available")),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _infoCard("Lecture Title", file.fileName ),
                    _infoCard("Course", file.courseTitle ),
                    _infoCard("Lecture Number", file.numOfLec.toString() ),
                    _infoCard("Created At", file.createdAt.split('T').first ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: file.pdfUrl.isNotEmpty
                            ? () async {
                          final Uri url = Uri.parse(file.pdfUrl);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Could not launch PDF')),
                            );
                          }
                        }
                            : null,
                        icon: const Icon(Icons.picture_as_pdf,color: AppColors.primary,),
                        label:  Text("Open PDF", style: const TextStyle(color: AppColors.primary)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          disabledBackgroundColor: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      color: AppColors.secondary,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }
}