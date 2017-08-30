class Pitcher{
  String position, name, allStats;
  int wins, losses, games, GS, GF, CG, shutouts, saves, hits, runs, earnedRuns, HR, BB, IBB, SO, HBP, balks, WP, BF, ERAPlus;
  double age, winPercentage, IP, ERA, FIP, WHIP, H9, HR9, BB9, SO9, SOtoWRatio;
  
  Pitcher(String position, String name, double age, int wins, int losses, double winPercentage, double ERA, int games, int GS, 
          int GF, int CG, int shutouts, int saves, double IP, int hits, int runs, int earnedRuns, int HR, int BB, int IBB,
          int SO, int HBP, int balks, int WP, int BF, int ERAPlus, double FIP, double WHIP, double H9, double HR9, double BB9,
          double SO9, double SOtoWRatio) {
    this.position = position;
    this.name = name;
    this.age = age;
    this.wins = wins;
    this.losses = losses;
    this.winPercentage = winPercentage;
    this.ERA = ERA;
    this.games = games;
    this.GS = GS;
    this.GF = GF;
    this.CG = CG;
    this.shutouts = shutouts;
    this.saves = saves;
    this.IP = IP;
    this.hits = hits;
    this.runs = runs;
    this.earnedRuns = earnedRuns;
    this.HR = HR;
    this.BB = BB;
    this.IBB = IBB;
    this.SO = SO;
    this.HBP = HBP;
    this.balks = balks;
    this.WP = WP;
    this.BF = BF;
    this.ERAPlus = ERAPlus;
    this.FIP = FIP;
    this.WHIP = WHIP;
    this.H9 = H9;
    this.HR9 = HR9;
    this.BB9 = BB9;
    this.SO9 = SO9;
    this.SOtoWRatio = SOtoWRatio;
  }
  
  void printFormat(){
    println(position + ", " + name + ", " + age + ", " + wins + ", " + losses + ", " + winPercentage + ", " + ERA + ", " + games + ", " + 
            GS + ", " + GF + ", " + CG + ", " + shutouts + ", " + saves + ", " + IP + ", " + hits + ", " + runs + ", " + earnedRuns + ", " + 
            HR + ", " + BB + ", " + IBB + ", " + SO + ", " + HBP + ", " + balks + ", " + WP + ", " + BF + ", " + ERAPlus + ", " + FIP + ", " + 
            WHIP + ", " + H9 + ", " + HR9 + ", " + BB9 + ", " + SO9 + ", " + SOtoWRatio);
  }
  
  String toString(){
    allStats = position + ", " + name + ", " + wins + ", " + losses + ", " + ERA + ", " + IP + ", " + SO;
    return allStats;
  }
}