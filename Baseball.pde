import com.jaunt.*;
import com.jaunt.component.*;
import com.jaunt.util.*;
import java.util.Arrays;
import java.util.ArrayList;
//import java.awt.*;
//import java.awt.event.*;
//import javax.swing.*;
//import java.util.regex.*;

// bStats = batter stats, pStats = pitcher stats, allWebsites = baseball-reference.com website pages for all teams, rankings = live rankings for all 30 teams
ArrayList<String> bStats, pStats, allWebsites = new ArrayList<String>(30), rankings = new ArrayList<String>(30);
ArrayList<Batter> allBatters = new ArrayList<Batter>();
ArrayList<Pitcher> allPitchers = new ArrayList<Pitcher>();
// contains the image filenames for each image
Button[] allButtons = new Button[30];
String[] teamAcronyms = {"ARI", "ATL", "BAL", "BOS", "CHC", "CHW", "CIN", "CLE", "COL", 
  "DET", "HOU", "KCR", "LAA", "LAD", "MIA", "MIL", "MIN", "NYM", 
  "NYY", "OAK", "PHI", "PIT", "STL", "SDP", "SFG", "SEA", "TBR", 
  "TEX", "TOR", "WSN"};
String[] posAcronyms = {"C", "1B", "2B", "SS", "3B", "LF", "CF", "RF", "OF", "DH", "P", 
  "IF", "CI", "UT", "MI", "SP", "RP", "CL", " "}; // Last one is for those w/o positions
// contains the images for all 30 teams
PImage[] allTeamLogos = new PImage[30];
// temp variables for certain situations;
String team1Name = "", team2Name = "";
int temp1 = -1, temp2 = -1, totalBattersBeforeTeam1 = 0, totalBattersBeforeTeam2 = 0, totalPitchersBeforeTeam1 = 0, totalPitchersBeforeTeam2 = 0;
final int widthOfClearingBox = 320, heightOfClearingBoxBatters = 160, heightOfClearingBoxPitchers = 95;
boolean firstTime1 = false, firstTime2 = false;
ArrayList<Integer> allXCoordinates = new ArrayList<Integer>(), allYCoordinates = new ArrayList<Integer>();
// number of batters and pitchers on each time that are in allBatters and allPitchers respectively
// do not include those with no position assigned
int[] numOfBatters = {23, 22, 24, 23, 22, 21, 17, 22, 20, 21, 22, 20, 24, 26, 19, 
  21, 17, 23, 26, 26, 21, 22, 22, 22, 27, 23, 24, 21, 27, 25}; // Since data is live, these need to be daily checked
int[] numOfPitchers = {10, 11, 10, 11, 11, 11, 11, 11, 11, 11, 11, 10, 11, 11, 10, 
  11, 11, 11, 11, 11, 11, 11, 10, 11, 11, 11, 11, 11, 9, 11}; // Since data is live, these need to be daily checked

void setAllWebsites() {
  for (String s : teamAcronyms) {
    allWebsites.add("http://www.baseball-reference.com/teams/" + s + "/2017.shtml");
  }
}

void setAllButtons() { 
  for (int i = 0; i < allButtons.length; i++) {
    allButtons[i] = new Button(teamAcronyms[i] + ".png", 80, 60);
  }
}

void setAllTeamLogos() {
  for (int i = 0; i < allTeamLogos.length; i++) {
    allTeamLogos[i] = loadImage(teamAcronyms[i], "png");
  }
}

// clean the region starting at (a, b) up to (a+c, b+d) and set it to the background
void clearStats(int a, int b, int c, int d) {
  fill(150, 120, 165);
  noStroke();
  rect(a, b, c, d);
  fill(255, 255, 255);
}

int toInt(String s) {
  if (s.equals("")) {
    return 0;
  } else {
    return Integer.parseInt(s);
  }
}

double toDouble(String s) {
  if (s.equals("") || s.equals("inf")){
    return 0.0;
  } 
  else {
    return Double.parseDouble(s);
  }
}

