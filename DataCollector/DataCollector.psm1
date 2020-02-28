#Requires -RunAsAdministrator

##  import libraries.
. "$PSScriptRoot\libraries\library.ps1"

$items = @{
    Path        = "$PSScriptRoot\functions"
    Include     = "*.ps1"
    Exclude     = "*.Tests.ps1"
    Recurse     = $true
    ErrorAction = "Stop"
}
$functions = Get-ChildItem @items

##  dot source the function files
Foreach ($import in $functions) {
    Try {
        Write-Information "Import function $($import.Name)"
        . $import.FullName
    }
    Catch {
        Write-Information "Failed to import function $($import.FullName): $PSItem"
    }
}
