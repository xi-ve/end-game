using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class HitPart
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public int m_Unk1 { get; set; }
        public int m_Unk2 { get; set; }
        public List<HitPartData> m_HitPartData { get; set; }

        public HitPart(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;

            m_HitPartData = new List<HitPartData>();
        }

        public void Parse()
        {
            m_Unk1 = bReader.ReadInt32();
            m_Unk2 = bReader.ReadInt32();

            long additionalInfoCount = bReader.ReadInt64();

            for (int i = 0; i < additionalInfoCount; i++)
            {
                HitPartData nHitPartData = new HitPartData(bReader, m_StringTable);
                nHitPartData.Parse();

                m_HitPartData.Add(nHitPartData);
            }
        }
    }
}
