using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class VehicleRidingInfo
    {
        private BinaryReader bReader { get; set; }

        public bool m_IsSeatable { get; set; }

        public VehicleRidingInfo(BinaryReader br)
        {
            bReader = br;
        }

        public void Parse()
        {
            m_IsSeatable = bReader.ReadBoolean();

            if (m_IsSeatable)
                bReader.BaseStream.Position += 100;
        }
    }
}
