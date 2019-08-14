# Course Project: Predicting Salaries with Holland Codes

## Overview

This Shiny app uses median annual wages from U.S. occupations in 2018 and Holland Occupational Themes rated by professional incumbents to model and predicts annual income based on users' personality traits.

## Using the App

The app features six statements.  Each statement is accompanied by a slider input for a 7-point [Likert scale](https://en.wikipedia.org/wiki/Likert_scale):

* `7` indicates "Strongly Agree"
* `4` indicates "No Opinion" or "Neutral"
* `1` indicates "Strongly Disagree"

By default, each slider is set to `4`, or "No Opinion".  Upon completion, "Predicted Annual Salary" will update in the main panel and the "Predicted Salary" line will adjust for each visualization.  The "Trend Line" indicates the path of a multivariate linear regression modeling median annual salary as a function of each personality dimension (e.g. "Artistic", "Investigative").

Users may disable the "Predicted Salary" and "Trend Line" using the checkboxes in the left side panel.

## Sources & Methods

