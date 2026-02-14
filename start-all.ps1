# NutriContext - Start All Services
# This script starts both backend and frontend servers

Write-Host "🚀 Starting NutriContext..." -ForegroundColor Cyan
Write-Host ""

# Check if we're in the right directory
if (-not (Test-Path "backend") -or -not (Test-Path "frontend")) {
    Write-Host "❌ Error: backend or frontend folder not found!" -ForegroundColor Red
    Write-Host "Please run this script from the project root directory" -ForegroundColor Yellow
    pause
    exit 1
}

# Start Backend
Write-Host "📦 Starting Backend Server..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd backend; Write-Host '🔧 Backend Server' -ForegroundColor Cyan; npm run dev"

# Wait a bit for backend to start
Write-Host "⏳ Waiting for backend to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# Start Frontend
Write-Host "🎨 Starting Frontend Server..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd frontend; Write-Host '💻 Frontend Server' -ForegroundColor Cyan; npm run dev"

Write-Host ""
Write-Host "✅ Both servers starting..." -ForegroundColor Green
Write-Host ""
Write-Host "📝 Server URLs:" -ForegroundColor Cyan
Write-Host "   Backend:  http://localhost:3001" -ForegroundColor White
Write-Host "   Frontend: http://localhost:3000" -ForegroundColor White
Write-Host ""
Write-Host "💡 Tip: Wait for both servers to fully start (10-15 seconds)" -ForegroundColor Yellow
Write-Host "Then open http://localhost:3000 in your browser" -ForegroundColor Yellow
Write-Host ""
Write-Host "Press any key to exit this window (servers will keep running)..." -ForegroundColor Gray
pause