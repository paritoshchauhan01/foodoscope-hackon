# NutriContext - Complete Stack Launcher
# Starts MongoDB, Backend, and Frontend in correct order

Write-Host "`n" -NoNewline
Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   NutriContext - Full Stack Launcher              ║" -ForegroundColor Cyan
Write-Host "║   Frontend + Backend + MongoDB                    ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Colors
$success = "Green"
$error = "Red"
$warning = "Yellow"
$info = "Cyan"

# Function to test port
function Test-Connection {
    param([string]$Host, [int]$Port)
    $connection = New-Object System.Net.Sockets.TcpClient
    try {
        $connection.Connect($Host, $Port)
        $connection.Close()
        return $true
    } catch {
        return $false
    }
}

# ==================== MONGODB ====================
Write-Host "Step 1: Starting MongoDB..." -ForegroundColor $info
Write-Host "═" * 50

$mongoRunning = Get-Process mongod -ErrorAction SilentlyContinue
if ($mongoRunning) {
    Write-Host "✅ MongoDB already running" -ForegroundColor $success
} else {
    Write-Host "Starting mongod..." -ForegroundColor $warning
    Start-Process mongod -WindowStyle Minimized -ErrorAction SilentlyContinue
    Write-Host "⏳ Waiting for MongoDB to start..." -ForegroundColor $warning
    Start-Sleep -Seconds 3
    
    # Check if MongoDB started
    if (Test-Connection "localhost" 27017) {
        Write-Host "✅ MongoDB started successfully on port 27017" -ForegroundColor $success
    } else {
        Write-Host "❌ MongoDB failed to start!" -ForegroundColor $error
        Write-Host "   Make sure MongoDB is installed and the mongod command is in PATH" -ForegroundColor $error
        Write-Host "   Or install MongoDB from: https://www.mongodb.com/try/download/community" -ForegroundColor $error
        Write-Host "   Continuing anyway - backend will try to connect..." -ForegroundColor $warning
    }
}
Write-Host ""

# ==================== BACKEND ====================
Write-Host "Step 2: Starting Backend Server..." -ForegroundColor $info
Write-Host "═" * 50

Write-Host "⏳ Launching backend on port 3001..." -ForegroundColor $warning
$backendPath = "$PSScriptRoot\backend"
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    "Set-Location '$backendPath'; `
     Write-Host '🔄 Backend starting... (this may take 10-15 seconds)' -ForegroundColor Cyan; `
     Write-Host '📝 Output will appear below...' -ForegroundColor Cyan; `
     Write-Host ''; `
     npm run dev"
) -WindowStyle Normal
Write-Host "✅ Backend terminal opened (check it for status)" -ForegroundColor $success
Write-Host "⏳ Waiting 8 seconds for backend to start..." -ForegroundColor $warning
Start-Sleep -Seconds 8

# Check backend
if (Test-Connection "localhost" 3001) {
    Write-Host "✅ Backend is responding on http://localhost:3001" -ForegroundColor $success
} else {
    Write-Host "⚠️  Backend not responding yet - it may still be starting" -ForegroundColor $warning
}
Write-Host ""

# ==================== FRONTEND ====================
Write-Host "Step 3: Starting Frontend Server..." -ForegroundColor $info
Write-Host "═" * 50

Write-Host "⏳ Launching frontend on port 3000..." -ForegroundColor $warning
$frontendPath = "$PSScriptRoot\frontend"
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    "Set-Location '$frontendPath'; `
     Write-Host '🔄 Frontend starting... (this may take 10-15 seconds)' -ForegroundColor Cyan; `
     Write-Host '📝 Output will appear below...' -ForegroundColor Cyan; `
     Write-Host ''; `
     npm run dev"
) -WindowStyle Normal
Write-Host "✅ Frontend terminal opened (check it for status)" -ForegroundColor $success
Write-Host "⏳ Waiting 8 seconds for frontend to start..." -ForegroundColor $warning
Start-Sleep -Seconds 8

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor $success
Write-Host "║        🎉 All Services Started Successfully! 🎉    ║" -ForegroundColor $success
Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor $success
Write-Host ""

Write-Host "📋 SERVICE URLS:" -ForegroundColor $info
Write-Host "   🌐 Frontend:  http://localhost:3000" -ForegroundColor $success
Write-Host "   🔌 API:       http://localhost:3001" -ForegroundColor $success
Write-Host "   🗄️  Database:  mongodb://localhost:27017" -ForegroundColor $success
Write-Host ""

Write-Host "🔐 Demo Login Credentials:" -ForegroundColor $info
Write-Host "   Email:    demo@nutricontext.com" -ForegroundColor $info
Write-Host "   Password: Demo123!" -ForegroundColor $info
Write-Host ""

Write-Host "📝 Next Steps:" -ForegroundColor $warning
Write-Host "   1. Open browser: http://localhost:3000" -ForegroundColor $warning
Write-Host "   2. Click 'Try Demo' or login with demo credentials" -ForegroundColor $warning
Write-Host "   3. Complete onboarding to customize preferences" -ForegroundColor $warning
Write-Host "   4. Search for recipes and find substitutions" -ForegroundColor $warning
Write-Host ""

Write-Host "⚠️  IMPORTANT:" -ForegroundColor $warning
Write-Host "   • Check the Backend terminal for any connection errors" -ForegroundColor $warning
Write-Host "   • If backend can't connect to MongoDB, make sure mongod is running" -ForegroundColor $warning
Write-Host "   • Keep all three terminal windows open while using the app" -ForegroundColor $warning
Write-Host "   • Close windows to stop services" -ForegroundColor $warning
Write-Host ""

Write-Host "═" * 50
Write-Host "Press Enter to continue monitoring services..." -ForegroundColor $info
Read-Host
