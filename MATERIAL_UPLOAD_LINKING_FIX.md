# Material Upload & Linking System - Complete Fix

## Summary
Fixed critical issues preventing materials from appearing after upload and improved the material linking flow in course builder.

---

## Issues Fixed

### Issue 1: Uploaded Materials Not Appearing in List
**File**: `material_upload_v2_screen.dart`

**Root Cause**:
- Materials were being created without `storageKey`
- MaterialVersion was created with the storageKey
- `_load()` filtered materials by `storageKey` field (which was null)
- After upload, materials were filtered out and not displayed

**Solution**:
1. **Removed premature filtering** - Changed `_load()` to show all materials instead of filtering by storageKey
   - The storageKey lives in MaterialVersion, not Material
   - Display materials regardless of Material.storageKey state
   
2. **Enhanced upload flow**:
   - Added 800ms delay after version creation to allow backend sync
   - Material will be fetched via MaterialVersion lookup when needed

**Code Change**:
```dart
Future<void> _load() async {
  // ... 
  final result = await client.material.listMaterials(organizationId: user!.organizationId);
  if (mounted) {
    setState(() {
      // Show all materials - version history will have the storage key
      _materials = result;
      _loading = false;
    });
  }
}
```

---

### Issue 2: Preview Action Failing for Materials Without Direct StorageKey
**File**: `material_upload_v2_screen.dart`

**Root Cause**:
- Material object doesn't always have storageKey populated
- Code tried to preview using Material.storageKey directly
- Failed silently or showed no preview available

**Solution**:
- **Enhanced _previewMaterial()** to fallback to MaterialVersion lookup:
  1. First tries Material.storageKey
  2. If not found, fetches MaterialVersions and uses the latest one
  3. Graceful error handling at each step
  4. Clear user-friendly messages

**Code Change**:
```dart
Future<void> _previewMaterial(LmsMaterial m) async {
  try {
    String? storageKey = m.storageKey;
    
    // If no storage key on material, try to get it from latest version
    if (storageKey == null || storageKey.isEmpty) {
      if (m.id == null) {
        // Show error
        return;
      }
      
      try {
        final versions = await client.material.getMaterialVersions(m.id!);
        if (versions.isEmpty) return;
        storageKey = versions.first.storageKey;
      } catch (e) {
        // Handle error
        return;
      }
    }

    if (storageKey.isEmpty) return;

    final url = await client.material.getMaterialViewUrl(storageKey);
    // Show preview dialog with URL
  } catch (e) {
    // Handle error
  }
}
```

---

### Issue 3: Link Material Button Not Working in Course Builder
**File**: `course_builder_v2_screen.dart`

**Root Cause**:
- Button was navigating to material upload screen but not linking anything
- No mechanism to capture which material was selected/uploaded
- No actual database update to link material to lesson

**Solution**:
- **Changed approach from navigation to dialog**:
  1. Shows a material selection dialog instead of navigation
  2. Fetches available materials from organization
  3. User selects material from list
  4. Calls `courseBuilder.updateLesson(materialId: selectedId)`
  5. Reloads lesson data
  6. Shows success message

- **Added _showMaterialSelectionDialog() method**:
  - Displays all available materials in organization
  - Allows selection via ListTile tap
  - Returns selected material ID
  - Handles "no materials" case gracefully

**Code Change**:
```dart
Future<void> _linkMaterialToLesson(Lesson? lesson) async {
  if (lesson?.id == null) return;
  
  // Show material selection dialog
  final selectedMaterialId = await _showMaterialSelectionDialog();
  
  if (selectedMaterialId != null && mounted) {
    try {
      // Update the lesson with the selected material
      await client.courseBuilder.updateLesson(
        lessonId: lesson!.id!,
        materialId: selectedMaterialId,
      );
      
      // Reload lesson data
      await _load();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Material linked to lesson successfully'),
            backgroundColor: PharmaColors.emerald600,
          ),
        );
      }
    } catch (e) {
      // Handle error
    }
  }
}

Future<int?> _showMaterialSelectionDialog() async {
  try {
    final materials = await client.material.listMaterials(
      organizationId: _course?.organizationId ?? 0,
    );
    
    if (!mounted || _course?.organizationId == null) return null;
    
    int? selectedId;
    await showDialog<int?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Material'),
        content: SizedBox(
          width: 400,
          height: 300,
          child: materials.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_off, size: 48, color: PharmaColors.gray300),
                      const SizedBox(height: 12),
                      const Text('No materials found'),
                      const SizedBox(height: 8),
                      const Text('Upload materials in the Materials section first'),
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: materials.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, i) {
                    final m = materials[i];
                    return ListTile(
                      onTap: () {
                        selectedId = m.id;
                        Navigator.pop(ctx);
                      },
                      leading: Icon(
                        m.materialType.toLowerCase() == 'pdf'
                            ? Icons.picture_as_pdf
                            : m.materialType.toLowerCase() == 'video'
                                ? Icons.videocam
                                : Icons.insert_drive_file,
                        color: PharmaColors.emerald600,
                      ),
                      title: Text(m.title),
                      subtitle: Text(m.materialType),
                      trailing: const Icon(Icons.chevron_right),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    return selectedId;
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading materials: $e')),
      );
    }
    return null;
  }
}
```

