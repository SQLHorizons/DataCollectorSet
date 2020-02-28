function Get-DataCollectorSet {
    #Requires -RunAsAdministrator

    [CmdletBinding()]
    [OutputType([__ComObject])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Name,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $ServerName = $null
    )
    Begin {
        ##  set information preference as continue.
        $InformationPreference = "Continue";

        $DataCollectorSet = New-Object -ComObject Pla.DataCollectorSet -Strict;
    }
    Process {
        Try {
            ##  query for data collector set.
            $DataCollectorSet.Query($Name,$ServerName)
        }
        Catch [System.Runtime.InteropServices.COMException],[System.Object] {
            $DataCollectorSet = $false;
            Return
        }
        Catch {
            Write-Debug $( $PSItem[0].Exception.GetType().FullName, $PSItem[0].Exception.Message )

            Write-Information "Error at line: $(($PSItem[0].InvocationInfo.line).Trim())"
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }
    }
    End {
        ##  resetting execution attributes.
        $InformationPreference = "SilentlyContinue";

        Return $DataCollectorSet;
    }
}
