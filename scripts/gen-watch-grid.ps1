# 生成红米手表6（432x514 矩形屏）布局的棋盘网格底图。
# 布局约定（device-width，物理px）：
#   棋盘 380x380，4x4 格子 88x88，间距 93，起始偏移 4，圆角 24。
param(
  [string]$OutDir = (Join-Path $PSScriptRoot '..\src\common')
)
Add-Type -AssemblyName System.Drawing

function New-Grid([string]$OutFile, [string]$Panel, [string]$Cell) {
  $size = 380; $pad = 4; $pitch = 93; $cellSize = 88; $radius = 24
  $bmp = New-Object System.Drawing.Bitmap($size, $size)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = 'AntiAlias'
  $g.Clear([System.Drawing.ColorTranslator]::FromHtml($Panel))
  $brush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($Cell))
  for ($i = 0; $i -lt 4; $i++) {
    for ($j = 0; $j -lt 4; $j++) {
      $x = $pad + $i * $pitch
      $y = $pad + $j * $pitch
      $gp = New-Object System.Drawing.Drawing2D.GraphicsPath
      $d = $radius * 2
      $gp.AddArc($x, $y, $d, $d, 180, 90)
      $gp.AddArc($x + $cellSize - $d, $y, $d, $d, 270, 90)
      $gp.AddArc($x + $cellSize - $d, $y + $cellSize - $d, $d, $d, 0, 90)
      $gp.AddArc($x, $y + $cellSize - $d, $d, $d, 90, 90)
      $gp.CloseFigure()
      $g.FillPath($brush, $gp)
      $gp.Dispose()
    }
  }
  $brush.Dispose()
  $g.Dispose()
  $bmp.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
  Write-Host "written: $OutFile"
}

# 颜色取自 bg1.png / bg2.png 的面板与空格取样值
New-Grid (Join-Path $OutDir 'watch-grid-light.png') '#CCBFB2' '#D9CDC0'
New-Grid (Join-Path $OutDir 'watch-grid-dark.png') '#262626' '#313131'
