/**
 * Constants for the news flower data visualization.
 *
 * Constants for the news flower data visualization, specifying colors, fonts, and key positions
 * within the visualization.
 *
 * Released under the MIT license. See LICENSE.md for more information.
 */

final String SOURCES_CSV_LOC = "sources_ranked.csv";
final String ARTICLES_CSV_LOC = "articles_with_sentiment.csv";

final int BACKGROUND_COLOR = #FAFAFA;
final int NEAR_BLACK = #333333;
final int WHITE = #FAFAFA;
final int LIGHT_GRAY = #E0E0E0;
final int DARK_GRAY = #505050;

final int CENTER_FLOWER_X = 225;
final int CENTER_FLOWER_Y = 225;
final int START_RADIUS = 35;
final int END_RADIUS = 180;

final int BOTTOM_BOX_Y = CENTER_FLOWER_Y + END_RADIUS + 100;

PFont TINY_FONT;
PFont TINY_FONT_BOLD;
PFont MEDIUM_FONT;

List<Integer> SOURCE_COLORS;
Map<String, String> NAME_REWRITES;


/**
 * Load "constants" which require processing to be initialized before their value can be set.
 */
void loadSemiconstants() {
  TINY_FONT = loadFont("Lato-Regular-10.vlw");
  TINY_FONT_BOLD = loadFont("Lato-Heavy-10.vlw");
  MEDIUM_FONT = loadFont("Lato-Regular-16.vlw");

  SOURCE_COLORS = new ArrayList<>();
  SOURCE_COLORS.add(#A6CEE3);
  SOURCE_COLORS.add(#B2DF8A);
  SOURCE_COLORS.add(#1F78B4);
  SOURCE_COLORS.add(#33A02C);
  SOURCE_COLORS.add(#FB9A99);
  SOURCE_COLORS.add(#E31A1C);
  SOURCE_COLORS.add(#FDBF6F);
  SOURCE_COLORS.add(#FF7F00);
  SOURCE_COLORS.add(#CAB2D6);
  SOURCE_COLORS.add(#6A3D9A);

  NAME_REWRITES = new HashMap<>();
  NAME_REWRITES.put("New York Times", "NYT");
  NAME_REWRITES.put("Wall Street Journal", "WSJ");
}
