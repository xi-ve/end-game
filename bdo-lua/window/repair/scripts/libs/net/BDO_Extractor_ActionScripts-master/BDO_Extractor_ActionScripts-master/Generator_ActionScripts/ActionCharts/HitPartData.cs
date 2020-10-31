using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class HitPartData
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public string m_Unk0 { get; set; }
        public float m_Radius { get; set; }
        public float m_OffsetX { get; set; }
        public float m_OffsetY { get; set; }
        public float m_OffsetZ { get; set; }
        public int m_HitPartIndex { get; set; }
        public byte m_Unk1 { get; set; }
        
        public HitPartData(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;
        }

        public void Parse()
        {
            m_Unk0 = GetString(bReader.ReadInt32());
            m_Radius = bReader.ReadSingle();
            m_OffsetX = bReader.ReadSingle();
            m_OffsetY = bReader.ReadSingle();
            m_OffsetZ = bReader.ReadSingle();
            m_HitPartIndex = bReader.ReadInt32();
            m_Unk1 = bReader.ReadByte();
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}