// show team icons on drawing
void drawTeamIcons() {
  int xPos = -75, yPos = 180;
  for (int i = 0; i < rankings.size(); i++) {
    Button b = new Button(rankings.get(i)+".png", 80, 80);
    PImage temp = loadImage(b.fileName);
    if (i % 5 == 0) {
      xPos += 100;
      yPos = 180;
    } else {
      yPos += (allButtons[i].bHeight + 40);
    }
    allXCoordinates.add(xPos);
    allYCoordinates.add(yPos);
    image(temp, xPos, yPos, 80, 80);
  }
}

// show selected/clicked image at the spot designated "Team 1" or the spot designated "Team 2"
void showTeamImage() {
  for (int i = 0; i < 30; i++) {
    if (mouseX > allXCoordinates.get(i) && mouseX < (allXCoordinates.get(i) + 80) && 
      mouseY > allYCoordinates.get(i) && mouseY < (allYCoordinates.get(i) + 80)) {
      if (mousePressed && (mouseButton == LEFT) && temp1 != i) { // Sets clicked team 1 image     
        temp1 = i;
        team1Name = rankings.get(i);
        image(loadImage(team1Name+".png"), 705, 40, 100, 100);
      }
      if (mousePressed && (mouseButton == RIGHT) && temp2 != i) { // Sets clicked team 2 image
        temp2 = i;
        team2Name = rankings.get(i);
        image(loadImage(team2Name+".png"), 1025, 40, 100, 100);
      }
    }
  }
}

// sets all batter objects
void setBatters(ArrayList<String> stats) {
  for (int i = 0; i < stats.size(); i += 27) {
    allBatters.add(new Batter(stats.get(i), stats.get(i+1), toDouble(stats.get(i+2)), toInt(stats.get(i+3)), toInt(stats.get(i+4)), toInt(stats.get(i+5)), 
      toInt(stats.get(i+6)), toInt(stats.get(i+7)), toInt(stats.get(i+8)), toInt(stats.get(i+9)), toInt(stats.get(i+10)), 
      toInt(stats.get(i+11)), toInt(stats.get(i+12)), toInt(stats.get(i+13)), toInt(stats.get(i+14)), toInt(stats.get(i+15)), 
      toDouble(stats.get(i+16)), toDouble(stats.get(i+17)), toDouble(stats.get(i+18)), toDouble(stats.get(i+19)), toDouble(stats.get(i+20)), 
      toInt(stats.get(i+21)), toInt(stats.get(i+22)), toInt(stats.get(i+23)), toInt(stats.get(i+24)), toInt(stats.get(i+25)), 
      toInt(stats.get(i+26))));
  }
}

// sets all pitcher objects
void setPitchers(ArrayList<String> stats) {
  for (int i = 0; i < stats.size(); i += 33) {
    allPitchers.add(new Pitcher(stats.get(i), stats.get(i+1), toDouble(stats.get(i+2)), toInt(stats.get(i+3)), toInt(stats.get(i+4)), toDouble(stats.get(i+5)), 
      toDouble(stats.get(i+6)), toInt(stats.get(i+7)), toInt(stats.get(i+8)), toInt(stats.get(i+9)), toInt(stats.get(i+10)), 
      toInt(stats.get(i+11)), toInt(stats.get(i+12)), toDouble(stats.get(i+13)), toInt(stats.get(i+14)), toInt(stats.get(i+15)), 
      toInt(stats.get(i+16)), toInt(stats.get(i+17)), toInt(stats.get(i+18)), toInt(stats.get(i+19)), toInt(stats.get(i+20)), 
      toInt(stats.get(i+21)), toInt(stats.get(i+22)), toInt(stats.get(i+23)), toInt(stats.get(i+24)), toInt(stats.get(i+25)), 
      toDouble(stats.get(i+26)), toDouble(stats.get(i+27)), toDouble(stats.get(i+28)), toDouble(stats.get(i+29)), 
      toDouble(stats.get(i+30)), toDouble(stats.get(i+31)), toDouble(stats.get(i+32))));
  }
}

