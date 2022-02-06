int[][] grid;//the main display grid for drawing on
ArrayList instruct2;//list of user selected instrutions

PImage curs,rimg,limg,uimg,dimg,loopimg; //UI images
PImage redimg, greenimg, blueimg, blackimg, whiteimg, yellowimg, cyanimg, magimg;
int cX, cY;//x&y of cursor
Button run, stop, prev, next, clear, fast;//UI buttons

int currLine;//current instruction
int inOffset;//UI index of instruction list
int currColor;//current color
int whichExam;//display which example
float sx, sy, ss;

Table[] exams;//array of examples
boolean correct;//more matching an example
int os;//just some stuff for example matching


void setup()
{
  
  //size(1400,500);
  //surface.setTitle("Code Drawing");
  //surface.setResizable(true);
  //surface.setLocation(50, 0);
  fullScreen();
  surface.setLocation(50, 0);
  sx = width/100;
  sy = height/100;
  ss = sy;
  grid = new int[40][40];
  instruct2 = new ArrayList<Inst>();
  //I could make the duck animated, but haven't got around to it
  curs = loadImage("mouse.gif");
  exams = new Table[6];
  for(int i = 0; i < exams.length; i++)
  {
    exams[i] = loadTable(i+".csv");
  }
  curs.resize(0,(int)(curs.height*(ss/10)));
  rimg = loadImage("r.png");
  rimg.resize(0,(int)(rimg.height*(ss/10)));
  limg = loadImage("l.png");
  limg.resize(0,(int)(limg.height*(ss/10)));
  uimg = loadImage("u.png");
  uimg.resize(0,(int)(uimg.height*(ss/10)));
  dimg = loadImage("d.png");
  dimg.resize(0,(int)(dimg.height*(ss/10)));
  loopimg = loadImage("loop.png");
  loopimg.resize(0,(int)(loopimg.height*(ss/10)));
  redimg = loadImage("red.png");
  redimg.resize(0,(int)(redimg.height*(ss/10)));
  greenimg = loadImage("green.png");
  greenimg.resize(0,(int)(greenimg.height*(ss/10)));
  blueimg = loadImage("blue.png");
  blueimg.resize(0,(int)(blueimg.height*(ss/10)));
  blackimg = loadImage("black.png");
  blackimg.resize(0,(int)(blackimg.height*(ss/10)));
  whiteimg = loadImage("white.png");
  whiteimg.resize(0,(int)(whiteimg.height*(ss/10)));
  yellowimg = loadImage("yellow.png");
  yellowimg.resize(0,(int)(yellowimg.height*(ss/10)));
  cyanimg = loadImage("cyan.png");
  cyanimg.resize(0,(int)(cyanimg.height*(ss/10)));
  magimg = loadImage("mag.png");
  magimg.resize(0,(int)(magimg.height*(ss/10)));
  currColor = 8;
  whichExam = -1;
  cX = cY = 20;
  run = new Button(" run ", 105*ss, 55*ss, 1.5*ss);
  fast = new Button("fast", 111*ss, 55*ss, 1.5*ss);
  stop = new Button("stop", 117*ss, 55*ss, 1.5*ss);
  prev = new Button("<", 25*ss, 85*ss, 3*ss);
  next = new Button(">", 95*ss, 85*ss, 3*ss);
  clear = new Button("clear", 105*ss, 45*ss, 2*ss);
  stop.togS();
  correct = false;
  frameRate(60);
}


