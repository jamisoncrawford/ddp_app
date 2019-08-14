Predicting Salaries with Holland Codes
========================================================
author: Jamison R. Crawford, MPA
date: 14 August 2019
autosize: true

The Question
========================================================

<br>

**Have you ever wondered:**

## What careers best fit my personality?

## How much do others like me earn each year?

<br>

**We have the data...**



The Data
========================================================

## The U.S. Department of Labor

We can model the relationship between personality and salary.

* Bureau of Labor Statistics
    - [2018 National Occupational Employment & Wages](https://www.bls.gov/oes/current/oes_nat.htm#00-0000)
* Occupational Information Network
    - [O*NET 24.0 Database: "Content Model Interest"](https://www.onetcenter.org/dictionary/24.0/excel/interests.html)
    
Every occupation has a **Standard Occupational Classification**.

O\*NET occupations have **Holland Codes**, i.e. 6 personality traits. 


The Model
========================================================



Once joined, we model `wage` as a function of each Holland type.


```r
m <- lm(wage ~ ar + co + en + iv + re + so, mrg)
```


```r
data.frame(m$coef)
```

```
               m.coef
(Intercept) 45927.547
ar          -1806.498
co          -3812.028
en           4914.710
iv           9900.074
re          -3011.119
so          -1655.726
```

The App
========================================================

In Shiny, users can predict salaries based on their Holland codes.

<center>

<iframe src="https://uruguayguy.shinyapps.io/shiny_app/" width="100%" height="425px"></iframe>

<br>

Visit the [app](https://uruguayguy.shinyapps.io/shiny_app/). View the [documentation](https://github.com/jamisoncrawford/ddp_app).

</center>
