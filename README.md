News Flower
====================================================================================================
Visualization of news sentiment across various news sources.

<br>

Purpose
----------------------------------------------------------------------------------------------------
Visualization in the form of a flower that describes the volume and sentiment polarity of articles published by different news sources. This allows users to understand which sources not only publish more work within a time period but if that work has high, low, or neutral sentiment polarity. Uses [who-wrote-this-news-crawler](https://github.com/datadrivenempathy/who-wrote-this-news-crawler). See that project for more information about the data itself.

<br>

Local Development Environment
----------------------------------------------------------------------------------------------------
Visualization requires this project requires use of the [Sam Pottinger Processing](https://github.com/sampottinger/processing) branch and installation instructions are provided at that branch's README. In order to run the python data analysis steps, one will need [Jupyter](https://jupyter.org/), [Pandas](https://pandas.pydata.org/), [Matplotlib](https://matplotlib.org/), and [TextBlob](https://textblob.readthedocs.io/en/dev/). Users looking for a shortcut may consider installing [Anaconda](https://www.anaconda.com/distribution/).

<br>

Execution
----------------------------------------------------------------------------------------------------
One can execute the Jupyter notebooks by running jupyter notebook within the data directory. To execute the visualization, simply open this repository within Processing and run.

<br>

Deployment
----------------------------------------------------------------------------------------------------
Though the visualization will display live when the sketch is run locally, the result can be "deployed" through the `news_flower.png` file which is generated from the sketch.

<br>


Structure
----------------------------------------------------------------------------------------------------
Note that the Processing sketch contents live at the root of this directory. Data preparation, artifacts, and logic for statistical tests lives under the data directory.

<br>

Coding Standards
----------------------------------------------------------------------------------------------------
Please try to include JavaDoc where possible and commenting within the Jupyter notebooks as appropriate.

<br>

Open Source Libraries Used
----------------------------------------------------------------------------------------------------
This project uses the following:

 - [Matplotlib](https://matplotlib.org/) under the [PSF license](https://docs.python.org/3/license.html).
 - [Pandas](https://pandas.pydata.org/) under the [BSD 3 Clause license](https://pandas.pydata.org/pandas-docs/stable/getting_started/overview.html#license).
 - [Processing core](https://processing.org) under the [LGPL license](https://github.com/processing/processing/blob/master/license.txt).
 - [TextBlob](https://textblob.readthedocs.io/en/dev/) under the [MIT license](https://github.com/sloria/TextBlob/blob/dev/LICENSE).
 - [who-wrote-this-news-crawler](https://github.com/datadrivenempathy/who-wrote-this-news-crawler) under the [MIT license](https://github.com/datadrivenempathy/who-wrote-this-news-crawler/blob/master/LICENSE.md).

This project also uses colors selected via [ColorBrewer 2](https://colorbrewer2.org) and uses the [Lato free fonts](http://www.latofonts.com/lato-free-fonts/) under the [SIL license](https://scripts.sil.org/cms/scripts/page.php?item_id=OFL_web).
