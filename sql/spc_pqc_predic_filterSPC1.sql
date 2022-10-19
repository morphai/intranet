SELECT
  Date,
  Model,
  PartName,
  ToolingNo,
  Cavity,
  MIN(SPC1) AS minSPC1,
  MAX(SPC1) AS maxSPC1,
  AVG(SPC1) AS avgSPC1,
  MAX(SPC1) - MIN(SPC1) AS diffSPC1,
  STDDEV(SPC1) AS stddevSPC1,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 248.20
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 247.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 181.75
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 179.75
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 247.10
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 248.15
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 247.05
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 181.70
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 179.70
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 247.05
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 247.80
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 246.70
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 181.45
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 179.45
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 246.70
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 247.85
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 246.75
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 181.50
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 179.50
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 246.75
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