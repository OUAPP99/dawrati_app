import 'app_localizations.dart';

/// Cycle phase and fertility-chance values are kept as stable English keys
/// internally (used for comparisons/colors) and only translated at display
/// time via these helpers.
String translatePhase(AppLocalizations t, String phase) {
  switch (phase) {
    case 'Menstruation':
      return t.phaseMenstruation;
    case 'Follicular':
    case 'Follicular Phase':
      return t.phaseFollicular;
    case 'Ovulation':
      return t.phaseOvulation;
    case 'Luteal':
    case 'Luteal Phase':
      return t.phaseLuteal;
    default:
      return phase;
  }
}

/// Mood values are stored as "`emoji` `EnglishKey`" (e.g. "😊 Good").
/// Only the key portion is translated for display.
String translateMoodString(AppLocalizations t, String mood) {
  final spaceIndex = mood.indexOf(' ');
  if (spaceIndex == -1) return mood;

  final emoji = mood.substring(0, spaceIndex);
  final key = mood.substring(spaceIndex + 1);

  final label = switch (key) {
    'Amazing' => t.moodAmazing,
    'Good' => t.moodGood,
    'Okay' => t.moodOkay,
    'Sad' => t.moodSad,
    'Awful' => t.moodAwful,
    _ => key,
  };

  return '$emoji $label';
}

/// Maps a stored mood value ("emoji Key") to a 1-5 score for charting.
int moodScore(String mood) {
  final spaceIndex = mood.indexOf(' ');
  final key = spaceIndex == -1 ? mood : mood.substring(spaceIndex + 1);

  return switch (key) {
    'Awful' => 1,
    'Sad' => 2,
    'Okay' => 3,
    'Good' => 4,
    'Amazing' => 5,
    _ => 3,
  };
}

const List<String> moodScoreEmojis = ["😭", "😔", "😐", "😊", "😍"];

String translateFertilityChance(AppLocalizations t, String chance) {
  switch (chance) {
    case 'Peak':
      return t.fertilityPeak;
    case 'High':
      return t.fertilityHigh;
    case 'Medium':
      return t.fertilityMedium;
    case 'Low':
      return t.fertilityLow;
    default:
      return chance;
  }
}
