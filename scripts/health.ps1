$resp = Invoke-WebRequest -Uri "http://localhost:8080/health" -UseBasicParsing
Write-Host $resp.StatusCode
Write-Host $resp.Content
