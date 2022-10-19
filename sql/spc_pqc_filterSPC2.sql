-- NOTE
--  GUIDE UCL,LCL +-0.1 이상=> 0.05, +-0.1 이하=> 0.02 
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
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 109.10
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 158.20
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 139.95
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 8.25
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 23.20
  END AS UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 247.99
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 247.05
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 94.20
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 13.10
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 91.45
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 109.05
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 158.15
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 139.90
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 8.23
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 23.15
  END AS Guide_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 247.64
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 246.70
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 93.95
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 12.85
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 91.10
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 108.70
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 157.80
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 139.55
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 8.15
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 22.80
  END AS LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 247.69
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 246.75
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 94.00
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 12.90
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 91.15
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 108.75
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 157.85
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 139.60
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 8.17
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 22.85
  END AS Guide_LCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 0.20
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.20
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.40
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 0.40
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 0.40
    WHEN Model = 'DXD' AND PartName = 'HANDLE' THEN 0.10
    WHEN Model = 'BDI FUSE' AND PartName = 'BOX' THEN 0.20
  END AS R_UCL,
  CASE
    WHEN Model = 'AP18C8K' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '14Z90Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = '12T50Q' AND PartName = 'BMU COVER' THEN 0.10
    WHEN Model = '17Z90N' AND PartName = 'FRAME' THEN 0.10
    WHEN Model = 'DXD' AND PartName = 'TOP CASE' THEN 0.20
    WHEN Model = 'DXD' AND PartName = 'BOTTOM CASE' THEN 0.20
    WHEN Model = 'DXD' AND PartName = 'LATCH' THEN 0.20
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