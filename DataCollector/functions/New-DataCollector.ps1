function New-DataCollector {
    #Requires -RunAsAdministrator

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    [OutputType([__ComObject])]
    param (
        [Parameter(Mandatory = $false)]
        [Object]
        $DataCollectorSet = $( New-Object -ComObject Pla.DataCollectorSet -Strict ),

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $xml = "<PerformanceCounterDataCollector><Counter>\Processor(*)\% Processor Time</Counter></PerformanceCounterDataCollector>",

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]
        $collector = [Microsoft.DataCollectorSet.DataCollector]
    )
    Begin {
        ##  set information preference as continue.
        $InformationPreference = "Continue";

        $DataCollectors   = $DataCollectorSet.DataCollectors.CreateDataCollector(0);

    }
    Process {
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            Try {
                ##  configure data collectors.
                $DataCollectors.Name                  = [System.String]$collector::Name;
                $DataCollectors.FileName              = $( "{0}-" -f $collector::FileName );
                $DataCollectors.FileNameFormat        = [System.Int16]$collector::FileNameFormat;
                $DataCollectors.FileNameFormatPattern = [System.String]$collector::FileNameFormatPattern;
                $DataCollectors.SampleInterval        = [System.Int16]$collector::SampleInterval
                $DataCollectors.LogFileFormat         = [System.Int16]$collector::LogFileFormat;

                $DataCollectors.SetXML($xml);
            }
            Catch [System.Exception] {
                Write-Debug $( $PSItem[0].Exception.GetType().FullName, $PSItem[0].Exception.Message )

                Write-Information "Error at line: $(($PSItem[0].InvocationInfo.line).Trim())"
                $PSCmdlet.ThrowTerminatingError($PSItem)
            }
        }
    }
    End {
        ##  resetting execution attributes.
        $InformationPreference = "SilentlyContinue";

        Return $DataCollectors;
    }
}
