-- Selection of users aged over 30, registered on Molotov for less than 12 months, having watched 
-- more than 2 hours of film on mobile in May 2023
WITH UserCriteria AS (
    SELECT U.ID as USER_ID
    FROM User U
    WHERE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM U.BIRTHDAY) > 30 -- More than 30 y/o
    AND DATE_DIFF( CREATED_AT, CURRENT_DATE, MONTH) < 12 -- Registered for less than 12 months
    AND EXISTS (
        SELECT 1
        FROM Watch W
        WHERE W.USER_ID = U.ID
        AND EXTRACT(YEAR FROM W.DATE_DAY) = 2023 -- Viewed in 2023
        AND EXTRACT(MONTH FROM W.DATE_DAY) = 5 -- Viewed in May
        AND W.DEVICE_TYPE = 'phone' -- With Mobile devices
        AND W.PROGRAM_KIND = ‘Films’ -- Watched films
        GROUP BY W.USER_ID
        HAVING SUM(W.DURATION) > 7200 -- More than 2h of total viewing time
    )),
-- Selection of users that meet criteria and are currently subscribed to Molotov Extra
MolotovExtraSubscribers AS (
    SELECT DISTINCT S.USER_ID 
    FROM Subscription S
    INNER JOIN UserCriteria UC -- From users that meet criteria, only those that are subscribed
    ON UC.USER_ID = S.USER_ID
    WHERE PRODUCT_NAME = 'Molotov Extra' -- Subscribed to Molotov Extra
    AND (SUBSCRIPTION_END_DATE IS NULL OR SUBSCRIPTION_END_DATE > CURRENT_DATE) -- Current subscription 
),
-- Calculation of the share of users subscribed to Molotov Extra among users meeting the above criteria
SELECT 
    COUNT(DISTINCT UC.USER_ID) AS Total_Users, -- Count of unique users that meet criteria
    COUNT(DISTINCT ES.USER_ID) AS Molotov_Extra_Total_Users, -- Count of unique users subscribed to Molotov Extra
    COUNT(DISTINCT ES.USER_ID) / COUNT(DISTINCT UC.USER_ID) AS Share_of_Molotov_Extra_Users
FROM UserCriteria UC
LEFT JOIN MolotovExtraSubscribers ES ON UC.USER_ID = ES.USER_ID;
