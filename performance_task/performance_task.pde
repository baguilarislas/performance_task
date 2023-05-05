int str = 0;
int len = 0;
String str1;
String warning = "the walls seem to be dangerous, be careful";
String playerName = "";
String intro = "Is this real?.";
String cont = "What happened before, why are you here?.";
String cont2 = "do you want to go to sleep?.";
String click = "press enter to continue";
PImage img;
PImage texture;
float gameScreen = 0;
int clicks = 0;
PFont cursive;
PFont times;
int counter;
int playerX = 800;
int playerY = 60;
int loosingCon = 0;
int diff = 2;
int charx1 = 800;
int chary1 = 625;
int keyx = 210;
int keyy = 476;
int xdist = 0;
int ydist = 0;
boolean keyobt = false;
PImage k;
Button yes;
Button no;
Button yes1;
Animation animation1;
Charac character1;
Charac ch2;
Door d1;
Door d2;
Key k1;

class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      //populates the list with images that will be used for 
      String imgname = imagePrefix + i + ".png";
      images[i] = loadImage(imgname);
    }
  }

  void display(float xpos, float ypos) {
    imageMode(CENTER);
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
}

class Button{
  
  int xpos;
  int ypos;
  String name;
  
  Button(int tempx, int tempy, String temps){
    xpos = tempx;
    ypos = tempy;
    name = temps;
  }
  
  void display(){
    text(name, xpos, ypos);
  }
  
  void hoover(){
    if((mouseX > xpos && mouseX < xpos + 200) && (mouseY > ypos - 100 && mouseY < ypos - 25)){
    //back button
    line(xpos - 10,ypos,xpos + 150,ypos);
    }
  }
  
  boolean click(){
    if((mouseX > xpos && mouseX < xpos + 200) && (mouseY > ypos - 100 && mouseY < ypos - 25) && mousePressed == true)    {
      return true;
    }
  else{
    return false;
  }
}
}

class Charac {
  PImage[] images;
  int imageCount;
  int frame;
  int xpos;
  int ypos;
  
  Charac(String imagePrefix, int count, int tempx, int tempy) {
    imageCount = count;
    images = new PImage[imageCount];
    xpos = tempx;
    ypos = tempy;


    for (int i = 0; i < imageCount; i++) {
      String imgName = imagePrefix + nf(i, 1) + ".png";
      images[i] = loadImage(imgName);
    }
  }

  void display() {
    //displays the character in different states depending on if the characteer is moving
    if(xpos > 0 && xpos < 1000){
    if(keyPressed == true && keyCode == RIGHT && xpos < 970){
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
    xpos += 2;
  }
  if(keyPressed == true && keyCode == LEFT && xpos > 30){
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
    xpos -= 2;
  }
    }
  if( ypos > 0 && ypos < 800){
  if(keyPressed == true && keyCode == UP && xpos > 30){
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
    ypos -= 2;
  }
  if(keyPressed == true && keyCode == DOWN && xpos > 30){
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
    ypos += 2;
  }
  }
  if(keyPressed == false){
    image(images[0], xpos, ypos);
 }
}

int getx(){
  return xpos;
}

int gety(){
  return ypos;
}
}

class Door{
  
  int xpos;
  int ypos;
  int wide;
  int high;
  int target;
  int diameter;
  
  Door(int tempx, int tempy, int tempw, int temph, int targ, int tempd){
    xpos = tempx;
    ypos = tempy;
    wide = tempw;
    high = temph;
    diameter = tempd;
    target = targ;
  }
  
  void display(){
    //drws a door and know with the specified dimensions.
    fill(162,80,45);
    stroke(162,80,45);
    rect(xpos, ypos, wide,high);
    fill(255,215,0);
    ellipse(xpos + 8,ypos + 50,diameter,diameter);
  }
  
  int getTarg(){
    return target;
  }
  
  int getx(){
    return xpos;
  }
  
  int gety(){
    return ypos;
  }
  
}

class Key{
  
  int xpos;
  int ypos;
  PImage img;
  
  Key(){
    img = loadImage("key.png");
  }
  
  void display(int xpos, int ypos){
    image(img, xpos, ypos);
  }
  
  int getx(){
    return xpos;
  }
  
  int gety(){
    return ypos;
  }
}

