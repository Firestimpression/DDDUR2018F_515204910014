int state = 1;
PImage bg, bg1,bg01,bg02,bg03,bg5;
int rest_time[][];
int gender_grade[][][];
float meal[][][];

int temp[][] = {{2, 3}, {2, 0}, {2, 1}, {2, 2}, {0, 3}, {1, 3}, {0, 0}, {0, 1}, {0, 2}, {1, 0}, {1, 1}, {1, 2}};
String name[] = {"面食", "米饭", "清真", "甜品", "西餐", "川菜", "小吃", "粤菜"};
PVector slider;
boolean flag_slider = false;

int gender = 0;
int grade = 0;

void setup() {
  size(1000,600);

  bg = loadImage("bg.png");
  bg1 = loadImage("bg1.png");
  bg01 = loadImage("bg01.png");
  bg02 = loadImage("bg02.png");
  bg03 = loadImage("bg03.png");
  bg5 = loadImage("bg5.png");

  rest_time = new int[108][];
  for (int i=0; i<rest_time.length; i++) {
    rest_time[i] = new int[5];
    for (int j=0; j<rest_time[i].length; j++) {
      rest_time[i][j] = 0;
    }
  }

  gender_grade = new int[3][4][108];
  for (int i=0; i<gender_grade.length; i++) {
    for (int j=0; j<gender_grade[i].length; j++) {
      for (int k=0; k<gender_grade[i][j].length; k++) {
        gender_grade[i][j][k] = 0;
      }
    }
  }

  meal = new float[3][4][8];
  for (int i=0; i<meal.length; i++) {
    for (int j=0; j<meal[i].length; j++) {
      for (int k=0; k<meal[i][j].length; k++) {
        meal[i][j][k] = 0;
      }
    }
  }

  readFile();

  println(gender_grade[0][0][1]);
  slider = new PVector(251, 550);
}

void draw() {
  if (state == 1) {
    background(0);
    image(bg, 0, 0, 1000, 600);
  } else if (state == 2) {
    background(255);
    image(bg01, 0, 0,1000, 600);
    image(bg1, 0, 0);
    image(bg5, 70, 140,120,350);
    drawIcon();
    drawSlider();
    drawCircle();
  } else if (state == 3) {
    background(255);
    image(bg02, 0, 0,1000, 600);
    drawIcon();
    drawBg();
    drawLine();
  } else if (state == 4) {
    background(255);
    image(bg03, 0, 0,1000, 600);
    drawIcon();
    drawBg();
    drawBar();
  }
}

void drawBar() {
  fill(0,188, 212,180);
  noStroke();
  rectMode(CORNERS);
  for (int i=0; i<8; i++) {
    rect(305+i*80, 500, 315+i*80, 500-meal[gender][grade][i]*5);
  }
  rectMode(CORNER);
}

void drawLine() {
  stroke(0,188, 212);
  for (int i=0; i<107; i++) {
    line(250+i*(700*1.0/108), 500-gender_grade[gender][grade][i]/900.0, 
      250+(i+1)*(700*1.0/108), 500-gender_grade[gender][grade][i+1]/900.0);
  }
}

void drawBg() {
  noStroke();
  fill(207,216,220,120);
  ellipse(50, 400, 35, 35);
  ellipse(100, 400, 35, 35);
  ellipse(150, 400, 35, 35);
  ellipse(50, 450, 35, 35);
  ellipse(100, 450, 35, 35);
  ellipse(150, 450, 35, 35);
  ellipse(200, 450, 35, 35);
  fill(0,188,212,150);
  ellipse(gender*50 + 50, 400, 35, 35);
  ellipse(grade*50 + 50, 450, 35, 35);
  fill(0);
  text("男", 44, 405);
  text("女", 94, 405);
  text("总计", 139, 405);
  text("本科", 39, 455);
  text("硕士", 89, 455);
  text("博士", 139, 455);
  text("总计", 189, 455);
  fill(69,90,100,200);
  rect(250, 150, 700, 350);
  if (state == 3) {
    for (int i=0; i<19; i++) {
      line(250+i*(700*1.0/18), 495, 250+i*(700*1.0/18), 500);
      fill(255);
      text(6+i, 247+i*(700*1.0/18), 515);
    }
    fill(255);
    text("人流量", 260, 170);
  } else if (state == 4) {
    for (int i=0; i<8; i++) {
      fill(0,200);
      text(name[i], 300+i*80, 515);
    }
    fill(69,90,100);
    for (int i=0; i<6; i++) {
      line(250, 500-i*50, 255, 500-i*50);
      fill(255);
      text(i*10, 230, 500-i*50);
    }
    fill(255);
    text("消费占比", 260, 170);
  }
}

