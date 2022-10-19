SELECT
  Date,
  Model,
  PartName,
  ToolingNo,
  Cavity,
  MIN(SPC2) AS minSPC2,
  MAX(SPC2) AS maxSPC2,
  AVG(SPC2) AS avgSPC2,
  MAX(SPC2) - MIN(SPC2) AS diffSPC2,
  STDDEV(SPC2) AS stddevSPC2,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 248.04
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 247.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 94.25
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 13.15
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 91.50
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 247.99
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 247.05
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 94.20
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 13.10
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 91.45
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 247.64
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 246.70
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 93.95
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 12.85
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 91.10
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 247.69
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 246.75
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 94.00
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 12.90
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 91.15
  END AS Guide_LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 0.20
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.20
  END AS R_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 0.10
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.10
  END AS R_CL,
  CASE
    WHEN Model = 'DANIEL' AND PartName = 'KIM' THEN 0.10
    ELSE 0
  END
  AS R_LCL
FROM
  `shinwhaintranet.firestore_spc.spc_pqc_predic_table`
GROUP BY
  Date,
  Model,
  PartName,
  ToolingNo,
  Cavity