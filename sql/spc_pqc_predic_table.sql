SELECT
    ID,
    Date,
    Cycle,
    Model,
    PartName,
    ToolingNo,
    Cavity,
    SPC1 - 0.15 AS SPC1,
    SPC2 - 0.15 AS SPC2,
    SPC3 - 0.05 AS SPC3,
    SPC4 - 0.05 AS SPC4,
    SPC5 - 0.15 AS SPC5,
    SPC6 - 0.15 AS SPC6,
    Appearance,
    Inspector,
FROM `shinwhaintranet.firestore_spc.spc_pqc_table`
WHERE Model = 'AP18C8K' OR Model = '14Z90Q' OR Model = '12T50Q' OR Model = '17Z90N'
-- 경시변화율 적용(노트북만 정리)