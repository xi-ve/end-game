An Extractor which creates a binaryactionchart.bin file which was/is used in public java source private server sources

This build was created for EU/NA/SA v912 (build 294529)

- Parsing is working fine

Dont expect it to create a proper binaryactionchart.bin cause there is a bug with the PackageMap hashes in g_ActionChartPackage.m_PackageMaps
There are also 1 or 2 smaller other bugs in the Write Methods which needs to be fixed

Main issue is located here
Hashes are wrong somehow thats why it cant pull ActionChart from the package
TO make this work properly this needs to be fixed

```
if (actionScript.Value.m_IsPcActionScript)
{
  uint pcPackageHash = BitConverter.ToUInt32(actionT.m_Data1, 12);      //hash seems wrong cause it doesnt fit to any PackageMap Hash in g_ActionChartPackage.m_PackageMaps

  if (g_ActionChartPackage.m_PackageMaps.ContainsKey(pcPackageHash))
    {
      var pMap = g_ActionChartPackage.m_PackageMaps[pcPackageHash];
      chart = pMap.m_ActionCharts[actionT.m_ChartHash];
    }
}
else
{
  chart = actionT.m_ActionChart;
}
```


it also comes with Byte Sigs and an address generator method to generate func addresses of internal parse/read functions to reverse them in IDA

The project was done quick and dirty so dont judge me, had to abort the development of it cause i dont have more time to invest into this

Anyways its a nice base to start learning and mby to fix it and make it work again

Have fun ;)