// clean any random symbols next to the names (i.e. "*", "(", ")", etc.)
ArrayList<String> cleanStats(ArrayList<String> stats) {
  for (int a = 0; a < stats.size(); a++) {
    String s = stats.get(a);
    for (int i = 0; i < s.length(); i++) {
      if (s.substring(i, i+1).equals("(")) {
        stats.remove(a);
        stats.add(a, s.substring(0, s.indexOf("(")-1));
      }
    }
  }
  for (int b = 0; b < stats.size(); b++) {
    String s = stats.get(b);
    for (int i = 0; i < s.length(); i++) {
      if (s.substring(i, i+1).equals("*")) {
        stats.remove(b);
        stats.add(b, s.substring(0, s.length()-1));
      }
      if (s.substring(i, i+1).equals("#")) {
        stats.remove(b);
        stats.add(b, s.substring(0, s.length()-1));
      }
    }
  }
  return stats;
}

// display selected team's players' stats
void displayStats() {
  if (team1Name != "") {
    // team 1 batters
    int totalBattersBeforeCurrentTeam = 0, xCoord = 625, yCoord = 190;
    for (int i = 0; i < teamAcronyms.length; i++) {
      if (i == 0) {
        totalBattersBeforeCurrentTeam = 0;
      } else {
        totalBattersBeforeCurrentTeam += numOfBatters[i-1];
      }
      if (teamAcronyms[i].equals(team1Name)) {
        break;
      }
    }
    // clear and display stats
    clearStats(625, 180, widthOfClearingBox, heightOfClearingBoxBatters);
    for (int i = totalBattersBeforeCurrentTeam; i < totalBattersBeforeCurrentTeam + 9; i++) { // Starting 9 (8 + 1 bench for NL)
      textSize(12);
      text(allBatters.get(i).toString(), xCoord, yCoord);
      yCoord += 15;
    }
    // team 1 pitchers
    yCoord = 370;
    int totalPitchersBeforeCurrentTeam = 0;
    for (int i = 0; i < teamAcronyms.length; i++) {
      if (i == 0) {
        totalPitchersBeforeCurrentTeam = 0;
      } else {
        totalPitchersBeforeCurrentTeam += numOfPitchers[i-1];
      }
      if (teamAcronyms[i].equals(team1Name)) {
        break;
      }
    }
    // clear and display stats
    clearStats(625, 360, widthOfClearingBox, heightOfClearingBoxPitchers);
    for (int i = totalPitchersBeforeCurrentTeam; i < totalPitchersBeforeCurrentTeam + 5; i++) { // Starting rotation
      textSize(12);
      text(allPitchers.get(i).toString(), xCoord, yCoord);
      yCoord += 15;
    }
    totalBattersBeforeTeam1 = totalBattersBeforeCurrentTeam;
    totalPitchersBeforeTeam1 = totalPitchersBeforeCurrentTeam;
  }
  if (team2Name != "") {
    // team 2 batters
    int totalBattersBeforeCurrentTeam = 0, xCoord = 950, yCoord = 190;
    for (int i = 0; i < teamAcronyms.length; i++) {
      if (i == 0) {
        totalBattersBeforeCurrentTeam = 0;
      } else {
        totalBattersBeforeCurrentTeam += numOfBatters[i-1];
      }
      if (teamAcronyms[i].equals(team2Name)) {
        break;
      }
    }
    // clear and display stats
    clearStats(950, 180, widthOfClearingBox, heightOfClearingBoxBatters);
    for (int i = totalBattersBeforeCurrentTeam; i < totalBattersBeforeCurrentTeam + 9; i++) { // Starting 9 (8 + 1 bench for NL)
      textSize(12);
      text(allBatters.get(i).toString(), xCoord, yCoord);
      yCoord += 15;
    }
    // team 2 pitchers
    yCoord = 370;
    int totalPitchersBeforeCurrentTeam = 0;
    for (int i = 0; i < teamAcronyms.length; i++) {
      if (i == 0) {
        totalPitchersBeforeCurrentTeam = 0;
      } else {
        totalPitchersBeforeCurrentTeam += numOfPitchers[i-1];
      }
      if (teamAcronyms[i].equals(team2Name)) {
        break;
      }
    }
    // clear and display stats
    clearStats(950, 360, widthOfClearingBox, heightOfClearingBoxPitchers);
    for (int i = totalPitchersBeforeCurrentTeam; i < totalPitchersBeforeCurrentTeam + 5; i++) { // Starting rotation
      textSize(12);
      text(allPitchers.get(i).toString(), xCoord, yCoord);
      yCoord += 15;
    }
    totalBattersBeforeTeam2 = totalBattersBeforeCurrentTeam;
    totalPitchersBeforeTeam2 = totalPitchersBeforeCurrentTeam;
  }
}

