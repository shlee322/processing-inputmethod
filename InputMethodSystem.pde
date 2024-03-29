/////////////////////////////////////////////////////////////
// Input Method System
// Lee Sanghyuck (shlee322@elab.kr)

public class InputMethodSystem<T>
 implements java.awt.event.InputMethodListener, java.awt.im.InputMethodRequests
{
  private Object applet;
  private java.lang.reflect.Method inputMethodTextChangedMethod;
  
  public InputMethodSystem(Object applet) {
    this.applet = applet;
    
    try {
      this.inputMethodTextChangedMethod = applet.getClass().getMethod("inputMethodTextChanged");
    } catch(NoSuchMethodException e) {
    }
  }
  
  public void inputMethodTextChanged(java.awt.event.InputMethodEvent event) {
    int committedCharacterCount = event.getCommittedCharacterCount();
    java.text.AttributedCharacterIterator text = event.getText();

    if (text != null) {
      StringBuilder committedTextBuilder = new StringBuilder();
      int toCopy = committedCharacterCount;
      char c = text.first();
      while (toCopy-- > 0) {
        committedTextBuilder.append(c);
        c = text.next();
      }
      committedText = committedTextBuilder.toString();
      composedText = String.valueOf(c);
    }
    if(event.getCaret() == null) {
      composedText = "";
    }
    event.consume();

    if(this.inputMethodTextChangedMethod != null) {
      try {
        this.inputMethodTextChangedMethod.invoke(this.applet, null);
      } catch(IllegalAccessException e) {
      } catch(java.lang.reflect.InvocationTargetException e) {
      }
    }
  }

  public void caretPositionChanged(java.awt.event.InputMethodEvent event) {
  }

  public java.awt.Rectangle getTextLocation(java.awt.font.TextHitInfo offset) {
    return null;
  }

  public java.awt.font.TextHitInfo getLocationOffset(int x, int y) {
    return null;
  }

  public int getInsertPositionOffset() {
    return 0;
  }

  public java.text.AttributedCharacterIterator getCommittedText(int beginIndex, int endIndex, java.text.AttributedCharacterIterator.Attribute[] attributes) {
    return null;
  }

  public int getCommittedTextLength() {
    return 0;
  }

  public java.text.AttributedCharacterIterator cancelLatestCommittedText(java.text.AttributedCharacterIterator.Attribute[] attributes) {
    return null;
  }

  public java.text.AttributedCharacterIterator getSelectedText(java.text.AttributedCharacterIterator.Attribute[] attributes) {
    return null;
  }
}

String committedText="";
String composedText="";
InputMethodSystem inputMethodSystem = new InputMethodSystem(this);

void addListeners(java.awt.Component comp) {
  super.addListeners(comp);
  comp.enableInputMethods(true);
  comp.addInputMethodListener(inputMethodSystem);
}

void removeListeners(java.awt.Component comp) {
  super.removeListeners(comp);
  comp.enableInputMethods(false);
  comp.removeInputMethodListener(inputMethodSystem);
}

java.awt.im.InputMethodRequests getInputMethodRequests() {
  return inputMethodSystem;
}
