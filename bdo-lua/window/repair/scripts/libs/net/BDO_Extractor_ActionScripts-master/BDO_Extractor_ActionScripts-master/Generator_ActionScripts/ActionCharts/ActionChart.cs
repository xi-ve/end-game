using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class ActionChart
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public List<string> m_TextValues { get; set; }
        
        public byte[] m_Data0 { get; set; }

        private long m_ChartsCount { get; set; }
        public List<ActionChart_0> m_Charts { get; set; }

        public ActionChartData m_ActionChartData { get; set; }

        public ActionChart(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;

            m_TextValues = new List<string>();
            m_Charts = new List<ActionChart_0>();

            m_Data0 = new byte[16];
        }

        public void Parse()
        {
            for(int i = 0; i < 10; i++)
                m_TextValues.Add(GetString(bReader.ReadInt32()));

            for (int i = 0; i < 8; i++)
                m_Data0[i] = bReader.ReadByte();

            m_ChartsCount = bReader.ReadInt64();

            for (int i = 0; i < m_ChartsCount; i++)
            {
                ActionChart_0 nActionChart0 = new ActionChart_0(bReader, m_StringTable);
                nActionChart0.Parse();

                m_Charts.Add(nActionChart0);
            }

            byte[] bActionChartData = bReader.ReadFixedArray();
            
            m_ActionChartData = new ActionChartData(bActionChartData);
            m_ActionChartData.Parse();
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}
