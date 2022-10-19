-- NOTE
--  GUIDE UCL,LCL +-0.1 이상=> 0.05, +-0.1 이하=> 0.02 
SELECT
  Date,
  Model,
  PartName,
  ToolingNo,
  Cavity,
  MIN(SPC5) AS minSPC5,
  MAX(SPC5) AS maxSPC5,
  AVG(SPC5) AS avgSPC5,
  MAX(SPC5) - MIN(SPC5) AS diffSPC5,
  STDDEV(SPC5) AS stddevSPC5,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 254.25
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 5.09
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 6.00
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 17.30
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 6.65
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 155.20
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.85
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.55
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 254.20
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 5.04
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 5.95
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 17.25
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 6.63
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 155.15
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.85
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.55
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 253.95
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 4.89
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 5.80
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 16.90
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 6.55
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 154.80
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.75
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.45
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 254.00
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 4.91
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 5.85
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 16.95
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 6.58
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 154.85
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.75
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.45
  END AS Guide_LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.15
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 0.10
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 0.20
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.10
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 0.40
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 0.10
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 0.10
  END AS R_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.075
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.05
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 0.05
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 0.10
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.05
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