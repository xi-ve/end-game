using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_AttackArrowSkill : FrameEvent_AttackArrow
    {
        public byte[] m_Data0 { get; set; }
        public byte m_Unk0 { get; set; }

        public FrameEvent_AttackArrowSkill(BinaryReader br, eActionChart_FrameEvent frameEventType) : base(br,
            frameEventType)
        {

        }

        public override void Parse()
        {
            base.Parse();

            long unkDataCount = bReader.ReadInt64();
            List<byte> unkData = new List<byte>();
            for (int iUD = 0; iUD < unkDataCount; iUD++)
            {
                unkData.Add(bReader.ReadByte());
            }

            m_Data0 = unkData.ToArray();

            m_Unk0 = bReader.ReadByte();

            //GCHandle pinnedArray = GCHandle.Alloc(m_Data0, GCHandleType.Pinned);
            //IntPtr pointer = pinnedArray.AddrOfPinnedObject();
        }

        public override void Write(BinaryWriter bw)
        {
            base.Write(bw);

            bw.Write((int)BitConverter.ToUInt16(m_Data0, 0x06));
            bw.Write(BitConverter.ToUInt32(m_UnkData, 0x00));

            List<short> buffList = new List<short>();
            List<short> playerBuffList = new List<short>();

            for (int i = 0; i < 5; i++)
            {
                short value = BitConverter.ToInt16(m_Data0, 0x0B + (2 * i));

                if (value != -1)
                    buffList.Add(value);
            }

            for (int i = 0; i < 5; i++)
            {
                short value = BitConverter.ToInt16(m_Data0, 0x16 + (2 * i));

                if (value != -1)
                    buffList.Add(value);
            }

            bw.Write(playerBuffList.Count);

            foreach (var a in playerBuffList)
            {
                bw.Write(a);
            }

            bw.Write(buffList.Count);

            foreach (var a in buffList)
            {
                bw.Write(a);
            }
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}