// Note: need to click immediately below the player's stat line to compare because both the font and spacing between the players' lines are small
// displays information about the selected player in the form of bar graphs
void displayPlayersToCompare() {
  // Batter on team 1 to compare
  for (int i = 0; i < 15*9; i += 15) {
    if (mouseX > 625 && mouseX < 940 && mouseY > 190 && mouseY < 330) {
      if (mousePressed && (mouseButton == LEFT)) {
        clearStats(625, 465, widthOfClearingBox, 40);
        int batterNum = (mouseY-190)/15;
        fill(95, 175, 25); // green color
        text(allBatters.get(totalBattersBeforeTeam1 + batterNum).toString(), 625, 475);
        Batter b = allBatters.get(totalPitchersBeforeTeam1 + batterNum);
        clearStats(651, 519, 610, 81); // clears bar graphs
        fill(95, 175, 25); // green color
        int HR = b.HR; // [0, 70]
        rect(651, 520, (int)((600/70)*HR), 10);
        int RBI = b.RBI; // [0, 200]
        rect(651, 535, (int)((600/200)*RBI), 10);
        int SB = b.SB; // [0, 150]
        rect(651, 550, (int)((600/150)*SB), 10);
        int singles = b.singles; // [0, 275]
        rect(651, 565, (int)((600/275)*singles), 10);
        double OPSPlus = b.OPSPlus; // [0, 200]
        rect(651, 580, (int)((600/200)*OPSPlus), 10);
        clearStats(610, 519, 39, 80); // clears stats labels
        fill(255, 255, 255);
        text("HR", 615, 530);
        text("RBI", 615, 545);
        text("SB", 615, 560);
        text("H", 615, 575);
        text("OPS+", 615, 590);
      }
    }
  }
  // Pitcher on team 1 to compare
  for (int i = 0; i < 5; i++) {
    if (mouseX > 625 && mouseX < 940 && mouseY > 370 && mouseY < 445) {
      if (mousePressed && (mouseButton == LEFT)) {
        clearStats(625, 465, widthOfClearingBox, 40);
        int pitcherNum = (mouseY-370)/15;
        fill(95, 175, 225); // blue color
        text(allPitchers.get(totalPitchersBeforeTeam1 + pitcherNum).toString(), 625, 475);
        Pitcher p = allPitchers.get(totalPitchersBeforeTeam1 + pitcherNum);
        clearStats(651, 519, 610, 81); // clears bar graphs
        fill(95, 175, 225); // blue color
        int wins = p.wins; // [0, 30]
        rect(651, 520, (int)((600/30)*wins), 10);
        double ERA = p.ERA; // [0, 10]
        rect(651, 535, (int)((600/10)*ERA), 10);
        double IP = p.IP; // [0, 325]
        rect(651, 550, (int)((600/325)*IP), 10);
        int SO = p.SO; // [0, 325]
        rect(651, 565, (int)((600/325)*SO), 10);
        double ERAPlus = p.ERAPlus; // [0, 250]
        rect(651, 580, (int)((600/250)*ERAPlus), 10);
        clearStats(610, 519, 39, 80); // clears stats labels
        fill(255, 255, 255);
        text("W", 615, 530);
        text("ERA", 615, 545);
        text("IP", 615, 560);
        text("SO", 615, 575);
        text("ERA+", 615, 590);
      }
    }
  }
  // Batter on team 2 to compare
  for (int i = 0; i < 15*9; i += 15) {
    if (mouseX > 950 && mouseX < 1265 && mouseY > 190 && mouseY < 330) {
      if (mousePressed && (mouseButton == RIGHT)) {
        clearStats(950, 465, widthOfClearingBox, 40);
        int batterNum = (mouseY-190)/15;
        fill(225, 175, 95); // beige color
        text(allBatters.get(totalBattersBeforeTeam2 + batterNum).toString(), 950, 475);
        Batter b = allBatters.get(totalPitchersBeforeTeam2 + batterNum);
        clearStats(651, 599, 610, 81); // clears bar graphs
        fill(225, 175, 95); // beige color
        int HR = b.HR; // [0, 70]
        rect(651, 600, (int)((600/70)*HR), 10);
        int RBI = b.RBI; // [0, 200]
        rect(651, 615, (int)((600/200)*RBI), 10);
        int SB = b.SB; // [0, 150]
        rect(651, 630, (int)((600/150)*SB), 10);
        int singles = b.singles; // [0, 275]
        rect(651, 645, (int)((600/275)*singles), 10);
        double OPSPlus = b.OPSPlus; // [0, 200]
        rect(651, 660, (int)((600/200)*OPSPlus), 10);
        clearStats(610, 599, 39, 80); // clears stats labels
        fill(255, 255, 255);
        text("HR", 615, 610);
        text("RBI", 615, 625);
        text("SB", 615, 640);
        text("H", 615, 655);
        text("OPS+", 615, 670);
      }
    }
  }
  // Pitcher on team 2 to compare
  for (int i = 0; i < 5; i++) {
    if (mouseX > 950 && mouseX < 1265 && mouseY > 370 && mouseY < 445) {
      if (mousePressed && (mouseButton == RIGHT)) {
        clearStats(950, 465, widthOfClearingBox, 40);
        int pitcherNum = (mouseY-370)/15;
        fill(222, 150, 35); // orange
        text(allPitchers.get(totalPitchersBeforeTeam2 + pitcherNum).toString(), 950, 475);
        Pitcher p = allPitchers.get(totalPitchersBeforeTeam2 + pitcherNum);
        clearStats(651, 599, 610, 81); // clears bar graphs
        fill(222, 150, 35); // orange
        int wins = p.wins; // [0, 30]
        rect(651, 600, (int)((600/30)*wins), 10);
        double ERA = p.ERA; // [0, 10]
        rect(651, 615, (int)((600/10)*ERA), 10);
        double IP = p.IP; // [0, 325]
        rect(651, 630, (int)((600/325)*IP), 10);
        int SO = p.SO; // [0, 325]
        rect(651, 645, (int)((600/325)*SO), 10);
        double ERAPlus = p.ERAPlus; // [0, 250]
        rect(651, 660, (int)((600/250)*ERAPlus), 10);
        clearStats(610, 599, 39, 80); // clears stats labels
        fill(255, 255, 255);
        text("W", 615, 610);
        text("ERA", 615, 625);
        text("IP", 615, 640);
        text("SO", 615, 655);
        text("ERA+", 615, 670);
      }
    }
  }
  // space for 600 pixels across
}

