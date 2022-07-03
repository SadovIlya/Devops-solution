SELECT DISTINCT Lat_Lon FROM default.NYPD_Complaint

INSERT INTO default.geocoded_random (uniq_lat_lon) SELECT DISTINCT default.NYPD_Complaint.Lat_Lon FROM default.NYPD_Complaint 

INSERT INTO default.geocoded_random (random_string) VALUES ('fas')




TRUNCATE TABLE default.geocoded_random

SELECT uniq_lat_lon, random_string
FROM `default`.geocoded_random

SELECT fuzzBits(materialize('abacaba'), 0.1)
FROM numbers(3)