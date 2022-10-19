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
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 2.85
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 2.65
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 4.85
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 6.00
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 17.30
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 6.65
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 108.00
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.85
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.55
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.50
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.45
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 2.83
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 2.60
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 4.83
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 5.95
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 17.25
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 6.63
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 107.95
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.85
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.55
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.25
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.10
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 2.75
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 2.45
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 4.65
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 5.80
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 16.90
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 6.55
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 107.60
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.75
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.45
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.30
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.15
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 2.77
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 2.50
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 4.67
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 5.85
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 16.95
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 6.58
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 107.65
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.75
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.45
  END AS Guide_LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.15
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 0.05
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 0.10
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 0.10
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 0.10
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 0.20
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.10
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 0.40
    -- WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 0.10
    -- WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 0.10
  END AS R_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.075
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 0.025
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 0.05
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 0.05
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