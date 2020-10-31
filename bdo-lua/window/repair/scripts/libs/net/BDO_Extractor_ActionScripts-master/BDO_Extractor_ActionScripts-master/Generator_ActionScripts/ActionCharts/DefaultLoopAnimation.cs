using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class DefaultLoopAnimation
    {
        private BinaryReader bReader { get; set; }

        public int m_AudioIndex { get; set; }
        public int m_AudioIndexB { get; set; }
        public short m_Unk1 { get; set; }
        public short m_Unk2 { get; set; }
        public short m_Unk3 { get; set; }
        public string m_UnkString { get; set; }
        public short m_Unk4 { get; set; }
        public int m_Unk5 { get; set; }
        public int m_Unk6 { get; set; }

        private int m_Index_UnkString { get; set; }

        public DefaultLoopAnimation(BinaryReader br)
        {
            bReader = br;
        }

        public void Parse()
        {
            m_AudioIndex = bReader.ReadInt32();
            m_AudioIndexB = bReader.ReadInt32();
            m_Unk1 = bReader.ReadInt16();
            m_Unk2 = bReader.ReadInt16();
            m_Unk3 = bReader.ReadInt16();
            m_Index_UnkString = bReader.ReadInt32();
            m_Unk4 = bReader.ReadInt16();
            m_Unk5 = bReader.ReadInt32();
            m_Unk6 = bReader.ReadInt32();
;        }
    }
}
