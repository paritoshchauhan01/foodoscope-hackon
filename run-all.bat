@echo off
REM NutriContext - Run All Services
REM This batch file starts Frontend, Backend, and MongoDB check

setlocal enabledelayedexpansion

cls
echo.
echo ========================================
echo   NutriContext Full Stack Launcher
echo ========================================
echo.

REM Check MongoDB
echo Checking MongoDB...
tasklist /FI "IMAGENAME eq mongod.exe" 2>NUL | find /I /N "mongod.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo [OK] MongoDB is running on port 27017
) else (
    echo [WARNING] MongoDB not detected
    echo Make sure MongoDB is running!
)
echo.

REM Start Backend in new window
echo Starting Backend Server...
start "NutriContext Backend" cmd /k "cd backend && npm run dev"
echo [OK] Backend starting on http://localhost:3001
timeout /t 2 /nobreak

REM Start Frontend in new window
echo Starting Frontend Server...
start "NutriContext Frontend" cmd /k "cd frontend && npm run dev"
echo [OK] Frontend starting on http://localhost:3000
echo.

echo ========================================
echo   All Services Started!
echo ========================================
echo.
echo Frontend:  http://localhost:3000
echo Backend:   http://localhost:3001
echo MongoDB:   mongodb://localhost:27017
echo.
echo Demo Login:
echo   Email:    demo@nutricontext.com
echo   Password: Demo123!
echo.
echo Close the terminal windows to stop services
echo.

exit /b
