import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets/features/features.dart';
import 'package:planets/i18n/translations.g.dart';

class SearchPlanet extends ConsumerWidget {
  const SearchPlanet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        decoration: InputDecoration(hintText: context.texts.planets.searchHint),
        onChanged: (value) => ref.read(queryNotifier.notifier).state = value,
      ),
    );
  }
}
