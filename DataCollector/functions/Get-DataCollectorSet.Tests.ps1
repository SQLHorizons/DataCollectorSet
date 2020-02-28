#Requires -RunAsAdministrator
#Requires -Modules Pester

$here   = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut    = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
$file   = Get-ChildItem "$here\$sut"
$module = Get-ChildItem $( Split-Path -Parent $here ) -Filter "*.psm1"

Describe $file.BaseName -Tags Unit {

    It "is valid Powershell (Has no script errors)" {

        $contents = Get-Content -Path $file -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors | Should -HaveCount 0
    }

    Context "Basic features" {

        BeforeAll {
            Import-Module $module -Force;
            $DataCollectorSet = New-Object -ComObject Pla.DataCollectorSet -Strict;
            $null = $DataCollectorSet.Commit("unit",$null,0x0003);
        }

        It "Positive Output is a ComObject" {
            $result = Get-DataCollectorSet "unit"
            $result | Should -Not -BeNullOrEmpty
            $result.GetType().Name | Should -Be "__ComObject"
        }

        It "Negative Output is a False" {
            $result = Get-DataCollectorSet "unitTest"
            $result | Should -Be $false
        }

        AfterAll {
            $null = $DataCollectorSet.Delete();
        }

    }

}
