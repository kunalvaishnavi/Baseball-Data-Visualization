# Baseball Data Visualization Project (CSC500 Project)

## Description
This project is a data visualization project with live baseball statistics (meaning that they are being updated on a daily basis). When the program is run, the user can see the live standings in the MLB. The topmost icon is in first place in the division. For example, on a particular day, if in the AL East, the topmost icon shows the logo of the Boston Red Sox, that means that the Red Sox are in first place in the AL East. All six divisions with their standings are shown. The user can also click on any team and get its starting 9 (for the NL, starting 8 + bench player because the pitcher hits and there’s no DH). Also, the user can compare two players from different or same teams by clicking on the stat line of the player (i.e. the row where the player’s position, name, batting average, ERA, etc. is listed).

The live data is being pulled from baseball-reference.com, and to access the data from the HTML code on that website, I have used an online tool called Jaunt, which allows for easy access to this data.

## Setup
* Install [Processing](www.processing.org) and [Jaunt](www.jaunt-api.com)
* Connect Jaunt to Processing:
  * Open the ZIP file from your download of Jaunt
  * Locate the .jar file
  * Open Baseball.pde and drag & drop the .jar file onto the sketchbook
* Connect picture files to Processing:
  * Download Logos.zip
  * Drag and drop all of the files inside the ZIP file onto the Baseball.pde sketchbook
* Check that your file system looks similar to the two screenshots called "File System Part 1" and "File System Part 2"

## Instructions
To run the program, open Baseball.pde and simply hit the play button in Processing. You will need to wait for about a minute as the program compiles all of the data from baseball-reference.com. Then, the standings will show up on the left. Left click on any team’s logo to get that team’s players’ information under the “Team 1” column. The same goes for the “Team 2” column, except you need to right click. 

To compare players, first select the teams you want in the appropriate columns. For example, if you want to compare players on the Boston Red Sox to the New York Yankees, left click on the Red Sox logo and right click on the Yankees logo. Next, select a player that you want to compare by clicking anywhere on the bottom of the specific player’s stat line. If nothing shows up, try clicking a little bit above and below where your cursor was previously (by a little bit, I mean a tiny bit). Then, a graph should show up which compares some statistics for both players.

When you’re done, simply click the red button in the top left corner, hit the stop button in Processing, or do Command/Ctrl-Q (depends on what computer you’re using - Command for Macs and Ctrl for Windows).
