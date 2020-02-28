# DataCollectorSet

## Manifest

Create module manifest:

```powershell

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

```

## Module

Load 'DataCollector' module:

```powershell

Push-Location "D:\.source\repos\DataCollectorSet\DataCollector"
Import-Module .\DataCollector.psm1 -Force

##  Positive test.
$DataCollectorSet = Get-DataCollectorSet test
##  Negative test.
$DataCollectorSet = Get-DataCollectorSet unit

if ( $DataCollectorSet -eq $false ) {
    New-DataCollectorSet unit
}

$DataCollectors = New-DataCollector

$DataCollectorSet.DataCollectors.Add($DataCollectors)
$DataCollectorSet.Commit("test",$null,0x0003) | Out-Null;

```
