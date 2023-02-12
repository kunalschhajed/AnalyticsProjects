#Highest and Lowest Categorical downloads
#Highest:                                               
select 
category, sum(MaximumInstalls) 
from 
googleplaystore
group by 
category
order by 
sum(MaximumInstalls) desc 
limit 1;


#Lowest:
select 
category, sum(MaximumInstalls) 
from 
googleplaystore
group by 
category
order by 
sum(MaximumInstalls) asc 
limit 1;

#which apps have the 5 topmost ratings
select 
appname
from googleplaystore as b
inner join 
(select 
distinct rating as rating_app
from 
googleplaystore
order by 
rating_app desc
limit 5) as a on a.rating_app = b.rating;


#Which developers developed the top 5 APPs that had the highest installation rate
select 
AppName
from 
googleplaystore
order by 
MaximumInstalls desc
limit 5;


#Apps that have lower than average Rating yet Higher than average Installs
select AppName, Rating, MaximumInstalls
from s1.GooglePlaystore
where Rating<(select avg(Rating) from s1.GooglePlaystore)
and MaximumInstalls>(select avg(MaximumInstalls) from s1.GooglePlaystore)
order by MaximumInstalls DESC;


#Number of apps in each category        
SELECT
Category,
COUNT(*) as Count
FROM Google.Playstore
GROUP BY Category;

# 5B+ Downloads
SELECT
category,
AppName,
Free,
Rating,
RatingCount, 
MaximumInstalls
FROM Google.Playstore
WHERE MaximumInstalls > 5000000000;


#Download Distribution
SELECT 
sum(maximuminstalls < 100) as '< 100 Downloads', 
sum(maximuminstalls between 100 and 499) as '100 - 499 Downloads',
sum(maximuminstalls between 500 and 999) as '500 - 999 Downloads',
sum(maximuminstalls between 1000 and 4999) as '1,000 - 4,999 Downloads',
sum(maximuminstalls between 5000 and 9999) as '5,000 - 9,999 Downloads',
sum(maximuminstalls between 10000 and 49999) as '10,000 - 49,999 Downloads',
sum(maximuminstalls between 50000 and 149999) as '50,0000 - 149,999 Downloads',
sum(maximuminstalls between 150000 and 499999) as '150,000 - 499,999 Downloads',
sum(maximuminstalls between 500000 and 999999) as '500,000 - 999,999 Downloads',
sum(maximuminstalls >= 1000000) as '>= 1,000,000 Downloads'
FROM Google.Playstore;

#percentage of editors choice?
select sum(EditorsChoice) / count(*) 
from GooglePlaystore;
#result: less than .04%

#average installs for 'editors choice apps'
select avg(MaximumInstalls)
from GooglePlaystore
where EditorsChoice = 1;
#result: 79,058,974.24 installs


#average ratings for 'editors choice apps'
select avg(Rating)
from GooglePlaystore
where EditorsChoice = 1 and RatingCount > 0;
#result: 4.33 stars

#average ratings for apps with ads supported
select avg(Rating)
from GooglePlaystore
where AdSupported = 1 and RatingCount > 0;
#result: 4.12 stars

#average ratings for apps without ads supported
select avg(Rating)
from GooglePlaystore
where AdSupported = 0 and RatingCount > 0;
#result: 4.07 stars


#average installs for apps with ads supported
select avg(MaximumInstalls)
from GooglePlaystore
where AdSupported = 1;
#result: 388,416.30 installs

#average installs for apps without ads supported
select avg(MaximumInstalls)
from GooglePlaystore
where AdSupported = 0;
#result: 252,656.03 installs

#how many apps have both ads supported and in app purchases?
select count(AppName) 
from GooglePlaystore
where AdSupported = 1 and InAppPurchases = 1;
#result: 141,648

#what percentage of apps support ads?
select sum(AdSupported) / count(*)
from GooglePlaystore;
#result: 49.75%

#what percentage of apps have in app purchases?
select sum(InAppPurchases) / count(*)
from GooglePlaystore;
#result: 8.44%

#average ratings for apps with in app purchases
select avg(Rating)
from GooglePlaystore
where InAppPurchases = 1 and RatingCount > 0;
#result: 4.08 stars

#average ratings for apps without in app purchases
select avg(Rating)
from GooglePlaystore
where InAppPurchases = 0 and RatingCount > 0;
#result: 4.11 stars

#average installs for apps with in app purchases
select avg(MaximumInstalls)
from GooglePlaystore
where InAppPurchases = 1;
#result: 1,569,007.94 installs

#average installs for apps without in app purchases
select avg(MaximumInstalls)
from GooglePlaystore
where InAppPurchases = 0;
#result: 205,025 installs

#what percentage of apps have 0 rating count?
select (select count(RatingCount)
from GooglePlaystore
where RatingCount = 0) / count(*)
from GooglePlaystore;
#result: 45.82% have no ratings






