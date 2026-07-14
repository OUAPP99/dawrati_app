/// Turns the stable onboarding-answer keys stored on [AppStateProvider]
/// into short English phrases for AI system prompts. Always English,
/// regardless of the app's display language — the model is separately
/// told which language to reply in.
String? goalContext(String? goal) {
  return switch (goal) {
    'trackCycle' => "Her goal is simply to track her cycle.",
    'getPregnant' => "Her goal is to get pregnant — keep this in mind and be encouraging.",
    'avoidPregnancy' => "Her goal is to avoid pregnancy — be mindful of this when discussing fertility.",
    'understandHealth' => "Her goal is to better understand her overall health.",
    _ => null,
  };
}

String? contraceptionContext(String? method) {
  return switch (method) {
    'pill' => "She uses the birth control pill.",
    'iud' => "She uses an IUD.",
    'implant' => "She uses a contraceptive implant.",
    'other' => "She uses another form of contraception.",
    _ => null,
  };
}