void setup(){
  size(1000,800);
  
  //creating all the necessary objects
  k = loadImage("key.png");
  animation1 = new Animation("eyes", 4);
  character1 = new Charac("char", 3, 800, 550);
  ch2 = new Charac("char", 3, playerX, playerY);
  yes = new Button(100, 750, "yes");
  no = new Button(400, 750, "no");
  yes1 = new Button (width/2, 350, "yes");
  d1 = new Door(960,500,40,100,5,10);
  d2 = new Door(900,100,100,100, 8, 10);
  k1 = new Key ();
  
}

void draw(){
  //conditions in order to change the string that executes in the intro
  if(str == 0){
    str1 = intro;
  }
  if (str == 1){
    str1 = cont;
  }
  if(str == 2){
    str1 = cont2;
  //gameScreen controls which pieces of the code excute at any given time
  }
  if(gameScreen == 0){
    menu();
  }
  if(gameScreen == 1){
    //intro
    frameRate(8);
    background(255);
    animation1.display(width/2,height/2);
    times = createFont("times.ttf",50);
  //textFont(times,32);
  textSize(90);
  typewriteText(str1, 8, 600);
  if(counter == len && str == 2){
    yes.display();
    yes.hoover();
    if(yes.click() == true){
      gameScreen = 4;
    }
    no.display();
    no.hoover();
    if(no.click() == true){
      gameScreen = 10;
    }
  }
}
//first level
  if(gameScreen == 4){
    frameRate(60);
    linewalk();
    counter = 0;
  }
  if(gameScreen == 5){
    //First level continue screen
    background(240);
    fill(90);
    cursive = createFont("text.otf",50);
    textFont(cursive,32);
    textSize(135);
    typewriteText2("continue?", width/2, 200);
    yes1.display();
    yes1.hoover();
    if(yes1.click() == true){
      gameScreen = 6;
    }    
  }
  //main game screen
  if(gameScreen == 6){
    counter = 0;
    frameRate(60);
    gameScreen();
    loosingConditions();
  } 
  if(gameScreen == 0.1){
    //options menu
    options();
  }
  if(gameScreen == 8){
    // winning screen
    frameRate(15);
    background(255);
    cursive = createFont("text.otf",50);
    textFont(cursive,32);
    fill(125);
    stroke(125);
    textSize(135);
    typewriteText2("you won", width/2, height/2);
  }
  if(gameScreen == 10){
    //loosing screen
    frameRate(15);
    background(255);
    cursive = createFont("text.otf",50);
    textFont(cursive,32);
    fill(125);
    stroke(125);
    textSize(135);
    typewriteText2("you lost", width/2, height/2);
  }
}

void menu(){
  //options menu
  background(255);
  print(mouseX);
  print(mouseY);
  fill(90);
  cursive = createFont("text.otf",50);
  textFont(cursive,32);
  textSize(135);
  text("A way out", 200, 200);
  text("Start", 200, 350);
  text("Options", 200, 500);
  
  //start button
  if((mouseX > 200 && mouseX < 400)&&(mouseY > 300 && mouseY < 325)){
    line(225,335,400,335);
    if(mousePressed == true){
      gameScreen = 1;
    }
  }
  
  //options button
  if((mouseX > 200 && mouseX < 400) && (mouseY > 450 && mouseY < 525)){
    line(225,485,450,485);
    if(mousePressed == true){
      gameScreen = 0.1;
    }
  }
}

void options(){
  fill(150);
  background(34);
  text("difficulty",200,300);
  text("easy", 100, 400);
  text("medium", 300, 400);
  text("hard", 625, 400);
  text("back", 100, 725);
  if((mouseX > 100 && mouseX < 300) && (mouseY > 675 && mouseY < 700)){
    //back button
    line(90,710,250,710);
    if(mousePressed == true){
      gameScreen = 0;
    }
  }
    if((mouseX > 100 && mouseX < 300) && (mouseY > 350 && mouseY < 400)){
    //easy button
    line(90,385,250,385);
    if(mousePressed == true){
      keyx = 210;
      keyy = 476;
      gameScreen = 0;
    }
  }
    if((mouseX > 300 && mouseX < 550) && (mouseY > 350 && mouseY < 400)){
    //medium button
    line(300,385,580,385);
    if(mousePressed == true){
      gameScreen = 0;
      keyx = 532;
      keyy = 756;
    }
  }
      if((mouseX > 625 && mouseX < 800) && (mouseY > 350 && mouseY < 400)){
    //hard button
    line(625,385,800,385);
    if(mousePressed == true){
      gameScreen = 0;
      keyx = 376;
      keyy = 212;
    }
  }
}

void linewalk(){
  frameRate(15);
  background(230);
  stroke(123);
  fill(123);
  line(0,600,1000,600);
  d1.display();
  character1.display();
  //checks if the player makes contact with the door.
  if((d1.getx() - character1.getx()) < 0){
    gameScreen = d1.getTarg();
  }
}

