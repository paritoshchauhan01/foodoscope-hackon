@echo off
title NutriContext - Stop All Services
color 0C

echo.
echo ========================================
echo   Stopping NutriContext Services
echo ========================================
echo.

echo Killing processes on port 3001 (Backend)...
FOR /F "tokens=5" %%T IN ('netstat -a -n -o ^| findstr :3001') DO (
    taskkill /F /PID %%T 2>nul
)

echo Killing processes on port 3000 (Frontend)...
FOR /F "tokens=5" %%T IN ('netstat -a -n -o ^| findstr :3000') DO (
    taskkill /F /PID %%T 2>nul
)

echo.
echo All servers stopped!
echo.
pause