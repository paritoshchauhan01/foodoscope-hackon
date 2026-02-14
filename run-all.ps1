# NutriContext - Run All Services
# This script starts Frontend, Backend, and checks MongoDB

Write-Host "🚀 Starting NutriContext Full Stack..." -ForegroundColor Cyan
Write-Host ""

# Colors
$info = "Cyan"
$success = "Green"
$warning = "Yellow"

# Check if MongoDB is running
Write-Host "⏳ Checking MongoDB..." -ForegroundColor $info
$mongoProcess = Get-Process mongod -ErrorAction SilentlyContinue
if ($mongoProcess) {
    Write-Host "✅ MongoDB is running on port 27017" -ForegroundColor $success
} else {
    Write-Host "⚠️  MongoDB not detected. Make sure it's running!" -ForegroundColor $warning
    Write-Host "   Start MongoDB with: mongod" -ForegroundColor $warning
}
Write-Host ""

# Start Backend
Write-Host "⏳ Starting Backend Server..." -ForegroundColor $info
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\backend'; npm run dev"
Write-Host "✅ Backend starting on http://localhost:3001" -ForegroundColor $success
Write-Host ""

# Wait a moment for backend to start
Start-Sleep -Seconds 2

# Start Frontend
Write-Host "⏳ Starting Frontend Server..." -ForegroundColor $info
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\frontend'; npm run dev"
Write-Host "✅ Frontend starting on http://localhost:3000" -ForegroundColor $success
Write-Host ""

# Display summary
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor $success
Write-Host "🎉 All Services Started!" -ForegroundColor $success
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor $success
Write-Host ""
Write-Host "📱 Frontend:  http://localhost:3000" -ForegroundColor $success
Write-Host "🔌 Backend:   http://localhost:3001" -ForegroundColor $success
Write-Host "🗄️  MongoDB:   mongodb://localhost:27017" -ForegroundColor $success
Write-Host ""
Write-Host "Demo Credentials:" -ForegroundColor $info
Write-Host "  Email:    demo@nutricontext.com" -ForegroundColor $info
Write-Host "  Password: Demo123!" -ForegroundColor $info
Write-Host ""
Write-Host "Press Ctrl+C in each terminal to stop services" -ForegroundColor $warning
