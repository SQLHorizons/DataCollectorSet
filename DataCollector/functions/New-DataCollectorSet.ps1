function New-DataCollectorSet {
    #Requires -RunAsAdministrator

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    [OutputType([__ComObject])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Name,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $ServerName = $null,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]
        $collectorSet = [Microsoft.DataCollectorSet.CollectorSet]
    )
    Begin {
        ##  set information preference as continue.
        $InformationPreference = "Continue";

        $DataCollectorSet = New-Object -ComObject Pla.DataCollectorSet -Strict;
    }
    Process {
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            Try {
                ##  query for data collector set.
                $DataCollectorSet.Query($Name,$ServerName)
            }
            Catch [System.Runtime.InteropServices.COMException],[System.Object] {

                $DataCollectorSet.DisplayName               = $Name;
                $DataCollectorSet.Description               = "SQL Performance Trace";
                $DataCollectorSet.Segment                   = $false;
                $DataCollectorSet.Duration                  = $(3600 * $MaxDurationHours);
                $DataCollectorSet.SegmentMaxSize            = $SegmentMaxSize
                $DataCollectorSet.SubdirectoryFormat        = 3;
                $DataCollectorSet.SubdirectoryFormatPattern = "yyyyMMdd\_NNN";
                $DataCollectorSet.RootPath                  = $CollectorPath;

            }
            Catch {
                Write-Debug $( $PSItem[0].Exception.GetType().FullName, $PSItem[0].Exception.Message )

                Write-Information "Error at line: $(($PSItem[0].InvocationInfo.line).Trim())"
                $PSCmdlet.ThrowTerminatingError($PSItem)
            }
        }
    }
    End {
        ##  resetting execution attributes.
        $InformationPreference = "SilentlyContinue";

        Return $DataCollectorSet;
    }
}
