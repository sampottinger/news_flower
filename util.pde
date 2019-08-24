/**
 * Miscellaneous utilty functions to support the news flower visualization.
 *
 * Miscellaneous utilty functions to support the news flower visualization, offering help with
 * calculation of offsets or text manipulation.
 *
 * Released under the MIT license. See LICENSE.md for more information.
 */


/**
 * Get the "short" name for a news source.
 *
 * @param sourceName The "full" or "long" name for a news source.
 * @return The "short" name for a news source.
 */
String getSourceShortName(String sourceName) {
  return NAME_REWRITES.getOrDefault(sourceName, sourceName);
}


/**
 * Determine the rotation to apply for a news source.
 *
 * @param index The index of the source (the number of news source drawn prior to this one).
 * @return Radian rotation to apply when drawing the news source.
 */
float getIndexRotation(int index) {
  int maxIndex = dataModel.getSortedSourceNames().size() + 1;
  return map(index, 0, maxIndex, 0, TWO_PI) + HALF_PI;
}


/**
 * Determine how far from center an article should be given its senitment.
 *
 * @param sentiment The sentiment for the article (from -1 to 1).
 * @return The distance from center in the flower in pixels.
 */
float getRadiusForSentiment(float sentiment) {
  return map(sentiment, -1, 1, START_RADIUS, END_RADIUS);
}


/**
 * Determine how far from petal center line an article should be.
 *
 * @param priorArticles The number of articles to be drawn prior to this one from the same news
 *    source with a similar sentiment.
 * @return Offset from petal center in pixels.
 */
float generateVerticalOffsetForSentiment(int priorArticles) {
  float offset = priorArticles * 0.5;
  return (offset % 2 == 0 ? -1 : 1) * offset;
}
