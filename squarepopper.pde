//Niels Duivenvoorden
//500847100

//square class for creating objects with the same variables
class Square {
  float x, y, w; //position x, y and the width. width is width and height in this scenario since its a square
  float f; //the growfactor of the square
  float c; // the color of the square

  //square constructor
  Square() {
    w = random(10, 20);
    x = random(0, width - w);
    y = random(0, height - w);
    f = random(.05, .5);
  }
  
  //update values of the square per frame
  void update() {
    w += f; //add the factor to the actual size of the square
    c = map(f, .05, .5, 100, 255); //remap the color so the color is build from the growfactor
  }

  //actually draw the squares
  void display() {
    fill(c, 0, 0);
    rect(x, y, w, w);
  }
}

//timer class for the green row to indicate ohw much time is left
class Timer {
  float x, y, w, h; //position x, y and the width and height of the row

  //timer constructor
  Timer() {
    x = width * .1; //responsive startpoint x 
    y = height * .1; //responsive startpoint y
    h = 15; //height of the row 
  }

  //actually showing the rectangle
  void display() {
    fill(0, 255, 0);
    rect(x, y, w, h);
  }
}

//array with the size of the amount of squares
Square[] squares = new Square[20];
//times object
Timer timer;
//global score
int score;

void setup() {
  size(600, 600);
  //for loop that inserts square objects for every arrayitem
  for (int i = 0; i < squares.length; i++) {
    squares[i] = new Square();
  }
  //initializing one timer
  timer =  new Timer();
}

void draw() {
  background(0);
  float sum = 0; //float that resets every frame, so the actual bigness of all of the squares gets parsed thru
  //for loop to do more stuff per square
  for (int i = 0; i < squares.length; i++) {
    //update every square every frame
    squares[i].update();
    //display the squares
    squares[i].display();
    //add the size to the total sum
    sum += squares[i].w;
    //click detection
    if (isSquareClicked(squares[i].x, squares[i].y, squares[i].w)) {
      //reset the square
      resetSquare(i);
      //add the score
      score += (1000 - squares[i].w);
    }
  }
  //determine the width of the square row by remapping the sum to certain values 
  timer.w = map(sum, 0, 2000, width * .1, width - (width * .1 * 2));
  //cap of sum, so the game restarts at one point
  if (sum > 2000) {
    restartGame();
  }
  //show the timer
  timer.display();

  //draw the score
  fill(255);
  text(score, width * .5, height * .2);
}

//boolean to check if the mouse position is inbetween the given params and the left mouse button is clicked
boolean isSquareClicked(float squareX, float squareY, float squareSize) {
  return(mouseX >= squareX && mouseX <= squareX + squareSize && mouseY >= squareY && mouseY <= squareY + squareSize && mouseButton == LEFT);
}

//fill the arrayindex item with a new square
void resetSquare(int squareIndex) {
  squares[squareIndex] = new Square();
}

//restarts the game, sets score to 0 and fill the square array with new squares
void restartGame() {
  score = 0;
  for (int i = 0; i<squares.length; i++) {
    squares[i] = new Square();
  }
}
