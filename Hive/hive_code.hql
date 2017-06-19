--(1)
--(Create schema in Hive)
CREATE DATABASE nasa_server_logs;

DROP TABLE IF EXISTS apachelog;

CREATE TABLE apachelog (
  host STRING,
  identity STRING,
  user STRING,
  time STRING,
  request STRING,
  status STRING,
  size STRING
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^ ]*) ([^ ]*) ([^ ]*) (-|\\[[^\\]]*\\]) ([^ \"]*|\"[^\"]*\") (-|[0-9]*) (-|[0-9]*)",
  "output.format.string" = "%1$s %2$s %3$s %4$s %5$s %6$s %7$s"
)
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH 'july.txt'
OVERWRITE INTO TABLE apachelog;





--(2)
--(Query: Count all records with a status code of 200 in August 1995)
SELECT COUNT(*)
  FROM apachelog
 WHERE status = "200"
   AND time LIKE '%Aug%';

--(Result)
--2,797,974





--(3)
--(Query: Count number of distinct source IPs that made requests to server in September 1995)
SELECT COUNT(DISTINCT host)
  FROM apachelog
 WHERE time LIKE '%Sep%';


--(Result)
--81,982




--(4)
--(Query: Find most requested URL in 1995)
SELECT request, COUNT(request) AS request_count
  FROM apachelog
 WHERE time LIKE '%1995%'
GROUP BY request
ORDER BY request_count DESC
LIMIT 1;

--(Result)
--"GET /images/NASA-logosmall.gif HTTP/1.0"	622560






--(5)
--(Query: Plot number of requests made in a day for every day in October 1995)
INSERT OVERWRITE LOCAL DIRECTORY '/home/training/temp'
--ROW FORMAT DELIMITED
--FIELDS TERMINATED BY '\t'
--LINES TERMINATED BY '\n'
--STORED AS TEXTFILE
SELECT COUNT(request), SUBSTR(time,2,2)
  FROM apachelog
 WHERE time LIKE '%Oct%'
GROUP BY SUBSTR(time,2,2);

--(Result)
--Data for histogram was derived from preceding query, and then saved to files 000000_0 and 000001_0.
--Histogram is generated in R Markdown (Hive - October Requests Histogram.Rmd) and displayed in the file Hive_-_October_Requests_Histogram.pdf
