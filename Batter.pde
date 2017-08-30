class Batter{
  String position, name, allStats;
  int games, PA, AB, runs, singles, doubles, triples, HR, RBI, SB, CS, BB, SO, TB, GDP, HBP, SH, SF, IBB;
  double age, BAA, OBP, SLG, OPS, OPSPlus;
  
  Batter(String position, String name, double age, int games, int PA, int AB, int runs, int singles, int doubles, int triples, 
         int HR, int RBI, int SB, int CS, int BB, int SO, double BAA, double OBP, double SLG, double OPS, double OPSPlus, 
         int TB, int GDP, int HBP, int SH, int SF, int IBB){
    this.position = position;
    this.name = name;
    this.age = age;
    this.games = games;
    this.PA = PA;
    this.AB = AB;
    this.runs = runs;
    this.singles = singles;
    this.doubles = doubles;
    this.triples = triples;
    this.HR = HR;
    this.RBI = RBI;
    this.SB = SB;
    this.CS = CS;
    this.BB = BB;
    this.SO = SO;
    this.BAA = BAA;
    this.OBP = OBP;
    this.SLG = SLG;
    this.OPS = OPS;
    this.OPSPlus = OPSPlus;
    this.TB = TB;
    this.GDP = GDP;
    this.HBP = HBP;
    this.SH = SH;
    this.SF = SF;
    this.IBB = IBB;
  }
  
  void printFormat(){
    println(position + ", " + name + ", " + age + ", " + games + ", " + PA + ", " + AB + ", " + runs + ", " + singles + ", " + doubles + ", " +
            triples + ", " + HR + ", " + RBI + ", " + SB + ", " + CS + ", " + BB + ", " + SO + ", " + BAA + ", " + OBP + ", " + SLG + ", " +
            OPS + ", " + OPSPlus + ", " + TB + ", " + GDP + ", " + HBP + ", " + SH + ", " + SF + ", " + IBB);  
  }
  
  String toString(){
    allStats = position + ", " + name + ", " + BAA + ", " + OBP + ", " + SLG + ", " + HR + ", " + RBI;
    return allStats;
  }
}