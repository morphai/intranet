-- NOTE
--  GUIDE UCL,LCL +-0.1 이상=> 0.05, +-0.1 이하=> 0.02 
SELECT
  Date,
  Model,
  PartName,
  ToolingNo,
  Cavity,
  MIN(SPC4) AS minSPC4,
  MAX(SPC4) AS maxSPC4,
  AVG(SPC4) AS avgSPC4,
  MAX(SPC4) - MIN(SPC4) AS diffSPC4,
  STDDEV(SPC4) AS stddevSPC4,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.55
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.50
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.50
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.45
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.25
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.10
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.30
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.15
  END AS Guide_LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.15
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.20
  END AS R_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.075
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.10
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