---

## Files Modified

1. **`material_upload_v2_screen.dart`**
   - ✅ Modified `_load()` - Removed filtering, show all materials
   - ✅ Enhanced `_previewMaterial()` - Added MaterialVersion fallback lookup
   - ✅ Fixed upload flow - Added 800ms delay for backend sync

2. **`course_builder_v2_screen.dart`**
   - ✅ Enhanced `_linkMaterialToLesson()` - Changed from navigation to dialog selection
   - ✅ Added `_showMaterialSelectionDialog()` - New method for material selection
   - ✅ Proper lesson update with `updateLesson(materialId:)`

---

## Workflow

### Uploading Materials:
1. User navigates to Materials section
2. User selects file and uploads
3. Material is created in database
4. MaterialVersion is created with storageKey
5. 800ms delay for sync
6. `_load()` refreshes the list
7. Material appears in the uploaded files list ✅

### Previewing Materials:
1. User clicks View button on material
2. System checks Material.storageKey first
3. If not available, fetches MaterialVersions
4. Gets storageKey from latest version
5. Calls getMaterialViewUrl
6. Shows preview dialog with URL ✅

### Linking Material to Lesson:
1. User in Course Builder selects lesson
2. User clicks "Link Material" button
3. Dialog shows all available materials
4. User selects a material
5. System calls `updateLesson(materialId:)`
6. Lesson data reloads
7. Shows success message ✅

---

## Testing Checklist

- [ ] **Upload Material**
  - [ ] Select PDF file and upload
  - [ ] Material appears in uploaded files list within 2 seconds
  - [ ] File type shows correctly (PDF, Video, etc)
  - [ ] Success message displays

- [ ] **Preview Material**
  - [ ] Click View button on material
  - [ ] Preview dialog shows with URL
  - [ ] Can copy URL to clipboard
  - [ ] Dialog closes properly

- [ ] **Link Material to Lesson**
  - [ ] In Course Builder, select a lesson
  - [ ] Click "Link Material" button
  - [ ] Dialog shows all available materials
  - [ ] Select a material from the list
  - [ ] Dialog closes
  - [ ] Lesson data reloads
  - [ ] Success message displays
  - [ ] Material is now linked to lesson

- [ ] **Error Cases**
  - [ ] No materials uploaded → Shows helpful message
  - [ ] Material upload fails → Clear error message
  - [ ] Preview fails → Graceful error handling
  - [ ] Network error → Proper error notification

---

## Technical Details

### Material vs MaterialVersion
- **Material**: The main entity with title, type, organizationId
- **MaterialVersion**: The actual file with storageKey, fileHash, size
- A Material can have multiple versions (file updates)
- Latest version's storageKey is what we use for preview/access

### UpdateLesson Parameters
```dart
await client.courseBuilder.updateLesson(
  lessonId: int,
  title: String?, 
  durationMinutes: int?,
  materialId: int?,  // ← Links material to lesson
)
```

### Material List Filtering
- **Before**: Filtered by Material.storageKey (incorrect, always null)
- **After**: Shows all materials, lookups use MaterialVersion for actual file reference
- **Benefit**: Separated concerns - Material entity from file storage

---

## Build Status

✅ **No compilation errors**  
✅ **All imports resolved**  
✅ **Type safety maintained**  
✅ **Ready for testing**

---

**Date**: 21 March 2026  
**Status**: ✅ Complete  
**Testing**: Ready
