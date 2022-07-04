SELECT DISTINCT Lat_Lon FROM default.NYPD_Complaint

INSERT INTO default.geocoded_random (uniq_lat_lon) SELECT DISTINCT NYPD_Complaint.Lat_Lon FROM NYPD_Complaint 

UPDATE geocoded_random SET random_string = rand() WHERE uniq_lat_lon IS NOT NULL


INSERT INTO default.geocoded_random (uniq_lat_lon) VALUES ('fas')

SELECT COUNT(DISTINCT NYPD_Complaint.Lat_Lon)  FROM NYPD_Complaint

SELECT COUNT(*)  FROM geocoded_random


TRUNCATE TABLE default.geocoded_random

SELECT uniq_lat_lon, random_string
FROM geocoded_random


ALTER TABLE default.geocoded_random UPDATE random_string = rand()  WHERE uniq_lat_lon IS NOT NULL

UPDATE default.geocoded_random SET random_string = rand() WHERE uniq_lat_lon IS NOT NULL