# Feudalism Flash Game Launcher
# This script starts a local web server and opens the game in your browser

$gameFile = "Feudalism.swf"
$htmlFile = "play_feudalism.html"
$port = 8080

Write-Host "Feudalism Game Launcher" -ForegroundColor Cyan
Write-Host "======================" -ForegroundColor Cyan
Write-Host ""

# Check if game file exists
if (-not (Test-Path $gameFile)) {
    Write-Host "Error: $gameFile not found!" -ForegroundColor Red
    exit 1
}

# Check if HTML file exists
if (-not (Test-Path $htmlFile)) {
    Write-Host "Error: $htmlFile not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Starting local web server on port $port..." -ForegroundColor Yellow
Write-Host "Game URL: http://localhost:$port/$htmlFile" -ForegroundColor Green
Write-Host ""
Write-Host "Press Ctrl+C to stop the server when you're done playing." -ForegroundColor Yellow
Write-Host ""

# Open browser after a short delay
Start-Sleep -Seconds 2
Start-Process "http://localhost:$port/$htmlFile"

# Start simple HTTP server using Python if available, otherwise use PowerShell
if (Get-Command python -ErrorAction SilentlyContinue) {
    python -m http.server $port
} elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    python3 -m http.server $port
} else {
    # Fallback to PowerShell's built-in web server
    $listener = New-Object System.Net.HttpListener
    $listener.Prefixes.Add("http://localhost:$port/")
    $listener.Start()
    Write-Host "Server started successfully!" -ForegroundColor Green
    
    try {
        while ($listener.IsListening) {
            $context = $listener.GetContext()
            $request = $context.Request
            $response = $context.Response
            
            $filePath = $request.Url.LocalPath.TrimStart('/')
            if ([string]::IsNullOrEmpty($filePath)) { $filePath = $htmlFile }
            
            if (Test-Path $filePath) {
                $content = [System.IO.File]::ReadAllBytes($filePath)
                $response.ContentLength64 = $content.Length
                
                # Set content type based on file extension
                switch ([System.IO.Path]::GetExtension($filePath)) {
                    ".html" { $response.ContentType = "text/html" }
                    ".swf" { $response.ContentType = "application/x-shockwave-flash" }
                    ".js" { $response.ContentType = "application/javascript" }
                    ".css" { $response.ContentType = "text/css" }
                    ".wasm" { $response.ContentType = "application/wasm" }
                    ".map" { $response.ContentType = "application/json" }
                    default { $response.ContentType = "application/octet-stream" }
                }
                
                $response.OutputStream.Write($content, 0, $content.Length)
            } else {
                $response.StatusCode = 404
                $buffer = [System.Text.Encoding]::UTF8.GetBytes("404 - File not found")
                $response.ContentLength64 = $buffer.Length
                $response.OutputStream.Write($buffer, 0, $buffer.Length)
            }
            
            $response.Close()
        }
    } finally {
        $listener.Stop()
    }
}
