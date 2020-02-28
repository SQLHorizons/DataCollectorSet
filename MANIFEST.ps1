Push-Location .\DataCollector;

$manifest = @{
    Path              = ".\DataCollector.psd1"
    RootModule        = ".\DataCollector.psm1"
    Description       = "Functions for managing Data Collector Sets."
    Author            = "Paul Maxfield"
    CompanyName       = "SQL Horizons ltd."
    ModuleVersion     = "2020.2.1"
    PowerShellVersion = "5.0"
    FunctionsToExport = @("Get-DataCollectorSet")
    NestedModules     = @()
    Verbose           = $true
}
New-ModuleManifest @manifest;
Pop-Location;