// get the rankings embedded in the HTML code on baseball-reference.com
void getRankings() {
  try {
    UserAgent userAgent = new UserAgent();
    userAgent.visit("http://www.baseball-reference.com");
    Elements links = userAgent.doc.findEvery("tr");
    for (Element link : links) {
      String nums = link.innerText(); // Gets all of the numeric data in each category
      rankings.add(nums); // 2-6 is AL East, 8-12 is AL Central, 14-18 is AL West, 21-25 is NL East, 27-31 is NL Central, 33-37 is NL West
    }
    rankings.remove(0); // AL, W, L, GB, SRS
    rankings.remove(0); // East
    rankings.remove(5); // Central
    rankings.remove(10); // West
    rankings.remove(15); // NL, W, L, GB, SRS
    rankings.remove(15); // East
    rankings.remove(20); // Central
    rankings.remove(25); // West
    rankings = new ArrayList<String>(rankings.subList(0, 30));
    for (int i = 0; i < rankings.size(); i++) {
      String temp = rankings.get(i);
      temp = temp.substring(0, 3);
      rankings.set(i, temp);
    }
  }
  catch(JauntException e) {
    System.err.println(e);
  }
}

// get all batters' and pitchers' stats embedded in the HTML code on baseball-reference.com
void getStats() {
  try {
    UserAgent userAgent = new UserAgent();
    for (int a = 0; a < teamAcronyms.length; a++) {
      userAgent.visit(allWebsites.get(a)); // MLB teams' homepages on baseball-reference.com
      Elements links = userAgent.doc.findEvery("td class"); // Finds tags that start with "td class"
      ArrayList<String> stats = new ArrayList<String>();
      int bStartIndex = 0, pStartIndex = 0;
      for (Element link : links) { // link is each "td class" element
        String nums = link.innerText(); // Gets all of the numeric data in each category
        stats.add(nums);
        if (bStartIndex == 0 && nums.equals("C")) {
          bStartIndex = stats.size();
        }
        if (pStartIndex == 0 && nums.equals("SP")) {
          pStartIndex = stats.size();
        }
      }
      bStats = new ArrayList<String>(stats.subList(bStartIndex-1, stats.indexOf("P"))); // Only printing the batters' stats, even though the NL has pitchers hit
      pStats = new ArrayList<String>(stats.subList(pStartIndex-1, stats.size()-33)); // Gets just the pitchers' stats, even though there's a rare occurrence of 
      // a batter pitching. Also, it gets rid of team totals
      cleanStats(bStats); // Works fine
      cleanStats(pStats); // Works fine
      setBatters(bStats); // Puts the batters' data into Batter objects
      setPitchers(pStats); // Puts the pitchers' data into Pitcher objects
    }
    // Get rid of batters with no specified position
    int tempSize = 0;
    while (tempSize < allBatters.size()) {
      if (allBatters.get(tempSize).position.equals(" ")) {
        allBatters.remove(tempSize);
      } else {
        tempSize++;
      }
    }
    // Get rid of pitchers with no specified position
    tempSize = 0;
    while (tempSize < allPitchers.size()) {
      if (!allPitchers.get(tempSize).position.equals("SP") && !allPitchers.get(tempSize).position.equals("RP") && !allPitchers.get(tempSize).position.equals("CL")) {
        allPitchers.remove(tempSize);
      } else {
        tempSize++;
      }
    }
  }
  catch(JauntException e) {
    System.err.println(e);
  }
}

