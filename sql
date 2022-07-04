SELECT DISTINCT Lat_Lon FROM default.NYPD_Complaint

SELECT COUNT(DISTINCT Latitude, Longitude)  FROM default.NYPD_Complaint

SELECT * FROM default.NYPD_Complaint limit 1



INSERT INTO default.geocoded_random (Latitude, Longitude) SELECT DISTINCT Latitude, Longitude FROM NYPD_Complaint

UPDATE geocoded_random SET random_string = rand() WHERE uniq_lat_lon IS NOT NULL


INSERT INTO default.geocoded_random (uniq_lat_lon) VALUES ('fas')

SELECT COUNT(DISTINCT NYPD_Complaint.Lat_Lon)  FROM NYPD_Complaint

SELECT COUNT(*)  FROM geocoded_random


TRUNCATE TABLE default.geocoded_random

SELECT *
FROM geocoded_random

DROP TABLE default.geocoded_random


ALTER TABLE default.geocoded_random UPDATE random = rand()  WHERE Latitude IS NOT NULL