void gameScreen(){ 
  
  background(255);
  ch2.display();
  playerX = ch2.getx();
  playerY = ch2.gety() - 20;
  stroke(0);
  fill(0);
  cursive = createFont("text.otf",50);
  textFont(cursive,32);
  textSize(35);
  text("acquired:", 750, 25);
  fill(0);
  
  //walls
  rect(0,0, 100,425);
  rect(200, 0, 100, 300);
  rect(0,375,300,50);
  rect(250,375,50,200);
  rect(300,525,-200,50);
  rect(200, 250, 300, 50);
  rect(450, 250, 50, -150);
  rect(450,250,50,250);
  rect(450,400,-100,50);
  rect(0,800,450,-150);
  rect(450,800,50,-200);
  rect(450, 600, 300,100);
  rect(1000,800,-200,-200);
  rect(800,600,50,-350);
  rect(800, 375, -200, 50);
  
  fill(0,255,0);
  stroke(0,255,0);
  xdist = ch2.getx() - keyx;
  ydist = ch2.gety() - keyy;
  d2.display();
  //display key
  if(keyobt == false){
    k1.display(keyx, keyy);
  }
  //obtaining the key
  if((xdist > -10 && xdist < 10) && (ydist > -10 && ydist < 10)){
    keyobt = true;
  }
  //move the key to the "acquired section"
  if(keyobt == true){
    image(k, 850, 25);
  }
  //check if the player makes contatc with the door and has the key
  if((abs(d2.getx() - ch2.getx())) < 20 && (abs(d2.gety() - ch2.gety()) < 30) && keyobt == true){
    gameScreen = d2.getTarg();
  }
  //in case the character doesnt have the key
  if((abs(d2.getx() - ch2.getx())) < 20 && (abs(d2.gety() - ch2.gety()) < 30) && keyobt == false){
    fill(0);
    textSize(135);
    fill(128);
    text("You dont have a key", 200, 200);
  }
}

void loosingConditions(){
//conditions that check if the player comes in contact with any wall
  
 if((playerX < 100 && playerX > 40) && (playerY > 0 && playerY < 425)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  }
 }
 if((playerX < 300 && playerX >200) && (playerY >0 && playerY < 300)){
   loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  }
 }
 if((playerX < 300 && playerX > 40) && (playerY > 335 && playerY < 435)){
   loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  }
 }
 if((playerX < 300 && playerX > 290) && (playerY > 335 && playerY < 575)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  }
 }
 if((playerX < 100 && playerX > 340) && (playerY > 525 && playerY < 50)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  }
 }
 if((playerX <500 && playerX > 240) && (playerY > 250 && playerY < 300)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  }
 }
 if((playerX < 500 && playerX > 450) && (playerY < 250 && playerY> 100)){
  gameScreen = 10; 
 }
 if((playerX < 500 && playerX > 450) && (playerY > 250 && playerY< 550)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  } 
 }
 if((playerX < 450 && playerX > 350) && (playerY > 360 && playerY< 410)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  } 
 }
 if((playerX < 470 && playerX > 20) && (playerY > 610 && playerY< 760)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  } 
 }
 if((playerX < 520 && playerX > 430) && (playerY > 580 && playerY< 780)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  } 
 }
 if((playerX < 770 && playerX > 430) && (playerY > 580 && playerY< 680)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  } 
 }
 if((playerX < 1000 && playerX > 780) && (playerY > 560 && playerY< 800)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  } 
 }
 if((playerX < 870 && playerX > 780) && (playerY > 210 && playerY< 600)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  } 
 }
 if((playerX < 820 && playerX > 580) && (playerY > 335 && playerY< 425)){
  loosingCon += 1;
  if(loosingCon == 0){
    text(warning, 250, 200);
  }
  else{
    gameScreen = 10;
  }
 }
 
}

//This function creates a typewriter effect by returning a sub section of a string that increments slowly.
void typewriteText(String text, int x, int y){
  if(counter == text.length() && str != 2){
    delay(1000);
     background(255);
     str += 1;
     counter = 0;
   }
   if(str == 2){
     len = text.length();
   }
    text(text.substring(0, counter), x, y, width, height);
    if (counter < text.length()){
    counter++;
  }
}
  
  void typewriteText2(String text, int x, int y){
    text(text.substring(0, counter), x, y, width, height);
    if (counter < text.length()){
    counter++;
  }
}
