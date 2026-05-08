import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../app_theme.dart';
import '../data/photos_repository.dart';
import '../models/event_photo.dart';
import '../providers/locale_provider.dart';

class PhotoGallery extends ConsumerWidget {
  const PhotoGallery({super.key, required this.eventId});
  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);
    final photosAsync = ref.watch(photosProvider(eventId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.photo_library, color: AppTheme.pink),
                const SizedBox(width: 8),
                Text(
                  l.photos,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.pinkDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_a_photo, color: AppTheme.pink),
                  onPressed: () => _showSourcePicker(context, ref, l.takePhoto, l.fromGallery),
                ),
              ],
            ),
            photosAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const SizedBox.shrink(),
              data: (photos) {
                if (photos.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        l.noPhotos,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, i) => _PhotoTile(
                    photo: photos[i],
                    onDelete: () => _deletePhoto(context, ref, photos[i], l.deletePhoto),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSourcePicker(
    BuildContext context,
    WidgetRef ref,
    String takePhoto,
    String fromGallery,
  ) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(takePhoto),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(fromGallery),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: source, imageQuality: 85);
    if (file == null) return;

    final savedPath = await _saveToDocuments(file);
    final repo = ref.read(photosRepositoryProvider);
    await repo.insert(EventPhoto(
      eventId: eventId,
      filePath: savedPath,
      takenAt: DateTime.now(),
    ));
    ref.invalidate(photosProvider(eventId));
  }

  Future<String> _saveToDocuments(XFile file) async {
    final dir = await getApplicationDocumentsDirectory();
    final name = '${DateTime.now().millisecondsSinceEpoch}_${p.basename(file.path)}';
    final dest = '${dir.path}/$name';
    await File(file.path).copy(dest);
    return dest;
  }

  Future<void> _deletePhoto(
    BuildContext context,
    WidgetRef ref,
    EventPhoto photo,
    String label,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(label),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('OK', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final repo = ref.read(photosRepositoryProvider);
    await repo.delete(photo.id!);
    final file = File(photo.filePath);
    if (await file.exists()) await file.delete();
    ref.invalidate(photosProvider(eventId));
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.photo, required this.onDelete});
  final EventPhoto photo;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFullScreen(context),
      onLongPress: onDelete,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.file(
          File(photo.filePath),
          fit: BoxFit.cover,
          errorBuilder: (_, e, s) =>
              const ColoredBox(color: Color(0xFFEEEEEE), child: Icon(Icons.broken_image)),
        ),
      ),
    );
  }

  void _showFullScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: InteractiveViewer(
              child: Image.file(File(photo.filePath)),
            ),
          ),
        ),
      ),
    );
  }
}
