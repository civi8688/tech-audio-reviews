param (
    [string]$message = "Update site content"
)

Write-Host " 开始部署流程..." -ForegroundColor Cyan

# 检查是否有更改
$status = git status -s
if (-not $status) {
    Write-Host "  没有检测到文件更改，无需部署。" -ForegroundColor Yellow
    exit
}

# 执行 Git 操作
Write-Host " 添加文件..." -ForegroundColor Green
git add .

Write-Host " 提交更改: $message" -ForegroundColor Green
git commit -m "$message"

Write-Host "  推送到 GitHub..." -ForegroundColor Green
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host " 成功推送到 GitHub！" -ForegroundColor Cyan
    Write-Host " Vercel 将在几秒钟内自动开始构建和部署。" -ForegroundColor Cyan
    Write-Host " 预览地址: https://tech-audio-reviews.vercel.app" -ForegroundColor Gray
} else {
    Write-Host " 推送失败，请检查错误信息。" -ForegroundColor Red
}
