function Get-DataCollectorSet {
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
        Catch [System.Exception] {
            if ( 80300002 -eq $("{0:X4}" -f $($PSItem[0].Exception.ErrorCode) ) ) {
                $DataCollectorSet = $false;
                Return
            }

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