void draw()
{
  if(ss!=height/100)
    ss = height/100;
  noStroke();
  //fill(255,130);
  background(215,250,200);
  if(correct)
  {
    colorMode(HSB,255,255,255,255);
  }
  else
  {
    fill(235,255,220);
  }
  
  for(int i = 0; i <= width; i+=width/20)
  {
    for(int ii = 0; ii <= height; ii+=width/20)
    {
      if(correct)
      {
        fill((i*ii+os)%255,255,255);
        os++;
      }
      circle(i,ii,dist(mouseX,mouseY,i,ii)/10);
    }
  }
  colorMode(RGB,255,255,255,255);
  for(int i = 0; i < grid.length; i++)
  {
    for(int ii = 0; ii < grid[i].length; ii++)
    {
      switch(grid[i][ii])
      {
        case 0:
          noFill();
          break;
        case 8:
          fill(0);
          break;
        case 9:
          fill(255);
          break;
        case 10:
          fill(255,0,0);
          break;
        case 11:
          fill(0,255,0);
          break;
        case 12:
          fill(0,0,255);
          break;
        case 13:
          fill(0,255,255);
          break;
        case 14:
          fill(255,255,0);
          break;
        case 15:
          fill(255,0,255);
          break;
      }
      rect(20*ss+i*2*ss,ii*2*ss,2*ss,2*ss);
    }
    
  }
  if(whichExam > -1 && !run.s())
  {
    correct = true;
    for(int i = exams[whichExam].getRowCount()-1; i >= 0; i--)
    {
      for(int ii = 0; ii < exams[whichExam].getColumnCount(); ii++)
      {
        int tempX = cX + ii+1;
        if(tempX >= grid.length)
         tempX -= grid.length;
        int tempY = cY+i-exams[whichExam].getRowCount()+1;
        if(tempY < 0)
         tempY += grid[0].length;
        if(grid[tempX][tempY] != exams[whichExam].getInt(i,ii))
        {
          correct = false;
          //println("wE: " + whichExam + " at: " + i + " : " + ii + " " + exams[whichExam].getInt(i,ii)+ " != " + grid[tempX][tempY]);
        }
        switch(exams[whichExam].getInt(i,ii))
        {
          case 0:
            noFill();
            break;
          case 8:
            fill(0,64);
            break;
          case 9:
            fill(255,64);
            break;
          case 10:
            fill(255,0,0,64);
            break;
          case 11:
            fill(0,255,0,64);
            break;
          case 12:
            fill(0,0,255,64);
            break;
          case 13:
            fill(0,255,255,64);
            break;
          case 14:
            fill(255,255,0,64);
            break;
          case 15:
            fill(255,0,255,64);
            break;
        }
        rect(20*ss+(ii+1)*2*ss+cX*2*ss,(i-exams[whichExam].getRowCount()+1)*2*ss+cY*2*ss,2*ss,2*ss);
        rect(100*ss+(ii+1)*ss,i*ss,ss,ss);
        switch(grid[tempX][tempY])
        {
          case 0:
            noFill();
            break;
          case 8:
            fill(0);
            break;
          case 9:
            fill(255);
            break;
          case 10:
            fill(255,0,0);
            break;
          case 11:
            fill(0,255,0);
            break;
          case 12:
            fill(0,0,255);
            break;
          case 13:
            fill(0,255,255);
            break;
          case 14:
            fill(255,255,0);
            break;
          case 15:
            fill(255,0,255);
            break;
        }
        rect(100*ss+(ii+1)*ss,i*ss,ss,ss);
        
      }
    }

  }
  //grid
  strokeWeight(1);
  stroke(127);
  noFill();
  for(int i = 0; i < 41; i++)
  {
    line(20*ss,i*2*ss,100*ss,i*2*ss);  
    line(i*2*ss+20*ss,0,i*2*ss+20*ss,80*ss);  
  }
  //cursor
  stroke(0);
  strokeWeight(2);
  rect(100*ss,0,40*ss,40*ss);
  rect(20*ss+cX*2*ss,cY*2*ss,2*ss,2*ss);
  
  fill(127);
  rect(13*ss+cX*2*ss,cY*2*ss+6*ss,5*ss,5*ss);
  switch(currColor)
  {
    case 0:
      noFill();
      break;
    case 8:
      fill(0);
      break;
    case 9:
      fill(255);
      break;
    case 10:
      fill(255,0,0);
      break;
    case 11:
      fill(0,255,0);
      break;
    case 12:
      fill(0,0,255);
      break;
    case 13:
      fill(0,255,255);
      break;
    case 14:
      fill(255,255,0);
      break;
    case 15:
      fill(255,0,255);
      break;
  }
  ellipse(15.5*ss+cX*2*ss,cY*2*ss+6*ss,5*ss,2*ss);
  image(curs,7*ss+cX*2*ss,cY*2*ss);
  //UI buttons
  run.draw();
  stop.draw();
  prev.draw();
  next.draw();
  clear.draw();
  fast.draw();
  image(rimg,0,0);
  image(limg,0,10*ss);
  image(uimg,0,20*ss);
  image(dimg,0,30*ss);
  image(loopimg,0,40*ss);
  drawIf(0,50*ss,8,4,0);
  drawLoop(0,60*ss,3,4,0);
  image(blackimg,10*ss,0);
  image(whiteimg,10*ss,10*ss);
  image(redimg,10*ss,20*ss);
  image(greenimg,10*ss,30*ss);
  image(blueimg,10*ss,40*ss);
  image(cyanimg,10*ss,50*ss);
  image(yellowimg,10*ss,60*ss);
  image(magimg,10*ss,70*ss);
  
  fill(255,127,160);
  noStroke();
  if(0<=currLine-inOffset&&currLine-inOffset < 6)
    rect(30*ss+(currLine-inOffset)*10*ss,80*ss,10*ss,10*ss);
  for(int i = inOffset;i<instruct2.size()&&i<6+inOffset;i++)
  {
    fill(255,0,0);
    noStroke();
    rect((i-inOffset)*10*ss+30*ss,95*ss,10*ss,5*ss);
    image(limg,(i-inOffset)*10*ss+30*ss,90*ss,5*ss,5*ss);
    image(rimg,(i-inOffset)*10*ss+35*ss,90*ss,5*ss,5*ss);
    switch(((Inst)instruct2.get(i)).a)
    {
      case 0:
        image(rimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 1:
        image(limg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 2:
        image(uimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 3:
        image(dimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 5:
        image(loopimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 6:
        drawIf((i-inOffset)*10*ss+30*ss,80*ss,((Inst)instruct2.get(i)).b,((Inst)instruct2.get(i)).c,((Inst)instruct2.get(i)).d);
        break;
      case 7:
        drawLoop((i-inOffset)*10*ss+30*ss,80*ss,((Inst)instruct2.get(i)).b,((Inst)instruct2.get(i)).c,((Inst)instruct2.get(i)).d);
        break;
      case 8:
        image(blackimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 9:
        image(whiteimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 10:
        image(redimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 11:
        image(greenimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 12:
        image(blueimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 13:
        image(cyanimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 14:
        image(yellowimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;
      case 15:
        image(magimg,(i-inOffset)*10*ss+30*ss,80*ss);
        break;   
    }
  }
  if(frameCount % 10 == 0 || fast.s())
  {
    if(run.s())
    {
      if(currLine < instruct2.size())
      {
        switch(((Inst)instruct2.get(currLine)).a)
        {
          case 0:
            cX++;
            if(cX>39)
              cX = 0;
            grid[cX][cY] = currColor;
            break;
          case 1:
            cX--;
            if(cX<0)
              cX = 39;
            grid[cX][cY] = currColor;
            break;
          case 2:
            cY--;
            if(cY<0)
              cY = 39;
            grid[cX][cY] = currColor;
            break;
          case 3:
            cY++;
            if(cY>39)
              cY = 0;
            grid[cX][cY] = currColor; 
            break;
          case 5: //basic loop
            currLine = -1;
            break;
          case 6://if
            int tx = cX; 
            int ty = cY;
            switch(((Inst)instruct2.get(currLine)).c)
            {
              case 0:
                tx--;
                if(tx<0)
                  tx = 39;
                ty--;
                if(ty<0)
                  ty = 39;
                break;
              case 1:
                ty--;
                if(ty<0)
                  ty = 39;
                break;
              case 2:
                tx++;
                if(tx>39)
                  tx = 0;
                ty--;
                if(ty<0)
                  ty = 39;
                break;
              case 3:
                tx--;
                if(tx<0)
                  tx = 39;
                break;
              case 5:
                tx++;
                if(tx>39)
                  tx = 0;
                break;
              case 6:
                tx--;
                if(tx<0)
                  tx = 39;
                ty++;
                if(ty>39)
                  ty = 0;
                break;
              case 7:
                ty++;
                if(ty>39)
                  ty = 0;
                break;
              case 8:
                tx++;
                if(tx>39)
                  tx = 0;
                ty++;
                if(ty>39)
                  ty = 0;
                break;
                
            }
            if(((Inst)instruct2.get(currLine)).b != grid[tx][ty])
                  currLine+=((Inst)instruct2.get(currLine)).d;
            break;
          case 7://complex loop
            if(((Inst)instruct2.get(currLine)).b > 0)
            {
              ((Inst)instruct2.get(currLine)).b--;
               currLine-=((Inst)instruct2.get(currLine)).d+1;
            }
            else
            {
              ((Inst)instruct2.get(currLine)).b = ((Inst)instruct2.get(currLine)).c;
             
            }
            
            break;
          case 8:
            currColor = 8;
            break;
          case 9:
            currColor = 9;
            break;
          case 10:
            currColor = 10;
            break;
          case 11:
            currColor = 11;
            break;
          case 12:
            currColor = 12;
            break;
          case 13:
            currColor = 13;
            break;
          case 14:
            currColor = 14;
            break;
          case 15:
            currColor = 15;
            break;
        }
        currLine++;
      }
      else
      {
        currLine = 0;
        run.togS();
        stop.togS();
        
      }
  }
    
  }
  
  run.draw();
  stop.draw();
  prev.draw();
  next.draw();
  clear.draw();
  fast.draw();
  if(prev.mouseOver())
  {
    noStroke();
    fill(255);
    rect(mouseX, mouseY-ss*55,ss*50,ss*50);
    for(int i = 0;i<instruct2.size();i++)
    {
      
      if(currLine==i)
      {
        fill(255,127,160);
        rect((i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
      }
      if(i < inOffset || i > inOffset+5)
      {
         fill(127,127);
         rect((i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
      }
      switch(((Inst)instruct2.get(i)).a)
      {
        case 0:
          image(rimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 1:
          image(limg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 2:
          image(uimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 3:
          image(dimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 5:
          image(loopimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 6:
          ss*=0.5;
          drawIf((i%10)*10*ss+mouseX,mouseY-110*ss+10*ss*floor(i/10),((Inst)instruct2.get(i)).b,((Inst)instruct2.get(i)).c,((Inst)instruct2.get(i)).d);
          ss*=2;
          break;
        case 7:
          ss*=0.5;
          drawLoop((i%10)*10*ss+mouseX,mouseY-110*ss+10*ss*floor(i/10),((Inst)instruct2.get(i)).b,((Inst)instruct2.get(i)).c,((Inst)instruct2.get(i)).d);
          ss*=2;
          break;
        case 8:
          image(blackimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 9:
          image(whiteimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 10:
          image(redimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 11:
          image(greenimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 12:
          image(blueimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 13:
          image(cyanimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 14:
          image(yellowimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 15:
          image(magimg,(i%10)*5*ss+mouseX,mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;   
      }
    }
  }
  else if(next.mouseOver())
  {
    noStroke();
    fill(255);
    rect(mouseX-50*ss, mouseY-ss*55,ss*50,ss*50);
    for(int i = 0;i<instruct2.size();i++)
    {
      
      if(currLine==i)
      {
        fill(255,127,160);
        rect((i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
      }
      if(i < inOffset || i > inOffset+5)
      {
         fill(127,127);
         rect((i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
      }
      switch(((Inst)instruct2.get(i)).a)
      {
        case 0:
          image(rimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 1:
          image(limg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 2:
          image(uimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 3:
          image(dimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 5:
          image(loopimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 6:
          ss*=0.5;
          drawIf((i%10)*10*ss+(mouseX-100*ss),mouseY-110*ss+10*ss*floor(i/10),((Inst)instruct2.get(i)).b,((Inst)instruct2.get(i)).c,((Inst)instruct2.get(i)).d);
          ss*=2;
          break;
        case 7:
          ss*=0.5;
          drawLoop((i%10)*10*ss+(mouseX-100*ss),mouseY-110*ss+10*ss*floor(i/10),((Inst)instruct2.get(i)).b,((Inst)instruct2.get(i)).c,((Inst)instruct2.get(i)).d);
          ss*=2;
          break;
        case 8:
          image(blackimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 9:
          image(whiteimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 10:
          image(redimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 11:
          image(greenimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 12:
          image(blueimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 13:
          image(cyanimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 14:
          image(yellowimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;
        case 15:
          image(magimg,(i%10)*5*ss+(mouseX-50*ss),mouseY-55*ss+5*ss*floor(i/10),ss*5,ss*5);
          break;   
      }
    }
  }
}

/*
How the terrible UI works,
*/
void mouseClicked()
{
  if(run.mouseOver()&&!run.s())
  {
    run.togS();
    stop.togS();
  }
  else if(stop.mouseOver()&&!stop.s())
  {
   run.togS();
   stop.togS();
  }
  if(prev.mouseOver())
  {
    if(inOffset>0)
      inOffset--;
  }
  else if(next.mouseOver())
  {
    if(inOffset<instruct2.size())
      inOffset++;
  }
  else if(clear.mouseOver())
  {
    for(int i = 0; i < grid.length; i++)
    {
      for(int ii = 0; ii < grid[i].length; ii++)
      {
        grid[i][ii]=0;
      }
    }
  }
  else if(fast.mouseOver())
  {
    fast.togS();
  }
  //right
  else if(dist(5*ss,5*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(0));
  }
  //left
  else if(dist(5*ss,15*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(1));
  }
  //up
  else if(dist(5*ss,25*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(2));
  }
  //down
  else if(dist(5*ss,35*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(3));
  }
  //loop
  else if(dist(5*ss,45*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(5));
  }
  else if(dist(5*ss,55*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(6,8,4,0));
  }
  else if(dist(5*ss,65*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(7,1,1,0));
  }
  //black
  else if(dist(15*ss,5*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(8));
  }
  //white
  else if(dist(15*ss,15*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(9));
  }
  //red
  else if(dist(15*ss,25*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(10));
  }
  //green
  else if(dist(15*ss,35*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(11));
  }
  //blue
  else if(dist(15*ss,45*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(12));
  }
  //cyan
  else if(dist(15*ss,55*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(13));
  }
  //yellow
  else if(dist(15*ss,65*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(14));
  }
  //mag
  else if(dist(15*ss,75*ss,mouseX,mouseY)<5*ss)
  {
    instruct2.add(new Inst(15));
  }
  else if(mouseX<width-10*ss&&mouseX>30*ss&&mouseY<height&&mouseY>80*ss)
  {
    int which = (int)((mouseX-30*ss)/(10*ss)+inOffset);
    boolean left = mouseX%(10*ss)<=5*ss;
    if(which < instruct2.size())
    {
      if(((Inst)instruct2.get(which)).a==6)
      {
        
        if(mouseY>95*ss)
        {
          instruct2.remove(which);
          reduceScope();
        }
        else if(mouseY>90*ss)
        {
          if(left&&which>0)
          {
            swap(which,which-1);
            if(inOffset>0)
              inOffset--;   
          }
          else if(which<instruct2.size()-1)
          {
            swap(which,which+1);
            if(inOffset<instruct2.size())
              inOffset++;
          }
        }
        else if(mouseY>85*ss)
        {
          if(left)
          {
            if(((Inst)instruct2.get(which)).d>0)
              ((Inst)instruct2.get(which)).d--;
            
          }
          else
          {
            if(((Inst)instruct2.get(which)).d+which+1<instruct2.size())
              ((Inst)instruct2.get(which)).d++;
          }
          
        }
        else
        {
          if(left)
          {
            ((Inst)instruct2.get(which)).b++;
            if(((Inst)instruct2.get(which)).b>15)
              ((Inst)instruct2.get(which)).b = 8;
            
          }
          else
          {
            ((Inst)instruct2.get(which)).c++;
            if(((Inst)instruct2.get(which)).c>8)
              ((Inst)instruct2.get(which)).c = 0;
          }
          
        }
      }
      else if(((Inst)instruct2.get(which)).a==7)
      {
        
        if(mouseY>95*ss)
        {
          instruct2.remove(which);
          reduceScope();
        }
        else if(mouseY>90*ss)
        {
          if(left&&which>0)
          {
            swap(which,which-1);
            if(inOffset>0)
              inOffset--;   
          }
          else if(which<instruct2.size()-1)
          {
            swap(which,which+1);
            if(inOffset<instruct2.size())
              inOffset++;
          }
        }
        else if(mouseY>85*ss)
        {
          if(left)
          {
            if(((Inst)instruct2.get(which)).d>0)
              ((Inst)instruct2.get(which)).d--;
            
          }
          else
          {
            if(which-((Inst)instruct2.get(which)).d>0)
              ((Inst)instruct2.get(which)).d++;
          }
          
        }
        else 
        {
          if(left)
          {
            if(((Inst)instruct2.get(which)).c>1)
            {
              ((Inst)instruct2.get(which)).c--;
              ((Inst)instruct2.get(which)).b=((Inst)instruct2.get(which)).c;
            }
            
          }
          else
          {
            ((Inst)instruct2.get(which)).c++;
            ((Inst)instruct2.get(which)).b=((Inst)instruct2.get(which)).c;
          }
          
        }
      }
      else 
      {
        if(mouseY>95*ss)
        {
          instruct2.remove(which);
          reduceScope();
        }
        else if(mouseY>90*ss)
        {
          if(left&&which>0)
          {
            swap(which,which-1);
            if(inOffset>0)
              inOffset--;   
          }
          else if(which<instruct2.size()-1)
          {
            swap(which,which+1);
            if(inOffset<instruct2.size())
              inOffset++;
          }
        }
      }
    }
  }
  else if(mouseX>20*ss&&mouseY<80*ss && mouseX <100*ss)
  {
    cX=(int)((mouseX-20*ss)/(2*ss));
    cY=mouseY/(int)(2*ss);
  }
  else if(mouseX>100*ss&&mouseY<40*ss)
  {
    whichExam++;
    if(whichExam >= exams.length)
    {
      whichExam = -1;
      correct = false;
    }
  }
}

/*
when instructions are deleted or moved their scopce may need to be reduced
I'm not sure this complete
*/
void reduceScope()
{
  for(int i = 0; i < instruct2.size(); i++)
  {
    
    if(((Inst)instruct2.get(i)).a == 6 && i+((Inst)instruct2.get(i)).d>=instruct2.size())
    {
      ((Inst)instruct2.get(i)).d--;
    }
    else if(((Inst)instruct2.get(i)).a == 7 && i-((Inst)instruct2.get(i)).d<0)
    {
      ((Inst)instruct2.get(i)).d--;
    }
    
  }
  
}

//for drawing if instructions
void drawIf(float x, float y, int b, int c, int d)
{
  x-=0.5*ss;
  y+=ss;
  stroke(0);
  strokeWeight(0.2*ss);
  switch(b)
  {
    case 0:
      noFill();
      break;
    case 8:
      fill(0);
      break;
    case 9:
      fill(255);
      break;
    case 10:
      fill(255,0,0);
      break;
    case 11:
      fill(0,255,0);
      break;
    case 12:
      fill(0,0,255);
      break;
    case 13:
      fill(0,255,255);
      break;
    case 14:
      fill(255,255,0);
      break;
    case 15:
      fill(255,0,255);
      break;
   }
   rect(x+0.5*ss,y-0.8*ss,4*ss,4*ss);
   textSize(2*ss);
   fill(127);
   text("if",x+2*ss,y);
   image(rimg,x+7*ss,y+4*ss,3*ss,3*ss);
   image(limg,x+ss,y+4*ss,3*ss,3*ss);
   fill(0);
   text(d,x+5.5*ss,y+5*ss);
   
  
   noFill();
   rect(x+0.5*ss,y-ss,10*ss,10*ss);
   line(x+5.5*ss,y+0.5*ss,x+10*ss,y+0.5*ss);
   line(x+5.5*ss,y+2*ss,x+10*ss,y+2*ss);
   line(x+7*ss,y-ss,x+7*ss,y+3.5*ss);
   line(x+8.5*ss,y-ss,x+8.5*ss,y+3.5*ss);
   stroke(255,127,64);
   fill(255,127,64,127);
   rect(x+10.5*ss,y-ss,10*ss*d,10*ss);
   strokeWeight(1*ss);
   stroke(0);
   point((c%3)*1.5*ss+x+6.3*ss,(c/3)*1.5*ss+y-0.3*ss);
   
  
  
}

//for drawing loop instructions
void drawLoop(float x, float y, int b, int c, int d)
{
  x-=0.5*ss;
  y+=ss;
  fill(0);
  stroke(0);
  textSize(2*ss);
  text("loop",x+3*ss,y);
   image(rimg,x+7*ss,y+1.5*ss,3*ss,3*ss);
   image(limg,x+ss,y+1.5*ss,3*ss,3*ss);
   text(b+"/"+c,x+5.3*ss,y+2.5*ss);
   image(rimg,x+7*ss,y+4.5*ss,3*ss,3*ss);
   image(limg,x+ss,y+4.5*ss,3*ss,3*ss);
   text(d,x+5.5*ss,y+5.5*ss);
   strokeWeight(0.2*ss);
   stroke(0);
   noFill();
   rect(x+0.5,y-ss,10*ss,10*ss);
   stroke(64,127,255);
   fill(64,127,255,127);
   rect(x+0.5*ss-10*ss*d,y-ss,10*ss*d,10*ss);
}

//for moving instructions around
void swap(int a, int b)
{
  Inst temp = (Inst)instruct2.get(a);
  instruct2.set(a,instruct2.get(b));
  instruct2.set(b,temp);
}