void setup() { // Must load images here
  size(1280, 715); // width x height
  background(150, 120, 165);
  setAllWebsites();
  setAllButtons();
  getRankings();
  getStats();
  surface.setTitle("The Baseball Rater 3000 by Kunal Vaishnavi");
  text("A.L. East", 40, 170);
  text("A.L. Central", 130, 170);
  text("A.L. West", 240, 170);
  text("N.L. East", 340, 170);
  text("N.L. Central", 430, 170);
  text("N.L. West", 540, 170);
  image(loadImage("AL.png"), 115, 40, 100, 100);
  image(loadImage("NL.png"), 420, 40, 100, 100);
  textSize(24);
  text("Team 1", 710, 30);
  text("Team 2", 1030, 30);
  drawTeamIcons();
  textSize(12);
  text("Pos, " + "Name, " + "BAA, " + "OBP, " + "SLG, " + "HR, " + "RBI" + " (Hitters)", 625, 170);
  text("Pos, " + "Name, " + "BAA, " + "OBP, " + "SLG, " + "HR, " + "RBI" + " (Hitters)", 950, 170);
  text("Pos, " + "Name, " + "Wins, " + "Losses, " + "ERA, " + "IP, " + "SO" + " (Pitchers)", 625, 350);
  text("Pos, " + "Name, " + "Wins, " + "Losses, " + "ERA, " + "IP, " + "SO" + " (Pitchers)", 950, 350);
  line(650, 515, 1250, 515); // horizontal line
  line(650, 515, 650, 700); // vertical line
}

void draw() {
  showTeamImage();
  displayStats();
  displayPlayersToCompare();
}
