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
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 18.10
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 18.10
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 18.10
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 78.30
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 78.30
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 110.90
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 112.40
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 10.00
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 36.40
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 73.10
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 248.15
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 247.05
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 181.70
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 179.70
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 247.05
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 18.05
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 18.05
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 18.05
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 78.25
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 78.25
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 110.85
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 112.35
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 9.95
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 36.35
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 73.05
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 247.80
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 246.70
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 181.45
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 179.45
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 246.70
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 17.90
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 17.90
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 17.90
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 77.70
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 77.70
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 110.50
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 112.00
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 9.80
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 36.20
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 72.50
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 247.85
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 246.75
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 181.50
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 179.50
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 246.75
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 17.95
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 17.95
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 17.95
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 77.75
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 77.75
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 110.55
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 112.05
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 9.85
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 36.25
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 72.55
  END AS Guide_LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 0.20
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 0.10
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 0.10
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 0.10
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 0.30
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 0.30
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.40
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 0.40
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 0.20
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 0.20
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 0.30
  END AS R_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 0.10
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = 'CORTES(SOYUZ)' AND PartName = 'CASE' THEN 0.05
    WHEN Model = 'VOYAGER' AND PartName = 'CASE' THEN 0.05
    WHEN Model = 'VOYAGER_M29' AND PartName = 'CASE' THEN 0.05
    WHEN Model = 'AVN' AND PartName = 'TOP CASE' THEN 0.15
    WHEN Model = 'AVN' AND PartName = 'BOTTOM CASE' THEN 0.15
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.20
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 0.20
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 0.10
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 0.10
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 0.15
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