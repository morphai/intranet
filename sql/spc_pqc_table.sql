SELECT
    document_id AS ID,
    JSON_VALUE(DATA, '$.issueDate') AS Date,
    JSON_VALUE(DATA, '$.inspectionCycle') AS Cycle,
    JSON_VALUE(DATA, '$.model') AS Model,
    JSON_VALUE(DATA, '$.partName') AS PartName,
    JSON_VALUE(DATA, '$.toolingNo') AS ToolingNo,
    JSON_VALUE(DATA, '$.cavity') AS Cavity,
    CAST(JSON_VALUE(DATA, '$.spc1') AS DECIMAL) AS SPC1,
    CAST(JSON_VALUE(DATA, '$.spc2') AS DECIMAL) AS SPC2,
    CAST(JSON_VALUE(DATA, '$.spc3') AS DECIMAL) AS SPC3,
    CAST(JSON_VALUE(DATA, '$.spc4') AS DECIMAL) AS SPC4,
    CAST(JSON_VALUE(DATA, '$.spc5') AS DECIMAL) AS SPC5,
    CAST(JSON_VALUE(DATA, '$.spc6') AS DECIMAL) AS SPC6,
    JSON_VALUE(DATA, '$.appearance') AS Appearance,
    JSON_VALUE(DATA, '$.inspector') AS Inspector,
    -- CONCAT(JSON_VALUE(DATA, '$.model'),JSON_VALUE(DATA, '$.partName')) AS ModelInfo
    -- CONCAT(Model, PartName) AS ModelInfo
FROM `shinwhaintranet.firestore_spc.spc_pqc_raw_latest`