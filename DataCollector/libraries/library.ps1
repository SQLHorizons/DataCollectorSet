$here    = Split-Path -Parent $MyInvocation.MyCommand.Path
$library = $(Get-Content "$here\library.cs")

$id = get-random
$source = @"
using System.Management.Automation;

namespace Microsoft.DataCollectorSet {
  /// <summary>
  /// Static class containing parameter information for the data collector.
  /// </summary>
  public static class DataCollector {
    /// <summary>
    /// Retrieves or sets the name of the data collector.
    /// </summary>
    public static System.String Name = "collector";

    /// <summary>
    /// /// Retrieves or sets the base name of the file that will contain the data collector data.
    /// </summary>
    public static System.String FileName = "collection";

    /// <summary>
    /// Retrieves or sets flags that describe how to decorate the file name.
    /// </summary>
    public static System.Int32 FileNameFormat = 1;

    /// <summary>
    /// Retrieves or sets the format pattern to use when decorating the file name.
    /// </summary>
    public static System.String FileNameFormatPattern = "yyyyMMddHHmmss\\-N";

    /// <summary>
    /// Retrieves or sets the Interval at which the Sample are taken, unit seconds.
    /// </summary>
    public static System.Int32 SampleInterval = 5;

    /// <summary>
    /// Retrieves or sets flags that describe the target data format; csv, tab, sql, or bin.
    /// </summary>
    public static System.Int32 LogFileFormat = 3;
  }

  public static class CollectorSet {
    /// <summary>
    /// Retrieves or sets the display name of the data collector set.
    /// </summary>
    public static System.String DisplayName = "Database Performance";

    /// <summary>
    /// Retrieves or sets the description of the data collector set. The description will be added to all output files as metadata and inserted into Performance Data Helper logs as a comment.
    /// </summary>
    /// public static System.String Description = "SQL Performance Trace";

    /// <summary>
    /// Retrieves or sets a value that indicates whether PLA creates new logs if the maximum size or segment duration is reached before the data collector set is stopped.
    /// </summary>
    public static System.Boolean Segment = false;

    /// <summary>
    /// Retrieves and sets the duration that the data collector set runs.
    /// </summary>
    public static System.Int32 Duration = 10800;

    /// <summary>
    /// Retrieves or sets the duration that the data collector set can run before it begins writing to new log files.
    /// </summary>
    public static System.Int32 SegmentMaxDuration = 1200;

    /// <summary>
    /// Retrieves or sets the maximum size of any log file in the data collector set.
    /// </summary>
    public static System.Int32 SegmentMaxSize = 100;

    /// <summary>
    /// Retrieves or sets the number of times that this data collector set has been started, including segments.
    /// </summary>
    public static System.Int32 SerialNumber = 1;

    /// <summary>
    /// Retrieves or sets flags that describe how to decorate the subdirectory name.
    /// </summary>
    public static System.Int32 SubdirectoryFormat = 3;

    /// <summary>
    /// Retrieves or sets a format pattern to use when decorating the folder name.
    /// </summary>
    public static System.String SubdirectoryFormatPattern = "yyyyMMdd\\_NNN";

    /// <summary>
    /// Retrieves or sets the base path where the subdirectories are created.
    /// </summary>
    public static System.String RootPath = "S:\\Data_X\\diag_01\\perflogs\\database\\Performance";

  }

}
"@

Try { Add-Type -TypeDefinition $source -Language CSharp -ErrorAction Stop }
catch { "foo bar" }
