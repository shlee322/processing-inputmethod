String text;
String viewComposedText;

void setup() {
  size(200, 200);
  fill(0);
  
  text = "";
  viewComposedText = "";
}

void draw() {
  background(255);
  text(text + viewComposedText, 10, 10, 100, 100);
}

void keyPressed() {
  if(keyCode == BACKSPACE) {
    if(text.length() < 1) return;
    text = text.substring(0, text.length() - 1);
    return;
  }
  
  text += String.valueOf(Character.toChars(key));
}

void keyReleased() {
}

void inputMethodTextChanged() {
  if(committedText.length() > 0 ) {
    text += committedText;
    viewComposedText = "";
  } else {
    viewComposedText = composedText;
  }
  print("committedText:" + committedText + ", composedText:" + composedText.charAt(0) + "\n");
}
