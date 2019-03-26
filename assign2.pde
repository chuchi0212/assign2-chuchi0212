// basic data

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = GAME_START;

PImage bg, cabbage, title, 
gameover, startNormal, startHovered , restartNormal, restartHovered,
groundhogDown, groundhogIdle, groundhogLeft, groundhogRight,
life, soil, soldier;

float startX = 248;
float startY = 360;
float restartX = 248;
float restartY = 360;

float groundhogX = 320;
float groundhogY = 80;
int groundhogSpeed1 = 5;
int groundhogSpeed2 = 6;
int groundhogLeftMove , groundhogRightMove, groundhogDownMove = 0;

float soldierX, soldierY;
float heart1X, heart2X, heart3X, heartY, heartWidth;
int cabbageX, cabbageY;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int time;

void setup() {
  size(640, 480, P2D);

  bg = loadImage("img/bg.jpg");
  cabbage = loadImage("img/cabbage.png");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  life = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  
  //sodier Y position
  soldierY = floor(random(2,6))*80;
  
  // cabbage position
  cabbageX = floor(random(0,8))*80;
  cabbageY = floor(random(2,6))*80;
  
  //Life Position
  heartWidth = 50;
  heart1X = 10;
  heart2X = 30 + heartWidth;
  heart3X = -100;
  heartY = 10;
  
}

void draw() {
  switch(gameState){
    case GAME_START:
    image(title, 0, 0);
    if ( mouseX >= 248 && mouseX <= 392 && mouseY >= 360 && mouseY<= 420){
      image(startHovered, startX, startY);
      if(mousePressed){
        gameState = GAME_RUN;
      }
    }else{
      image(startNormal, startX, startY);
    }
    break;
    
    case GAME_RUN:
     //background
     background(bg);
  
     //grass
     noStroke();
     colorMode(RGB);
     fill(104,204,25);
     rect(0,145,640,15);
      
     //solar
     strokeWeight(5);
     stroke(255,255,0);
     fill(253,184,19);
     ellipse(590,50,120,120);      

     //soil
     image(soil,0,160);  

     //key detection
     if(time == 0){
      image(groundhogIdle ,groundhogX, groundhogY);
     }
     
     if(downPressed){
       if(groundhogY + 80 < height ){
         time++;
         if(time >= 1 && time <= 14){
           if(time % 3 == 1 || time % 3 == 2){
             groundhogY += groundhogSpeed1;
           }else if (time % 3 == 0){
             groundhogY += groundhogSpeed2;
           }
           image(groundhogDown, groundhogX, groundhogY);
         }
         if(time == 15){
           groundhogY += groundhogSpeed2;
           image(groundhogIdle, groundhogX, groundhogY);
           time = 0 ;
           downPressed = false;
         }
       }else{
         downPressed = false;
         groundhogY = height - 80;
       }
     }
     if(leftPressed){
       if(groundhogX > 0 ){
         time++;
         if(time >= 1 && time <= 14){
           if(time % 3 == 1 || time % 3 == 2){
             groundhogX -= groundhogSpeed1;
           }else if (time % 3 == 0){
             groundhogX -= groundhogSpeed2;
           }
           image(groundhogLeft, groundhogX, groundhogY);
         }
         if(time == 15){
           groundhogX -= groundhogSpeed2;
           image(groundhogIdle, groundhogX, groundhogY);
           time = 0 ;
           leftPressed = false;
         }
       }else{
         leftPressed = false;
         groundhogX = 0;
       }
     }
      
     if(rightPressed){
       if (groundhogX < width - 80){
         time++;
         if(time >= 1 && time <= 14){
           if(time % 3 == 1 || time % 3 == 2){
             groundhogX += groundhogSpeed1;
           }else if (time % 3 == 0){
             groundhogX += groundhogSpeed2;
           }
           image(groundhogRight, groundhogX, groundhogY);
         }
         if(time == 15){
           groundhogX += groundhogSpeed2;
           image(groundhogIdle, groundhogX, groundhogY);
           time = 0 ;
           rightPressed = false;
         }
       }else{
         rightPressed = false;
         groundhogX = width - 80;
       }
     }
    
     // Life+ detection
     if(groundhogX == cabbageX && groundhogY == cabbageY){
       cabbageX = width;
       if( heart1X == 10){
         if(heart2X == 30 + heartWidth){
            heart3X =  50 + 2*heartWidth;
         }else{
           heart2X = 30 + heartWidth;
         }
       }
     }
     
     // Life- detection
     if(groundhogX < soldierX && groundhogX + 80 > soldierX - 80 &&
        groundhogY < soldierY + 80 && groundhogY + 80 > soldierY){
        rightPressed = false;
        leftPressed = false;
        downPressed = false;
        time = 0;
       if( heart1X == 10){
         if(heart2X == 30 + heartWidth){
           if (heart3X == 50 + 2*heartWidth){
             heart3X = -100;
             groundhogX = 320;
             groundhogY = 80;
           }else{
             heart2X = -150;
             groundhogX = 320;
             groundhogY = 80;
           }
         }else if (heart2X == -150){
          heart1X = -200;
          gameState = GAME_LOSE;
         }
       }
     }
     
     //soldier
     image(soldier, soldierX - 80, soldierY);
     soldierX += 6;
     soldierX %= 800;
     
     // cabbage
     image(cabbage, cabbageX, cabbageY);
     
     // Life
     image(life, heart1X, heartY);//1
     image(life, heart2X, heartY);//2
     image(life, heart3X, heartY);//3
    
    break;
    
    case GAME_LOSE:
    image(gameover, 0, 0);
    if ( mouseX >= 248 && mouseX <= 392 && mouseY >= 360 && mouseY<= 420){
      image(restartHovered, restartX, restartY);
      if(mousePressed){
        heart1X = 10;
        heart2X = 30 + heartWidth;
        heart3X = -100;
        groundhogX = 320;
        groundhogY = 80;
        soldierY = floor(random(2,6))*80;
        cabbageX = floor(random(0,9))*80;
        cabbageY = floor(random(2,6))*80;
        gameState = GAME_RUN;
      }
    }else{
      image(restartNormal, restartX, restartY);
    }   
  }
}

void keyPressed(){
 switch(keyCode){
  case DOWN: 
   downPressed = true;
   break;
  case LEFT: 
   leftPressed = true;
   break;
  case RIGHT: 
   rightPressed = true;
   break;      
 }
}
