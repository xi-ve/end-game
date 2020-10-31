using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class EffectSwitch
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public int m_Hash { get; set; }
        public string m_EffectName { get; set; }
        public string m_EffectFileName { get; set; }
        public byte[] m_AdditionalData { get; set; }
        
        private int m_BoneDataCount { get; set; }
        public List<BoneData> m_BoneData { get; set; }

        public EffectSwitch(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;

            m_BoneData = new List<BoneData>();
        }

        public void Parse(bool readHash = true)
        {
            if(readHash)
                m_Hash = bReader.ReadInt32();

            m_EffectName = GetString(bReader.ReadInt32());
            m_EffectFileName = GetString(bReader.ReadInt32());

            m_AdditionalData = bReader.ReadFixedArray();

            m_BoneDataCount = m_AdditionalData[m_AdditionalData.Length - 3];

            for (int iBD = 0; iBD < m_BoneDataCount; iBD++)
            {
                BoneData nBoneData = new BoneData(bReader, m_StringTable);
                nBoneData.Parse();

                m_BoneData.Add(nBoneData);
            }

            if (!readHash)
                bReader.BaseStream.Position += 3;
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}
