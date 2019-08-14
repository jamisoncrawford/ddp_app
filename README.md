# Course Project: Predicting Salaries with Holland Codes

## Overview

This Shiny app uses median annual wages from U.S. occupations in 2018 and Holland Occupational Themes rated by professional incumbents to model and predicts annual income based on users' personality traits.

## Using the App

The app features six statements.  Each statement is accompanied by a slider input for a 7-point [Likert scale](https://en.wikipedia.org/wiki/Likert_scale):

* `7` indicates "Strongly Agree"
* `4` indicates "No Opinion"
* `1` indicates "Strongly Disagree"

By default, each slider is set to `4`, or "No Opinion".  Upon responding, "Predicted Annual Salary" will update in the main panel and the "Predicted Salary" line will adjust for each visualization.  The "Trend Line" indicates the path of a multivariate linear regression modeling median annual salary as a function of each personality dimension (e.g. "Investigative").

Users may disable the "Predicted Salary" and "Trend Line" using the checkboxes in the left side panel.

## Sources & Methods

National salary data were retrieved from the U.S. Department of Labor, Bureau of Labor Statistics' [May, 2018 National Occupational Employment and Wage Estimates, United States](https://www.bls.gov/oes/current/oes_nat.htm#00-0000) dataset.

Occupational incumbents' personality traits, measured with [Holland Codes](https://en.wikipedia.org/wiki/Holland_Codes), were retrieved from the U.S. Department of Labor, Occupational Information Network's [Interests](https://www.onetcenter.org/dictionary/24.0/excel/interests.html) dataset in the O\*NET 24.0 Database.

Occupations were joined on their [Standard Occupational Classification, or SOC](https://www.onetcenter.org/dictionary/24.0/excel/interests.html) codes.

<a href="https://www.codecogs.com/eqnedit.php?latex=Salary&space;=&space;Artistic&space;&plus;&space;Conventional&space;&plus;&space;Enterprising&space;&plus;&space;Investigative&space;&plus;&space;Realistic&space;&plus;&space;Social" target="_blank"><img src="https://latex.codecogs.com/gif.latex?Salary&space;=&space;Artistic&space;&plus;&space;Conventional&space;&plus;&space;Enterprising&space;&plus;&space;Investigative&space;&plus;&space;Realistic&space;&plus;&space;Social" title="Salary = Artistic + Conventional + Enterprising + Investigative + Realistic + Social" /></a>
