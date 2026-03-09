import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';

class EsignatureScreen extends StatefulWidget {
  const EsignatureScreen({
    super.key,
    required this.entityType,
    required this.entityId,
    this.signatureMeaning,
    this.userId,
  });

  final String entityType;
  final String entityId;
  final String? signatureMeaning;
  final int? userId;

  @override
  State<EsignatureScreen> createState() => _EsignatureScreenState();
}

class _EsignatureScreenState extends State<EsignatureScreen> {
  final _passwordController = TextEditingController();
  bool _signing = false;
  String? _error;
  List<SignatureMeaning> _meanings = [];
  String? _selectedMeaning;
  bool _loadingMeanings = true;

  @override
  void initState() {
    super.initState();
    _loadMeanings();
  }

  Future<void> _loadMeanings() async {
    try {
      final meanings = await client.training.listSignatureMeanings();
      if (mounted) {
        setState(() {
          _meanings = meanings;
          if (meanings.isNotEmpty) {
            final preferred = widget.signatureMeaning;
            _selectedMeaning = (preferred != null &&
                    meanings.any((m) => m.meaning == preferred))
                ? preferred
                : meanings.first.meaning;
          } else {
            _selectedMeaning =
                widget.signatureMeaning ?? 'I have read and understood';
          }
          _loadingMeanings = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _selectedMeaning =
              widget.signatureMeaning ?? 'I have read and understood';
          _loadingMeanings = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  String? _hashPassword(String password) {
    if (password.isEmpty) return null;
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _sign() async {
    final userId = widget.userId;
    if (userId == null) {
      if (mounted) Navigator.of(context).pop<int?>(null);
      return;
    }

    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      setState(() => _error = 'Password is required for re-authentication.');
      return;
    }

    setState(() {
      _signing = true;
      _error = null;
    });

    final meaning = _selectedMeaning ?? 'I have read and understood';
    try {
      final passwordHash = _hashPassword(password);
      final esignatureId = await client.training.createTrainingSignature(
        userId: userId,
        signatureMeaning: meaning,
        entityType: widget.entityType,
        entityId: widget.entityId,
        passwordReauthHash: passwordHash,
      );
      if (mounted) {
        Navigator.of(context).pop<int>(esignatureId);
      }
    } catch (e) {
      setState(() {
        _signing = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electronic Signature'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_loadingMeanings)
                      const Center(
                          child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ))
                    else if (_meanings.isNotEmpty)
                      DropdownButtonFormField<String>(
                        value: _selectedMeaning,
                        decoration: const InputDecoration(
                          labelText: 'Signature Meaning',
                          border: OutlineInputBorder(),
                        ),
                        items: _meanings
                            .map((m) => DropdownMenuItem<String>(
                                  value: m.meaning,
                                  child: Text(m.meaning),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _selectedMeaning = v ?? _selectedMeaning),
                      )
                    else
                      Text(
                        _selectedMeaning ?? 'I have read and understood',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    const SizedBox(height: 8),
                    const Text(
                      '21 CFR Part 11 compliant. Password re-authentication required.',
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password (re-authentication required)',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _sign(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'By signing, you confirm your identity and intent.',
                      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: TextStyle(color: Colors.red[700]),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _signing ? null : _sign,
              child: _signing
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Sign'),
            ),
          ],
        ),
      ),
    );
  }
}
