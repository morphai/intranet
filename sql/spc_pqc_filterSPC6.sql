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
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.50
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.50
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.50
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 96.95
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 153.00
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.85
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.55
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 254.20
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.45
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.45
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.45
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 96.90
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 152.92
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.85
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.55
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 253.95
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 96.65
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 152.6
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.75
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.45
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 254.00
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.15
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.05
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.05
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 96.70
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 152.52
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.75
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.45
  END AS Guide_LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.15
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.20

    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.25
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.25
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.30
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 0.40
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 0.10
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 0.10
  END AS R_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.075
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.15
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 0.20
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 0.05
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 0.05
  END AS R_CL,
  CASE
    WHEN Model = 'DANIEL' AND PartName = 'KIM' THEN 0.10
    ELSE 0
  END
  AS R_LCL
FROM
  `shinwhaintranet.firestore_spc.spc_pqc_table`
GROUP BY
  Date,
  Model,
  PartName,
  ToolingNo,
  Cavity