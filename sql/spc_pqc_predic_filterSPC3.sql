-- NOTE
--  GUIDE UCL,LCL +-0.1 이상=> 0.05, +-0.1 이하=> 0.02 
SELECT
  Date,
  Model,
  PartName,
  ToolingNo,
  Cavity,
  MIN(SPC3) AS minSPC3,
  MAX(SPC3) AS maxSPC3,
  AVG(SPC3) AS avgSPC3,
  MAX(SPC3) - MIN(SPC3) AS diffSPC3,
  STDDEV(SPC3) AS stddevSPC3,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.55
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.50
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 3.90
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 3.00
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 5.65
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.50
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.45
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 3.85
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 2.95
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 5.60
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.25
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 3.70
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 2.80
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 5.45
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.30
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.15
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 3.75
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 2.85
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 5.50
  END AS Guide_LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.15
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 0.10
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.10
  END AS R_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.075
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.05
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 0.05
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.05
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