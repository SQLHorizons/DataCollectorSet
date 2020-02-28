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
    private static System.Int32 logFileFormat = 3;

    public static int GetLogFileFormat()
    {
      return logFileFormat;
    }

    public static void SetLogFileFormat(int value) => logFileFormat = value;
  }

}
