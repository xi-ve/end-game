using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_Attack : FrameEventBase
    {
        public string m_Unk0 { get; set; }
        public string m_Unk1 { get; set; }
        public string m_Unk2 { get; set; }
        public int m_Unk3 { get; set; }
        public byte[] m_UnkData { get; set; }
        public byte m_Unk4 { get; set; }

        private int m_Index_Unk0 { get; set; }
        private int m_Index_Unk1 { get; set; }
        private int m_Index_Unk2 { get; set; }

        public FrameEvent_Attack(BinaryReader br, eActionChart_FrameEvent frameEventType) : base(br, frameEventType)
        {

        }

        public override void Parse()
        {
            base.Parse();
            m_Index_Unk0 = bReader.ReadInt32();
            m_Index_Unk1 = bReader.ReadInt32();
            m_Index_Unk2 = bReader.ReadInt32();

            m_Unk3 = bReader.ReadInt32();

            m_UnkData = bReader.ReadFixedArray();

            //GCHandle pinnedArray = GCHandle.Alloc(m_UnkData, GCHandleType.Pinned);
            //IntPtr pointer = pinnedArray.AddrOfPinnedObject();

        }

        public override void Write(BinaryWriter bw)
        {
            base.Write(bw);

            bw.Write(BitConverter.ToUInt32(m_UnkData, 0x00));
            bw.Write(BitConverter.ToUInt16(m_UnkData, 0xB2));
            bw.Write(BitConverter.ToUInt16(m_UnkData, 0xB4));
            bw.Write((sbyte)BitConverter.ToChar(m_UnkData, 0xC1));
            bw.Write((sbyte)BitConverter.ToChar(m_UnkData, 0xC2));
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_Unk0 = stringTable[m_Index_Unk0];
            m_Unk1 = stringTable[m_Index_Unk1];
            m_Unk2 = stringTable[m_Index_Unk2];
        }
    }
}
