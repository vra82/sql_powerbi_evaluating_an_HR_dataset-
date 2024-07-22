-- joining all the tables
use work;
SELECT * 
FROM absenteeism_at_work AS a
LEFT JOIN compensation AS c 
ON a.ID = c.ID
LEFT JOIN reasons AS r
ON a.`Reason for absence` = r.Number
;
-- find the healthiest employees for the bonus
select * from absenteeism_at_work
where `Social drinker`= 0 and `Social smoker` = 0
and `Body mass index` between 18 and 25
and `Absenteeism time in hours` < (select avg(`Absenteeism time in hours`) from absenteeism_at_work);

-- compensation rate increase for non-smokers/budget $983,221 so 68 cent increase per hour / $1414.4 per year
select count(*) as non_smokers from absenteeism_at_work
where `Social smoker`=0
;
-- optimize this query

SELECT 
a.`ID`,
r.`reason`,
`Month of absence`,
`Body mass index`,
CASE WHEN `Body mass index` < 18.5 THEN 'UNDERWEIGHT'
     WHEN `Body mass index` between  18.5 and 24.9 THEN 'Healthy'
     WHEN `Body mass index` between  24.9 and 30 THEN 'Overweight'
     WHEN `Body mass index` between 30.1 and 40 THEN 'Obese'
     ELSE 'UNKNOWN' END AS `BMI category`,
CASE WHEN `Month of absence` IN(12,1,2) then 'winter'
     WHEN `Month of absence` IN(3,4,5) then 'spring'
     WHEN `Month of absence` IN(6,7,8) then 'summer'
     WHEN `Month of absence` IN(9,10,11) then 'fall'
     else 'unknown' END as season_names,
     
`Month of absence`,
`Day of the week`,
`Transportation expense`,
`Education`,
`Son`,
`Social drinker`,
`Social smoker`,
`Pet`,
`disciplinary failure`,
`Age`,
`Work load Average/day`,
`Absenteeism time in hours`

FROM absenteeism_at_work AS a
LEFT JOIN compensation AS c 
ON a.ID = c.ID
LEFT JOIN reasons as r
ON a.`Reason for absence` = r.Number;

