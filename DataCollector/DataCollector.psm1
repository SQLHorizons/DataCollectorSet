#. "$PSScriptRoot\Libraries\library.ps1"

$items = @{
    Path        = "$PSScriptRoot\functions"
    Include     = "*.ps1"
    Exclude     = "*.Test.ps1"
    Recurse     = $true
    ErrorAction = "Stop"
}
$functions = Get-ChildItem @items

##  dot source the function files
Foreach ($import in $functions) {
    Try {
        Write-Host "Import function $($import.Name)"
        . $import.FullName
    }
    Catch {
        Write-Host "Failed to import function $($import.FullName): $PSItem"
    }
}
