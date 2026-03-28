import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../design_system/pharma_design_system.dart';

/// Debounced server search: multi-select employees (trainer flows).
class EmployeeMultiSelectDbSearchDialog extends StatefulWidget {
  const EmployeeMultiSelectDbSearchDialog({
    super.key,
    required this.initialSelection,
    required this.load,
  });

  final List<PharmaUser> initialSelection;
  final Future<List<PharmaUser>> Function(String query) load;

  @override
  State<EmployeeMultiSelectDbSearchDialog> createState() =>
      _EmployeeMultiSelectDbSearchDialogState();
}

class _EmployeeMultiSelectDbSearchDialogState
    extends State<EmployeeMultiSelectDbSearchDialog> {
  final TextEditingController _searchCtrl = TextEditingController();
  Timer? _debounce;
  final Set<int> _selectedIds = {};
  final Map<int, PharmaUser> _usersById = {};
  List<PharmaUser> _rows = [];
  bool _loading = true;
  String? _emptyMessage;

  @override
  void initState() {
    super.initState();
    for (final u in widget.initialSelection) {
      if (u.id != null) {
        _selectedIds.add(u.id!);
        _usersById[u.id!] = u;
      }
    }
    _runSearch('');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _runSearch(String q) async {
    setState(() {
      _loading = true;
      _emptyMessage = null;
    });
    try {
      final list = await widget.load(q);
      if (!mounted) return;
      setState(() {
        _rows = list;
        for (final u in list) {
          if (u.id != null) _usersById[u.id!] = u;
        }
        _loading = false;
        if (list.isEmpty) {
          _emptyMessage = q.trim().isEmpty
              ? 'No enrolled learners yet for your published courses.'
              : 'No employees match your search.';
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _rows = [];
          _emptyMessage = 'Could not load employees: $e';
        });
      }
    }
  }

  void _scheduleSearch(String v) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () => _runSearch(v));
  }

  void _toggle(PharmaUser u) {
    final id = u.id;
    if (id == null) return;
    setState(() {
      _usersById[id] = u;
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  List<PharmaUser> _orderedSelection() {
    final out =
        _selectedIds.map((id) => _usersById[id]).whereType<PharmaUser>().toList();
    out.sort(
      (a, b) =>
          '${a.firstName} ${a.lastName}'.compareTo('${b.firstName} ${b.lastName}'),
    );
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final selected = _orderedSelection();
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PharmaRadius.xl),
      ),
      title: const Text('Select Employees'),
      content: SizedBox(
        width: 480,
        height: 460,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchCtrl,
              autofocus: true,
              onChanged: _scheduleSearch,
              decoration: InputDecoration(
                hintText: 'Search name, email, employee ID…',
                prefixIcon: const Icon(Icons.search, size: 18),
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                  borderRadius: PharmaRadius.inputRadius,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            if (selected.isNotEmpty) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Selected (${selected.length})',
                  style:
                      PharmaTypography.caption.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 72,
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: selected.map((u) {
                      return InputChip(
                        label: Text(
                          '${u.firstName} ${u.lastName}',
                          style: PharmaTypography.caption,
                        ),
                        onDeleted: () => setState(() {
                          if (u.id != null) _selectedIds.remove(u.id!);
                        }),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    }).toList(),
                  ),
                ),
              ),
              const Divider(height: 16),
            ],
            Text(
              'Results',
              style:
                  PharmaTypography.caption.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            if (_loading)
              const Expanded(
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              )
            else if (_emptyMessage != null)
              Expanded(
                child: Center(
                  child: Text(
                    _emptyMessage!,
                    textAlign: TextAlign.center,
                    style: PharmaTypography.body.copyWith(
                      color: PharmaColors.textTertiary,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _rows.length,
                  itemBuilder: (ctx, i) {
                    final u = _rows[i];
                    final id = u.id;
                    final checked = id != null && _selectedIds.contains(id);
                    return CheckboxListTile(
                      value: checked,
                      onChanged: id == null ? null : (_) => _toggle(u),
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      title: Text(
                        '${u.firstName} ${u.lastName}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        u.email,
                        style: PharmaTypography.caption,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _selectedIds.isEmpty
              ? null
              : () => Navigator.pop(context, _orderedSelection()),
          child: const Text('Done'),
        ),
      ],
    );
  }
}
