WITH WFR_INDEX AS (
	SELECT PERSON_ID, MIN(DRUG_EXPOSURE_START_DATE) AS WFR_first_date
	FROM DRUG_EXPOSURE
	WHERE DRUG_CONCEPT_ID IN (
		SELECT DESCENDANT_CONCEPT_ID
		FROM CONCEPT_ANCESTOR WHERE ANCESTOR_CONCEPT_ID = 1310149 /*warfarin*/)
	GROUP BY PERSON_ID),
AF_INDEX AS(
	SELECT person_id,MIN(condition_start_date) AS AF_first_date FROM condition_occurrence
	WHERE condition_concept_id = 313217
	GROUP BY person_id)

SELECT a.person_id,WFR_first_date,AF_first_date FROM WFR_INDEX AS a
INNER JOIN AF_INDEX AS b
ON a.person_id = b.person_id
WHERE WFR_first_date > AF_first_date;
