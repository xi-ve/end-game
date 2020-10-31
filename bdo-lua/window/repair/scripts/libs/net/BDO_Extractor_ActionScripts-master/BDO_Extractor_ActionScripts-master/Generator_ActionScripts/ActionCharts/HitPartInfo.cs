using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class HitPartInfo
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public long m_HitParInfoCount { get; set; }
        public List<HitPart> m_HitParts { get; set; }
        public List<string> m_HitPartsStrings { get; set; }
        
        public HitPartInfo(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;

            m_HitParts = new List<HitPart>();
            m_HitPartsStrings = new List<string>();
        }

        public void Parse()
        {
            m_HitParInfoCount = bReader.ReadInt64();

            for (int i = 0; i < m_HitParInfoCount; i++)
            {
                HitPart nHitPart = new HitPart(bReader, m_StringTable);
                nHitPart.Parse();

                m_HitParts.Add(nHitPart);
            }

            long stringListCount = bReader.ReadInt64();

            for (int i = 0; i < stringListCount; i++)
            {
                m_HitPartsStrings.Add(GetString(bReader.ReadInt32()));
            }
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}
