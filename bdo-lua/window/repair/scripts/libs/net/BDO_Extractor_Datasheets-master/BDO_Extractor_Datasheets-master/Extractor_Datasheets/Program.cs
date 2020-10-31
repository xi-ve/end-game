using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Utils;

namespace Extractor_Datasheets
{
    class Program
    {
        public static bool b_parsedStringTable = false;
        public static List<string> g_StringTable = new List<string>();

        public static string version = "855";
        
        static void Main(string[] args)
        {
            Extract_Datasheets();
        }

        static string GetString(int st_Index)
        {
            return g_StringTable[st_Index];
        }

        static void Extract_Datasheets()
        {
            string filePath = @"D:\bdo855\bdo\gamecommondata\datasheets.bexcel";

            string outputPath = @".\Datasheets\" + version + @"\";
            string outputPathBinary = @".\Datasheets\" + version + @"\Bin\";

            if (!Directory.Exists(outputPath))
                Directory.CreateDirectory(outputPath);

            if (!Directory.Exists(outputPathBinary))
                Directory.CreateDirectory(outputPathBinary);

            using (var fs = new FileStream(filePath, FileMode.Open))
            {
                using (var br = new BinaryReader(fs))
                {
                    Dictionary<int, string> m_Sheets = new Dictionary<int, string>();

                    br.BaseStream.Position = br.BaseStream.Length - 8;
                    Console.WriteLine("BasePosition:{0}", br.BaseStream.Position);
                    long stringTableStart = br.ReadInt64();
                    Console.WriteLine("stringTableStart{0}", stringTableStart);
                    br.BaseStream.Position = stringTableStart;
                    Console.WriteLine("Position:{0},stringTableStart:{1}", br.BaseStream.Position, stringTableStart);
                    g_StringTable = br.ReadStringTable();
                    Console.WriteLine(string.Join("g_StringTable{0}", g_StringTable.Cast<string>().ToArray()));
                    br.BaseStream.Position = 0;
                    var filetype = br.ReadInt32(); //skip file type

                    Console.WriteLine("Filetype:{0},g_stringtable:{1},stringtable:{2}", filetype, g_StringTable.Count, stringTableStart);

                    Console.ReadKey();

                    int sheetsCount = br.ReadInt32();

                    for (int i = 0; i < sheetsCount; i++)
                    {
                        int i_sheetName = br.ReadInt32();
                        int sheetIndex = br.ReadInt32();

                        m_Sheets.Add(sheetIndex, GetString(i_sheetName));
                        //Console.WriteLine(GetString(i_sheetName)); //Названия таблиц
                    }

                    sheetsCount = br.ReadInt32();

                    for (int i = 0; i < sheetsCount; i++)
                    {

                        int i_sheetName = br.ReadInt32();

                        string sheetName = GetString(i_sheetName);
                        sheetName = sheetName.Replace("_", "").Replace("1", "").Replace("2", "").Replace("3", "")
                            .Replace("4", "").Replace("5", "").Replace("6", "");

                        br.ReadInt32();
                        br.ReadInt32();

                        int columnCount = br.ReadInt32();

                        List<string> rowContent = new List<string>();

                        string columnHeaders = "";

                        for (int c = 0; c < columnCount; c++)
                        {
                            int i_Text = br.ReadInt32();
                            string columnName = GetString(i_Text);

                            columnHeaders += columnName + "\t";
                            //Console.WriteLine(GetString(i_Text)); //Названия столбцов
                        }

                        columnHeaders = columnHeaders.TrimEnd('\t');
                        rowContent.Add(columnHeaders);

                        int rowCount = br.ReadInt32();

                        for (int r = 0; r < rowCount; r++)
                        {
                            int rowIndex = br.ReadInt32();
                            int cellIndex = br.ReadInt32();

                            int cellCount = br.ReadInt32();

                            string rowText = "";

                            for (int c = 0; c < cellCount; c++)
                            {
                                int i_Text = br.ReadInt32();
                                string text = GetString(i_Text);

                                text = text.Replace("\n", "").Replace("<null>", "0");

                                rowText += text + "\t";
                            }

                            rowText = rowText.TrimEnd('\t');

                            rowContent.Add(rowText);
                            //Console.WriteLine(rowText); //Заполнение столбцов
                        }

                        columnCount = br.ReadInt32();

                        for (int c = 0; c < columnCount; c++)
                        {
                            int i_Text = br.ReadInt32();
                            string columnName = GetString(i_Text);

                            int columnIndex = br.ReadInt32();
                        }

                        rowCount = br.ReadInt32();

                        for (int r = 0; r < rowCount; r++)
                        {
                            int i_Text = br.ReadInt32();
                            string text = GetString(i_Text);

                            int cellIndex = br.ReadInt32();
                        }

                        File.WriteAllLines(outputPath + sheetName + ".csv", rowContent);
                        CreateBIN(rowContent, columnCount, outputPathBinary + sheetName + ".bin");
                    }
                }
            }
        }

        static void CreateBIN(List<string> data, int columnCount, string filePath)
        {
            data.RemoveAt(0);

            using (var fs = new FileStream(filePath, FileMode.Create))
            {
                using (var bw = new BinaryWriter(fs))
                {
                    bw.Write(BitConverter.GetBytes((int)data.Count));
                    bw.Write(BitConverter.GetBytes((short)columnCount));

                    foreach (var line in data)
                    {
                        var fields = line.Split('\t');

                        bw.Write(BitConverter.GetBytes((short)fields.Length));

                        foreach (var field in fields)
                        {
                            bw.Write(BitConverter.GetBytes((short)field.Length));
                            bw.Write(Encoding.ASCII.GetBytes(field));
                        }
                    }
                }
            }
        }
    }
}
