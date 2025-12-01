# TechAudio Reviews 部署指南

本指南将帮助你配置、维护和更新 TechAudio Reviews 网站。

## 1. 初始设置 (Initial Setup)

### 1.1 推送代码到 GitHub
如果你还没有将代码推送到 GitHub，请执行以下命令：
```powershell
git init
git add .
git commit -m "Initial commit"
# 请替换为你的仓库地址
git remote add origin https://github.com/YOUR_USERNAME/tech-audio-reviews.git
git push -u origin main
```

### 1.2 连接 Vercel
1. 登录 [Vercel](https://vercel.com)。
2. 点击 "Add New..." -> "Project"。
3. 选择 "Import Git Repository" 并连接你的 GitHub 账号。
4. 找到 `tech-audio-reviews` 仓库并点击 "Import"。
5. 在 "Framework Preset" 中选择 "Other" (因为是静态 HTML)。
6. 点击 "Deploy"。

## 2. 日常更新流程 (Daily Workflow)

### 方式一：使用提供的自动化脚本 (推荐)
我们在根目录下提供了一个 PowerShell 脚本 `deploy.ps1`，可以一键完成添加、提交和推送。

**使用方法：**
1. 打开终端 (Terminal)。
2. 运行脚本：
   ```powershell
   ./deploy.ps1 "你的提交信息 (例如: 更新了XM6评测价格)"
   ```

### 方式二：手动 Git 操作
如果你更喜欢手动控制，可以使用标准 Git 命令：
1. **查看状态**：`git status`
2. **添加文件**：`git add .`
3. **提交更改**：`git commit -m "描述你的更改"`
4. **推送到远程**：`git push origin main`

## 3. 配置文件说明

- **vercel.json**: Vercel 的配置文件。
  - `cleanUrls: true`: 去掉 URL 中的 `.html` 后缀 (例如 `article-xm6` 而不是 `article-xm6.html`)。
  - `headers`: 设置缓存策略，确保 HTML 不缓存 (即时更新)，而图片/CSS 长期缓存 (加快加载)。

## 4. 故障排除 (Troubleshooting)

### 问题 1: 推送后 Vercel 没有更新
- **检查**: 去 Vercel 控制台查看 "Deployments" 列表。
- **原因**: 可能是构建失败，或者浏览器缓存。
- **解决**: 如果显示 "Ready"，尝试强制刷新浏览器 (Ctrl + F5) 或清除缓存。

### 问题 2: 样式或图片不显示
- **检查**: 确保文件路径正确，且文件名大小写匹配 (Linux 服务器区分大小写)。
- **解决**: 检查 `vercel.json` 是否正确配置了 cleanUrls。

### 问题 3: Git 推送被拒绝 (Permission denied / Conflict)
- **原因**: 远程仓库有你本地没有的更改。
- **解决**: 先拉取远程更改 `git pull origin main`，解决冲突后再推送。如果是强制覆盖，可用 `git push -f origin main` (慎用)。
