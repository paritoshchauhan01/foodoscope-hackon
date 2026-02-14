# NutriContext - Connection Diagnostic Tool
# Tests MongoDB, Backend, and Frontend connectivity

Write-Host "`n" -NoNewline
Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     NutriContext - Connection Diagnostics          ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$success = "Green"
$error = "Red"
$warning = "Yellow"
$info = "Cyan"

# Function to test port
function Test-ServicePort {
    param([string]$ServiceName, [string]$HostName, [int]$Port)
    
    Write-Host "Testing $ServiceName..." -NoNewline -ForegroundColor $info
    
    $connection = New-Object System.Net.Sockets.TcpClient
    try {
        $connection.Connect($HostName, $Port)
        $connection.Close()
        Write-Host " ✅ RUNNING" -ForegroundColor $success
        return $true
    } catch {
        Write-Host " ❌ NOT RUNNING" -ForegroundColor $error
        return $false
    }
}

# Function to test HTTP endpoint
function Test-HttpEndpoint {
    param([string]$ServiceName, [string]$Url)
    
    Write-Host "Testing $ServiceName Health..." -NoNewline -ForegroundColor $info
    
    try {
        $response = Invoke-WebRequest -Uri $Url -TimeoutSec 2 -Method GET -ErrorAction SilentlyContinue
        if ($response.StatusCode -eq 200) {
            Write-Host " ✅ HEALTHY" -ForegroundColor $success
            return $true
        } else {
            Write-Host " ⚠️ Status: $($response.StatusCode)" -ForegroundColor $warning
            return $false
        }
    } catch {
        Write-Host " ❌ NO RESPONSE" -ForegroundColor $error
        return $false
    }
}

# Test MongoDB
Write-Host ""
Write-Host "1️⃣  MONGODB:" -ForegroundColor $info
Write-Host "═" * 50
$mongoOk = Test-ServicePort "MongoDB" localhost 27017
if (-not $mongoOk) {
    Write-Host "   ⚠️  Start MongoDB with: mongod" -ForegroundColor $warning
}
Write-Host ""

# Test Backend
Write-Host "2️⃣  BACKEND (Express):" -ForegroundColor $info
Write-Host "═" * 50
$backendPort = Test-ServicePort "Backend Server" "localhost" 3001
if ($backendPort) {
    $backendHealth = Test-HttpEndpoint "Backend" "http://localhost:3001/health"
} else {
    Write-Host "   ⚠️  Backend is not running" -ForegroundColor $warning
    Write-Host "   Start with: cd backend && npm run dev" -ForegroundColor $warning
}
Write-Host ""

# Test Frontend
Write-Host "3️⃣  FRONTEND (Next.js):" -ForegroundColor $info
Write-Host "═" * 50
$frontendPort = Test-ServicePort "Frontend Server" "localhost" 3000
if ($frontendPort) {
    $frontendHealth = Test-HttpEndpoint "Frontend" "http://localhost:3000"
} else {
    Write-Host "   ⚠️  Frontend is not running" -ForegroundColor $warning
    Write-Host "   Start with: cd frontend && npm run dev" -ForegroundColor $warning
}
Write-Host ""

# Summary
Write-Host "━" * 50
Write-Host "📊 SUMMARY:" -ForegroundColor $info
Write-Host ""

$allOk = $mongoOk -and $backendPort -and $frontendPort

if ($allOk) {
    Write-Host "✅ All services are running and connected!" -ForegroundColor $success
    Write-Host ""
    Write-Host "🌐 Open browser: http://localhost:3000" -ForegroundColor $success
    Write-Host ""
} else {
    Write-Host "❌ Some services are not running" -ForegroundColor $error
    Write-Host ""
    if (-not $mongoOk) {
        Write-Host "MongoDB Status: ❌ NOT RUNNING" -ForegroundColor $error
        Write-Host "  → Run: mongod" -ForegroundColor $warning
    }
    if (-not $backendPort) {
        Write-Host "Backend Status: ❌ NOT RUNNING" -ForegroundColor $error
        Write-Host "  → Run: cd backend && npm run dev" -ForegroundColor $warning
    }
    if (-not $frontendPort) {
        Write-Host "Frontend Status: ❌ NOT RUNNING" -ForegroundColor $error
        Write-Host "  → Run: cd frontend && npm run dev" -ForegroundColor $warning
    }
    Write-Host ""
    Write-Host "If all should be running, use the launcher:" -ForegroundColor $info
    Write-Host "  → Run: .\start-all.ps1" -ForegroundColor $info
}

Write-Host ""
Write-Host "━" * 50
