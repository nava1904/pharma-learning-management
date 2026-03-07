import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' as pharma;
import 'package:serverpod_client/serverpod_client.dart';

import '../../core/client.dart';

/// Material upload: create material, get upload URL, upload file, verify.
class MaterialUploadScreen extends StatefulWidget {
  const MaterialUploadScreen({
    super.key,
    this.organizationId = 1,
  });

  final int organizationId;

  @override
  State<MaterialUploadScreen> createState() => _MaterialUploadScreenState();
}

class _MaterialUploadScreenState extends State<MaterialUploadScreen> {
  List<pharma.Material> _materials = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final materials = await client.material.listMaterials(
        organizationId: widget.organizationId,
      );
      setState(() {
        _materials = materials;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _addMaterial() async {
    final titleController = TextEditingController();
    final typeController = TextEditingController(text: 'pdf');

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Material'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                labelText: 'Type (pdf, video, scorm)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Create'),
          ),
        ],
      ),
    );

    if (ok != true || !mounted) return;

    try {
      final material = await client.material.createMaterial(
        title: titleController.text.trim().isEmpty ? 'Untitled' : titleController.text.trim(),
        materialType: typeController.text.trim().isEmpty ? 'pdf' : typeController.text.trim(),
        organizationId: widget.organizationId,
      );
      if (!mounted) return;
      await _uploadFile(material);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  Future<void> _uploadFile(pharma.Material material) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'mp4', 'webm'],
    );
    if (result == null || result.files.isEmpty || !mounted) return;

    final file = result.files.first;
    final bytes = file.bytes;
    if (bytes == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not read file bytes')),
        );
      }
      return;
    }

    final path = 'materials/${material.id}/v1.${file.extension ?? "bin"}';
    try {
      final desc = await client.material.getUploadDescription(path);
      if (desc == null) throw Exception('No upload description');
      final uploader = FileUploader(desc);
      final success = await uploader.uploadByteData(
        ByteData.sublistView(bytes),
      );
      if (!success) throw Exception('Upload failed');
      await client.material.verifyUpload(path);
      await client.material.createMaterialVersion(
        materialId: material.id!,
        storageKey: path,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload complete')),
        );
        _load();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Materials'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _load,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      ElevatedButton.icon(
                        onPressed: _addMaterial,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Material'),
                      ),
                      const SizedBox(height: 16),
                      ..._materials.map((m) => Card(
                            child: ListTile(
                              title: Text(m.title),
                              subtitle: Text('${m.materialType} ${m.storageKey ?? "(no file)"}'),
                              trailing: m.storageKey == null
                                  ? TextButton(
                                      onPressed: () => _uploadFile(m),
                                      child: const Text('Upload'),
                                    )
                                  : null,
                            ),
                          )),
                    ],
                  ),
                ),
    );
  }
}
