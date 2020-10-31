using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_MovePos : FrameEventBase
    {
        public byte[] m_Data0 { get; set; }

        public FrameEvent_MovePos(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Data0 = bReader.ReadFixedArray();

            //GCHandle pinnedArray = GCHandle.Alloc(m_Data0, GCHandleType.Pinned);
            //IntPtr pointer = pinnedArray.AddrOfPinnedObject();
        }

        public override void Write(BinaryWriter bw)
        {
            base.Write(bw);

            bw.Write(BitConverter.ToSingle(m_Data0, 0x04));
            bw.Write(BitConverter.ToSingle(m_Data0, 0x08));
            bw.Write(BitConverter.ToSingle(m_Data0, 0x0C));
            bw.Write(BitConverter.ToSingle(m_Data0, 0x10));
            bw.Write(BitConverter.ToSingle(m_Data0, 0x14));
            bw.Write((sbyte)BitConverter.ToChar(m_Data0, 0x18));
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}
