cat NYPD_Complaint_Data_Current__Year_To_Date_.tsv \
  | clickhouse-local --structure "CMPLNT_NUM Nullable(String), ADDR_PCT_CD Nullable(String), BORO_NM Nullable(String), CMPLNT_FR_DT Nullable(String), CMPLNT_FR_TM Nullable(String), CMPLNT_TO_DT Nullable(String), CMPLNT_TO_TM Nullable(String), CRM_ATPT_CPTD_CD Nullable(String), HADEVELOPT Nullable(String), HOUSING_PSA Nullable(String), JURISDICTION_CODE Nullable(String), JURIS_DESC Nullable(String), KY_CD Nullable(String), LAW_CAT_CD Nullable(String), LOC_OF_OCCUR_DESC Nullable(String), OFNS_DESC Nullable(String), PARKS_NM Nullable(String), PATROL_BORO Nullable(String), PD_CD Nullable(String), PD_DESC Nullable(String), PREM_TYP_DESC Nullable(String), RPT_DT Nullable(String), STATION_NAME Nullable(String), SUSP_AGE_GROUP Nullable(String), SUSP_RACE Nullable(String), SUSP_SEX Nullable(String), TRANSIT_DISTRICT Nullable(String), VIC_AGE_GROUP Nullable(String), VIC_RACE Nullable(String), VIC_SEX Nullable(String), X_COORD_CD Nullable(String), Y_COORD_CD Nullable(String), Latitude Nullable(String), Longitude Nullable(String), Lat_Lon Nullable(String), New_Georeferenced_Column Nullable(String)" --table='input' --input-format='TSVWithNames' \
  --input_format_max_rows_to_read_for_schema_inference=2000 \
  --query "
    WITH (CMPLNT_FR_DT || ' ' || CMPLNT_FR_TM) AS CMPLNT_START,
     (CMPLNT_TO_DT || ' ' || CMPLNT_TO_TM) AS CMPLNT_END
    SELECT
      CMPLNT_NUM                                  AS complaint_number,
      ADDR_PCT_CD                                 AS precinct,
      BORO_NM                                     AS borough,
      parseDateTime64BestEffort(CMPLNT_START)     AS complaint_begin,
      parseDateTime64BestEffortOrNull(CMPLNT_END) AS complaint_end,
      CRM_ATPT_CPTD_CD                            AS was_crime_completed,
      HADEVELOPT                                  AS housing_authority_development,
      HOUSING_PSA                                 AS housing_level_code,
      JURISDICTION_CODE                           AS jurisdiction_code, 
      JURIS_DESC                                  AS jurisdiction,
      KY_CD                                       AS offense_code,
      LAW_CAT_CD                                  AS offense_level,
      LOC_OF_OCCUR_DESC                           AS location_descriptor,
      OFNS_DESC                                   AS offense_description, 
      PARKS_NM                                    AS park_name,
      PATROL_BORO                                 AS patrol_borough,
      PD_CD,
      PD_DESC,
      PREM_TYP_DESC                               AS location_type,
      toDate(parseDateTimeBestEffort(RPT_DT))     AS date_reported,
      STATION_NAME                                AS transit_station,
      SUSP_AGE_GROUP                              AS suspect_age_group,
      SUSP_RACE                                   AS suspect_race,
      SUSP_SEX                                    AS suspect_sex,
      TRANSIT_DISTRICT                            AS transit_district,
      VIC_AGE_GROUP                               AS victim_age_group,   
      VIC_RACE                                    AS victim_race,
      VIC_SEX                                     AS victim_sex,
      X_COORD_CD                                  AS NY_x_coordinate,
      Y_COORD_CD                                  AS NY_y_coordinate,
      Latitude,
      Longitude
    FROM input" \
  | clickhouse-client --query='INSERT INTO NYPD_Complaint FORMAT TSV'