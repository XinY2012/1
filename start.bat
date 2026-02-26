@echo off
chcp 65001 >nul
echo ========================================
echo Hotel Management System - Quick Start
echo ========================================
echo.
echo [1] Start Backend Service
echo [2] Start Frontend Service
echo [3] Start Both Services
echo [4] Exit
echo.

set /p choice=Please select (1-4):

if "%choice%"=="1" goto start_backend
if "%choice%"=="2" goto start_frontend
if "%choice%"=="3" goto start_all
if "%choice%"=="4" goto end

:start_backend
echo.
echo Starting backend service...
cd server
start cmd /k "npm start"
cd ..
echo Backend service started!
echo Access: http://localhost:3003
goto end

:start_frontend
echo.
echo Starting frontend service...
start cmd /k "npm run dev"
echo Frontend service started!
echo Access: http://localhost:3000
goto end

:start_all
echo.
echo Starting both services...
cd server
start cmd /k "npm start"
cd ..
timeout /t 2 >nul
start cmd /k "npm run dev"
echo Both services started!
echo.
echo Frontend: http://localhost:3000
echo Backend: http://localhost:3003
goto end

:end
echo.
pause
