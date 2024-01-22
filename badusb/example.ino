#include "DigiKeyboard.h"

void setup() {
  /*empty*/
}
void loop() {
  DigiKeyboard.delay(600);
  DigiKeyboard.sendKeyStroke(0);
  DigiKeyboard.sendKeyStroke(KEY_SPACE, MOD_GUI_LEFT);
  DigiKeyboard.delay(600);
  DigiKeyboard.print("Terminal.app");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(600);
  DigiKeyboard.print("open -a Calculator");
  DigiKeyboard.delay(600);
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(600);
  for(;;){ /*empty*/ }
}