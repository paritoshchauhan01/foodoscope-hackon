@echo off
REM NutriContext - Start All Services Properly
REM This runs Backend and Frontend (without requiring MongoDB)

setlocal enabledelayedexpansion
cls

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║   NutriContext - Full Stack Launcher               ║
echo ║   Backend + Frontend (Using Mock Data)             ║
echo ╚════════════════════════════════════════════════════╝
echo.

REM Kill any existing processes on ports 3000 and 3001
echo Cleaning up old processes...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":3001 "') do taskkill /F /PID %%a 2>nul
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":3000 "') do taskkill /F /PID %%a 2>nul
timeout /t 1 /nobreak

REM Start Backend
echo.
echo [1/2] Starting Backend on port 3001...
start "NutriContext Backend" cmd /k "cd backend && echo Waiting for backend to start... && timeout /t 3 && npm run dev"

REM Wait for backend to start
timeout /t 5 /nobreak

REM Start Frontend
echo.
echo [2/2] Starting Frontend on port 3000...
start "NutriContext Frontend" cmd /k "cd frontend && echo Waiting for frontend to start... && timeout /t 3 && npm run dev"

timeout /t 5 /nobreak

REM Show summary
cls
echo.
echo ╔════════════════════════════════════════════════════╗
echo ║        All Services Started!                       ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo ✅ Backend:  http://localhost:3001
echo ✅ Frontend: http://localhost:3000
echo.
echo Demo Login Credentials:
echo   Email:    demo@nutricontext.com
echo   Password: Demo123!
echo.
echo 📝 Next Steps:
echo   1. Two new terminals will open (Backend and Frontend)
echo   2. Wait 30 seconds for both to start
echo   3. Open browser: http://localhost:3000
echo   4. Click "Try Demo" or login with demo account
echo.
echo ⚠️  IMPORTANT:
echo   • Backend uses MOCK DATA (no MongoDB needed)
echo   • Keep both terminal windows open
echo   • Close terminals to stop services
echo.
echo ════════════════════════════════════════════════════
echo Opening browser in 10 seconds...
timeout /t 10 /nobreak

REM Open browser
start http://localhost:3000

echo.
echo Browser opened! Wait for frontend page to load...
echo If you see a blank page, wait 30 more seconds.
echo.
