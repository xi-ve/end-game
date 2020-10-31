using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class PackageMap
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public uint m_PackageHash { get; set; }

        private long m_ActionChartsCount { get; set; }
        public Dictionary<int, ActionChart> m_ActionCharts { get; set; }

        public PackageMap(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;

            m_ActionCharts = new Dictionary<int, ActionChart>();
        }

        public void Parse()
        {
            m_PackageHash = bReader.ReadUInt32();

            m_ActionChartsCount = bReader.ReadInt64();

            for (int i = 0; i < m_ActionChartsCount; i++)
            {
                ActionChart nActionChart = new ActionChart(bReader, m_StringTable);
                nActionChart.Parse();

                string text = nActionChart.m_TextValues.First();

                int hash = (int)CryptogramBDCRC.process(text, (uint)text.Length, 1);    //Crypto might be outdated
                
                if(!m_ActionCharts.ContainsKey(hash))
                    m_ActionCharts.Add(hash, nActionChart);
            }
        }
    }
}
