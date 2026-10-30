@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ==============================================
echo   Push this folder to a GitHub repository
echo   把当前文件夹推送到 GitHub 仓库
echo ==============================================
echo.

set /p GH_USER=GitHub 用户名 (username): 
set /p GH_REPO=仓库名 (e.g. chsi): 
set /p GH_TOKEN=Personal Access Token (勾选 repo 权限): 

if "%GH_USER%"=="" goto :missing
if "%GH_REPO%"=="" goto :missing
if "%GH_TOKEN%"=="" goto :missing

echo.
echo [1/5] init repo ...
git init -b main >nul 2>&1

echo [2/5] set remote ...
git remote remove origin >nul 2>&1
git remote add origin https://%GH_USER%:%GH_TOKEN%@github.com/%GH_USER%/%GH_REPO%.git

echo [3/5] stage ...
git add -A

echo [4/5] commit ...
git -c user.name="%GH_USER%" -c user.email="%GH_USER%@users.noreply.github.com" commit -m "init: chsi docker" >nul 2>&1
git branch -M main >nul 2>&1

echo [5/5] push ...
git push -u origin main --force

if %errorlevel% neq 0 (
    echo.
    echo FAILED. 常见原因：
    echo   1. 仓库还没建，或名字拼错
    echo   2. Token 没勾 repo 权限，或已过期
    echo   3. 仓库不是空的（里面有 README）会冲突 —— 用空仓库即可
    echo.
    pause
    exit /b 1
)

echo.
echo ==============================================
echo   DONE  -  代码已推到:
echo   https://github.com/%GH_USER%/%GH_REPO%
echo.
echo   下一步（网页）：
echo   1. 打开 https://dashboard.render.com
echo   2. New -^> Web Service -^> Connect 这个 GitHub 仓库
echo   3. Render 自动读取 render.yaml，plan 选 Free
echo   4. 填 S3_* 或 SUPABASE_* 环境变量（数据持久化）
echo   5. Create Web Service
echo   6. 域名形如: https://chsi.onrender.com
echo ==============================================
echo.
pause
exit /b 0

:missing
echo.
echo 用户名 / 仓库名 / Token 都不能为空。
pause
exit /b 1
