function Move-Archive-File {
    param (
        [Parameter(Mandatory = $true)] [string]$sourcePath,
        [Parameter(Mandatory = $true)] [string]$archiveDir
    )
    process {
        if (-Not (Test-Path $archiveDir)) {
            New-Item -ItemType Directory -Path $archiveDir | Out-Null
        }
        $fileName = Split-Path $sourcePath -Leaf
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $destinationPath = Join-Path $archiveDir "$($fileName)_$timestamp"
        Move-Item -Path $sourcePath -Destination $destinationPath
    }
}

function Get-FileMoreThanDaysOld {
    param (
        [Parameter(Mandatory = $true)] [string]$directoryPath,
        [Parameter(Mandatory = $true)] [int]$daysOld
    )
    process {
        $cutoffDate = (Get-Date).AddDays(-$daysOld)
        Get-ChildItem -Path $directoryPath | Where-Object { $_.LastWriteTime -lt $cutoffDate }
    }
}