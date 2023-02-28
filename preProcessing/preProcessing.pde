import java.io.BufferedWriter;
import java.io.FileWriter;

void printf(float x, float y){
  String text = str(x) + " " + str(y);
  File f = new File(sketchPath("initialPos.txt"));
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(text);
    out.close();
  }catch (IOException e){
      e.printStackTrace();
  }
}


void setup(){
  println("start");
  
  PImage start = loadImage("initialPos-small.png");
  for (int y=0; y < start.height; y++){
    for(int x=0; x < start.width; x++){
      int loc = x + (y * start.width);
      if(start.pixels[loc] != color(0)){
        printf(x*5 -400,y*5 -400);
      }
    }
  }
  
  println("done");
}
