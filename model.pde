/**
 * Structures to help with processing visualization data.
 *
 * Structures to help with processing visualization data, specifically the sentiment scoring for
 * news articles.
 *
 * Released under the MIT license. See LICENSE.md for more information.
 */

import java.util.*;


/**
 * Primary interface into visualization data.
 */
class DataModel {

  private List<String> sortedSourceNames;
  private Map<String, NewsSource> articlesBySource;

  /**
   * Create a new data model with visualization data loaded into memory.
   */
  public DataModel() {
    loadSortedSources();
    loadArticles();
  }

  /**
   * Get the names of the news sources in the order that they should appear.
   *
   * @return List of news source names in the order in which they should appear inside the
   *    visualization. Note that these are full names.
   */
  public List<String> getSortedSourceNames() {
    return sortedSourceNames;
  }

  /**
   * Get information including article data for a news source.
   *
   * @param sourceName The full name of the news source.
   * @return Information about the news source including article info.
   */
  public NewsSource getSource(String sourceName) {
    return articlesBySource.get(sourceName);
  }

  /**
   * Load information about the news soruces to appear within the visualization.
   */
  private void loadSortedSources() {
    sortedSourceNames = new ArrayList<>();

    Table sourcesRankedTable = loadTable(SOURCES_CSV_LOC, "header");
    for (TableRow row : sourcesRankedTable.rows()) {
      sortedSourceNames.add(row.getString("source"));
    }
  }

  /**
   * Load information about the articles posted per news source.
   */
  private void loadArticles() {
    articlesBySource = new HashMap<>();
    Map<String, List<Article>> articlesBySourceScaffold = new HashMap<>();

    // Get articles themselves
    Map<String, Map<Float, Integer>> counter = new HashMap<>();
    Table articles_with_sentiment = loadTable(ARTICLES_CSV_LOC, "header");
    for (TableRow row : articles_with_sentiment.rows()) {
      String source = row.getString("source");

      if (!counter.containsKey(source)) {
        counter.put(source, new HashMap<>());
      }
      Map<Float, Integer> sourceCounter = counter.get(source);

      Float descriptionPolarity = row.getFloat("descriptionPolarity");
      float roundedPolarity = round(descriptionPolarity * 10) / 10.0;

      if (!sourceCounter.containsKey(roundedPolarity)) {
        sourceCounter.put(roundedPolarity, 0);
      }
      int numCollisions = sourceCounter.get(roundedPolarity);
      sourceCounter.put(roundedPolarity, numCollisions + 1);

      Article newArticle = new Article(source, descriptionPolarity, numCollisions);

      if (!articlesBySourceScaffold.containsKey(source)) {
        articlesBySourceScaffold.put(source, new ArrayList<>());
      }

      if (!descriptionPolarity.isNaN()) {
        articlesBySourceScaffold.get(source).add(newArticle);
      }
    }

    // Create the source objects
    for (String sourceName : articlesBySourceScaffold.keySet()) {
      articlesBySource.put(
        sourceName,
        new NewsSource(sourceName, articlesBySourceScaffold.get(sourceName))
      );
    }
  }

}


/**
 * Information about a news source.
 */
class NewsSource {

  private final String sourceName;
  private final List<Article> articles;

  /**
   * Create a new record of a news source to be visualized.
   *
   * @param newSourceName The full name of the news source.
   * @param newArticles The articles published by the news source.
   */
  public NewsSource(String newSourceName, List<Article> newArticles) {
    sourceName = newSourceName;
    articles = newArticles;
  }

  /**
   * Get the full name of this news source.
   *
   * @return The "full" or "long" human-readable name for this news source.
   */
  public String getSourceName() {
    return sourceName;
  }

  /**
   * Get the articles from this news source.
   *
   * @return The articles published by this news source.
   */
  public List<Article> getArticles() {
    return articles;
  }

}


/**
 * Information about a single article published by a news source.
 */
class Article {

  private final String source;
  private final float polarity;
  private final int segmentIndex;

  /**
   * Create a new record of an article.
   *
   * @param newSource The "full" or "long" name of the news source that published this article.
   * @param newPolarity The sentiment polarity (from -1 to 1) assessed for this article.
   * @param newSegmentIndex The number of articles from the same source registered with similar
   *    polarity prior to creating a record for this article.
   */
  public Article(String newSource, float newPolarity, int newSegmentIndex) {
    source = newSource;
    polarity = newPolarity;
    segmentIndex = newSegmentIndex;
  }

  /**
   * Get the full name of the news source that published this article.
   *
   * @return The "full" or "long" name of the news source that published this article.
   */
  public String getSource() {
    return source;
  }

  /**
   * Get the average sentence polarity of this article.
   *
   * @return The sentiment polarity (from -1 to 1) assessed for this article.
   */
  public float getPolarity() {
    return polarity;
  }

  /**
   * Get the number of articles with similar polarity registered prior to this article.
   *
   * @return The number of articles from the same source "registered" (Article object created) with
   *    similar polarity prior to creating a record for this article.
   */
  public int getSegmenetIndex() {
    return segmentIndex;
  }

}
