/**
 * Visualization of news sentiment across various news sources.
 *
 * Visualization in the form of a flower that describes the volume and sentiment polarity of
 * articles published by different news sources. This allows users to understand which sources
 * not only publish more work within a time period but if that work has high, low, or neutral
 * sentiment polarity.
 *
 * Released under the MIT license. See LICENSE.md for more information.
 */

DataModel dataModel;


/**
 * Draw the visualization and save it to a file.
 */
void setup() {
  size(450, 550);
  loadSemiconstants();
  background(BACKGROUND_COLOR);

  dataModel = new DataModel();

  drawSources();
  drawCenter();
  drawStem();
  drawBottom();

  save("news_flower.png");
}


/**
 * Draw each of the news sources.
 */
void drawSources() {
  pushMatrix();
  pushStyle();

  int i = 0; // Skip first for axis
  for (String sourceName : dataModel.getSortedSourceNames()) {
    drawSource(sourceName, i);
    i++;
  }

  popStyle();
  popMatrix();
}


/**
 * Draw a single news source.
 *
 * @param sourceName The full name of the news source to be drawn.
 * @param index The number of news sources drawn prior to this news source.
 */
void drawSource(String sourceName, int index) {
  pushMatrix();
  pushStyle();

  translate(CENTER_FLOWER_X, CENTER_FLOWER_Y);
  rotate(getIndexRotation(index + 1));

  int sourceColor = SOURCE_COLORS.get(index);
  noFill();
  stroke(sourceColor);
  ellipseMode(CORNER);
  strokeWeight(1);
  //line(START_RADIUS, 0, END_RADIUS, 0);
  float petalMid = (START_RADIUS + END_RADIUS) / 2;
  bezier(START_RADIUS, -5, petalMid - 10, -25, petalMid + 30, -35, END_RADIUS, 0);
  bezier(START_RADIUS, 5, petalMid - 10, 25, petalMid + 30, 35, END_RADIUS, 0);

  float centerX = getRadiusForSentiment(0);
  stroke(LIGHT_GRAY);
  line(centerX, -30, centerX, 30);

  noStroke();
  fill(sourceColor);
  textFont(TINY_FONT);
  pushMatrix();
  pushStyle();
  translate(END_RADIUS + 4, 0);
  if (index < 5) {
    rotate(PI);
    textAlign(RIGHT, CENTER);
  } else {
    textAlign(LEFT, CENTER);
  }
  text(getSourceShortName(sourceName), 0, 0);
  popStyle();
  popMatrix();

  noStroke();
  fill(sourceColor, 100);
  ellipseMode(RADIUS);

  for(Article article : dataModel.getSource(sourceName).getArticles()) {
    float polarity = article.getPolarity();
    float x = getRadiusForSentiment(polarity);
    float y = generateVerticalOffsetForSentiment(article.getSegmenetIndex());
    ellipse(x, y, 3, 3);
  }

  popStyle();
  popMatrix();
}


/**
 * Draw the center of the flower.
 */
void drawCenter() {
  pushMatrix();
  pushStyle();

  noStroke();
  fill(NEAR_BLACK);
  ellipseMode(RADIUS);
  ellipse(CENTER_FLOWER_X, CENTER_FLOWER_Y, START_RADIUS-5, START_RADIUS-5);

  fill(WHITE);
  textAlign(CENTER, CENTER);
  textFont(TINY_FONT);
  text("Aug 2019", CENTER_FLOWER_X, CENTER_FLOWER_Y - 10);
  textFont(MEDIUM_FONT);
  text("20-21", CENTER_FLOWER_X, CENTER_FLOWER_Y + 10);

  popStyle();
  popMatrix();
}


/**
 * Draw the stem (and legend) of the visualization.
 */
void drawStem() {
  pushMatrix();
  pushStyle();

  translate(CENTER_FLOWER_X, CENTER_FLOWER_Y);

  noStroke();
  fill(DARK_GRAY);
  textFont(TINY_FONT_BOLD);
  textAlign(CENTER, CENTER);
  text("-1", 0, getRadiusForSentiment(-1));
  text("0", 0, getRadiusForSentiment(0));
  text("1", 0, getRadiusForSentiment(1));

  noFill();
  stroke(DARK_GRAY);
  strokeWeight(2);
  line(0, getRadiusForSentiment(-1) + 7, 0, getRadiusForSentiment(0) - 7);
  line(0, getRadiusForSentiment(0) + 7, 0, getRadiusForSentiment(1) - 7);
  line(0, getRadiusForSentiment(1) + 7, 0, END_RADIUS + 50);

  strokeWeight(1);
  float centerY = getRadiusForSentiment(0);
  line(-7, centerY, -15, centerY);
  line(7, centerY, 15, centerY);

  pushMatrix();
  float labelY = (getRadiusForSentiment(-1) + getRadiusForSentiment(0)) / 2;
  translate(10, labelY);
  rotate(HALF_PI);
  textFont(TINY_FONT);
  text("Negative", 0, 0);
  popMatrix();

  pushMatrix();
  labelY = (getRadiusForSentiment(0) + getRadiusForSentiment(1)) / 2;
  translate(-7, labelY);
  rotate(HALF_PI);
  textFont(TINY_FONT);
  text("Positive", 0, 0);
  popMatrix();

  text("Avg Article Sentence Sentiment\n(each dot is an article arranged in a histogram)", 0, END_RADIUS + 70);

  popStyle();
  popMatrix();
}


/**
 * Draw the quote at the bottom of the graphic.
 */
void drawBottom() {
  pushMatrix();
  pushStyle();

  translate(0, BOTTOM_BOX_Y);

  noStroke();
  fill(LIGHT_GRAY);
  rectMode(CORNER);
  rect(0, 0, width, height - BOTTOM_BOX_Y);

  fill(NEAR_BLACK);
  textFont(MEDIUM_FONT);
  textAlign(CENTER, CENTER);
  text(
      "\"If everything is amplified, we hear nothing.\" - Jon Stewart",
      width / 2,
      (height - BOTTOM_BOX_Y) / 2
  );

  popStyle();
  popMatrix();
}
