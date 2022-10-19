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
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 4.90
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 4.65
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 2.90
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 58.30
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 58.30
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 155.20
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 95.25
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.85
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.55
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 14.70
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.50
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.45
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 3.85
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 2.95
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 5.60
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 4.85
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 4.60
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 2.88
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 58.25
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 58.25
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 155.15
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 95.20
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.83
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.53
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 14.65
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.25
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 3.70
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 2.80
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 5.45
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 4.70
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 4.45
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 2.80
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 57.70
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 57.70
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 154.80
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 94.95
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.75
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.45
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 14.30
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 84.30
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 91.15
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 3.75
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 2.85
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 5.50
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 4.75
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 4.50
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 2.82
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 57.75
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 57.75
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 154.85
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 95.00
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 5.78
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 2.47
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 14.35
  END AS Guide_LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.15
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 0.10
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 0.10
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 0.10
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 0.10
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 0.30
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 0.30
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.40
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 0.30
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 0.10
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 0.10
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 0.20
  END AS R_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.075
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.05
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 0.05
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.05
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 0.05
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 0.05
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 0.05
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 0.15
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 0.15
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.20
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 0.15
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 0.05
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 0.05
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 0.10
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