-- NOTE
--  GUIDE UCL,LCL +-0.1 이상=> 0.05, +-0.1 이하=> 0.02 
SELECT
  Date,
  Model,
  PartName,
  ToolingNo,
  Cavity,
  MIN(SPC6) AS minSPC6,
  MAX(SPC6) AS maxSPC6,
  AVG(SPC6) AS avgSPC6,
  MAX(SPC6) - MIN(SPC6) AS diffSPC6,
  STDDEV(SPC6) AS stddevSPC6,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 254.25
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 254.20
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 253.95
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 254.00
  END AS Guide_LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.15
  END AS R_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.075
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