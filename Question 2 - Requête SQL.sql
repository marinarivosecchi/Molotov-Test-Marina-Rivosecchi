-- Sélection des utilisateurs âgés de plus de 30 ans, inscrits sur Molotov depuis moins de 12 mois,
-- ayant visionné plus de 2h de film sur mobile en Mai 2023
WITH UserCriteria AS (
    SELECT U.USER_ID
    FROM User U
    WHERE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM U.BIRTHDAY) > 30 -- Plus de 30 ans
    AND TIMESTAMPDIFF(MONTH, U.CREATED_AT, CURRENT_DATE) < 12 -- Inscrit depuis moins de 12 mois
    AND EXISTS (
        SELECT 1
        FROM Watch W
        WHERE W.USER_ID = U.USER_ID
        AND MONTH(W.DATE_DAY) = 5 -- Visionné en Mai 2023
        AND W.DEVICE_TYPE = 'Mobile' -- Sur mobile
        AND W.DURATION > 7200 -- Plus de 2h de visionnage
    )
    );

-- Sélection des utilisateurs abonnés à Molotov Extra
MolotovExtraSubscribers AS (
    SELECT DISTINCT S.USER_ID 
    FROM Subscription S
    WHERE PRODUCT_NAME = 'Molotov Extra'
    AND (SUBSCRIPTION_END_DATE IS NULL OR SUBSCRIPTION_END_DATE > CURRENT_DATE) -
),

-- Calcul de la part d'utilisateurs abonnés à Molotov Extra parmi les utilisateurs répondant aux critères
SELECT 
    COUNT(DISTINCT UC.USER_ID) AS Nombre_Utilisateurs,
    COUNT(DISTINCT ES.USER_ID) AS Utilisateurs_Abonnés_Extra,
    COUNT(DISTINCT ES.USER_ID) / COUNT(DISTINCT UC.USER_ID) AS Part_Abonnés_Extra
FROM UserCriteria UC
LEFT JOIN MolotovExtraSubscribers ES ON UC.USER_ID = ES.USER_ID;