void drawCircle() {
  int index = min(107, int((slider.x-250)/(700*1.0/18/6)));
  ellipse(410, 370, rest_time[index][0]/1000.0, rest_time[index][0]/1000.0);
  ellipse(557, 392, rest_time[index][1]/1000.0, rest_time[index][1]/1000.0);
  ellipse(513, 234, rest_time[index][2]/1000.0, rest_time[index][2]/1000.0);
  ellipse(324, 226, rest_time[index][3]/1000.0, rest_time[index][3]/1000.0);
}

void drawSlider() {
  stroke(0,188, 212);
  line(250, 550, 950, 550);
  fill(255);
  for (int i=0; i<19; i++) {
    line(250+i*(700*1.0/18), 555, 250+i*(700*1.0/18), 545);
    text(6+i, 247+i*(700*1.0/18), 570);
  }
  fill(0,188, 212,120);
  noStroke();
  rect(slider.x-2, slider.y-7, 4, 14);
  if (flag_slider) {
    slider.x  = min(max(mouseX, 250), 950);
  }
}

void drawIcon() {

  noStroke();
  if (state == 2) {
    fill(69,90,100, 150);
  } else {
    fill(0,188, 212,180);
  }
  rect(100, 50, 80, 40, 10);
  if (state == 3) {
    fill(69,90,100, 150);
  } else {
    fill(0,188, 212,180);
  }
  rect(200, 50, 80, 40, 10);
  if (state == 4) {
    fill(69,90,100, 150);
  } else {
    fill(0,188, 212,180);
  }
  rect(300, 50, 80, 40, 10);
  fill(0);
  stroke(0);
  text("用餐流量", 115, 73);
  text("用餐时间", 215, 73);
  text("饮食偏好", 315, 73);
}

void mousePressed() {
  //println(mouseX, mouseY);
  if (state==1 && mouseX>435 && mouseX<600 && mouseY>460 && mouseY<515) {
    state = 2;
  } else {
    if (mouseX>100 && mouseX<180 && mouseY>50 && mouseY<90) {
      state = 2;
    } else if (mouseX>200 && mouseX<280 && mouseY>50 && mouseY<90) {
      state = 3;
    } else if (mouseX>300 && mouseX<380 && mouseY>50 && mouseY<90) {
      state = 4;
    }

    if (state == 2) {
      if (dist(mouseX, mouseY, slider.x, slider.y)<10) {
        flag_slider = true;
      }
    } else if (state == 3 || state == 4) {
      if (dist(mouseX, mouseY, 50, 400)<18) {
        gender = 0;
      } else if (dist(mouseX, mouseY, 100, 400)<18) {
        gender = 1;
      } else if (dist(mouseX, mouseY, 150, 400)<18) {
        gender = 2;
      }
      if (dist(mouseX, mouseY, 50, 450)<18) {
        grade = 0;
      } else if (dist(mouseX, mouseY, 100, 450)<18) {
        grade = 1;
      } else if (dist(mouseX, mouseY, 150, 450)<18) {
        grade = 2;
      } else if (dist(mouseX, mouseY, 200, 450)<18) {
        grade = 3;
      }
    }
  }
}

void mouseReleased() {
  flag_slider = false;
}

void readFile() {
  BufferedReader file_path = createReader("data2.txt");
  try {
    String line;
    while ((line = file_path.readLine()) != null) {
      int index1, index2, index3, index4;
      String [] list = split(line, ',');

      if (list[1].equals("男")) {
        index1 = 0;
      } else {
        index1 = 1;
      }

      if (list[2].equals("本科")) {
        index2 = 0;
      } else if (list[2].equals("硕士")) {
        index2 = 1;
      } else {
        index2 = 2;
      }

      index3 = int((float(list[3])-6)*6);

      index4 = int(list[4]);

      rest_time[index3][index4]++;
      gender_grade[index1][index2][index3]++;
      gender_grade[index1][3][index3]++;
      gender_grade[2][index2][index3]++;
      gender_grade[2][3][index3]++;
    }
  }
  catch (IOException e) {
    e.printStackTrace();
  }

  BufferedReader file_path1 = createReader("data.txt");
  int count=0;
  try {
    String line;
    while ((line = file_path1.readLine()) != null) {
      String [] list = split(line, '\t');
      for (int i=0; i<12; i++) {
        print(count + " ");
        print(i+" ");
        println(list.length);

        meal[temp[i][0]][temp[i][1]][count] = float(list[i]);
      }
      count++;
    }
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}
