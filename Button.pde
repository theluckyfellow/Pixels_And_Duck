class Button
{
  boolean select;
  int state;
  String text;
  float textSize;
  float butW;
  float X;
  float Y;
  
  Button(String pText, float pX, float pY, float size)
  {
      text = pText;
      textSize = size;
      textSize(size);
      butW = textWidth(text)+(size*2);
      select = false;
      X = pX;
      Y = pY;
  }
  
  void resize(float size)
  {
    textSize = size;
    textSize(size);
    butW = textWidth(text)+(size*2); 
  }
  
  void move(float pX, float pY)
  {
    X = pX;
    Y = pY;
  }
  
  public void draw()
  {
     noStroke();
     if(select)
     {
       fill(40,255,0,127);
     }
     else if(this.mouseOver())
     {
       fill(255,255,127,127);
     }
     else
     {
       fill(255,127);
     }
     textAlign(CENTER,CENTER);
     ellipseMode(CENTER);
     ellipse(X,Y,butW,butW);
     fill(0);
     textSize(textSize);
     text(text,X,Y);
  }
  
  public boolean mouseOver()
  {
    if(dist(X,Y,mouseX,mouseY)<butW/2)return true;
    return false;
  } 
  
  public void setS(boolean pS)
  {
    select = pS;
  }
  public void togS()
  {
    select = !select;
  }
  public boolean s()
  {
     return select; 
  }
  String getText()
  {
    return text; 
  }
}
