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
    public class FrameEvent_Rotate : FrameEventBase
    {
        public byte[] m_Data0 { get; set; }

        public FrameEvent_Rotate(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
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

            bw.Write(BitConverter.ToInt32(m_Data0, 0x00));
            bw.Write(BitConverter.ToSingle(m_Data0, 0x04));
            bw.Write((byte)BitConverter.ToChar(m_Data0, 0x08));
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}
