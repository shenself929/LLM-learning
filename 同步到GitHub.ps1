$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "       Git 自动同步脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Set-Location "E:\大模型"

Write-Host "
[1/4] 检查文件变更..." -ForegroundColor Yellow
$status = git status --porcelain
if (-not $status) {
    Write-Host "没有文件需要同步！" -ForegroundColor Green
    Write-Host "
按任意键退出..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

Write-Host $status -ForegroundColor White

Write-Host "
[2/4] 添加文件到暂存区..." -ForegroundColor Yellow
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "添加文件失败！" -ForegroundColor Red
    Read-Host "按回车退出"
    exit 1
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMsg = "自动同步 - $timestamp"

Write-Host "
[3/4] 提交更改..." -ForegroundColor Yellow
git commit -m $commitMsg
if ($LASTEXITCODE -ne 0) {
    Write-Host "提交失败！" -ForegroundColor Red
    Read-Host "按回车退出"
    exit 1
}

Write-Host "
[4/4] 推送到 GitHub..." -ForegroundColor Yellow
git push
if ($LASTEXITCODE -ne 0) {
    Write-Host "推送失败！请检查网络连接。" -ForegroundColor Red
    Read-Host "按回车退出"
    exit 1
}

Write-Host "
========================================" -ForegroundColor Green
Write-Host "       同步完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "
仓库地址: https://github.com/shenself929/LLM-learning" -ForegroundColor Cyan

Write-Host "
按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
