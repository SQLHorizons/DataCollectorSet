function Get-DataCollectorSet {
    [CmdletBinding()]
    [OutputType([System.MarshalByRefObject])]
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
            $DataCollectorSet.Query($Name,$ServerNam)
        }
        Catch [System.Exception] {
            Write-Information  "Error at line: $(($PSItem[0].InvocationInfo.line).Trim())"
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }
    }
    End {
        ##  resetting execution attributes.
        $InformationPreference = "SilentlyContinue"

        Return $DataCollectorSet
    }
}
