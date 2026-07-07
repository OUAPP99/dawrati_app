class PhaseAiMessage {
  static String getMessage(String phase) {
    if (phase == "Menstruation") {
      return "Your body may need more rest today. Hydration and light movement can help you feel better.";
    }

    if (phase == "Follicular Phase") {
      return "Your energy may start rising. This can be a good time for planning, movement and productivity.";
    }

    if (phase == "Ovulation") {
      return "Ovulation is near. You may feel more energetic and social today.";
    }

    return "You may feel more sensitive during this phase. Try to prioritize sleep, hydration and calm routines.";
  }
}