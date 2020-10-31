using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class ActionChartSubFuncT
    {
        private BinaryReader bReader { get; set; }

        public int m_Value0 { get; set; }
        public short m_Value1 { get; set; }
        public short m_Value2 { get; set; }
        public short m_Value3 { get; set; }

        public ActionChartSubFuncT(BinaryReader br)
        {
            bReader = br;
        }

        public void Parse()
        {
            m_Value0 = bReader.ReadInt32();
            m_Value1 = bReader.ReadInt16();
            m_Value2 = bReader.ReadInt16();
            m_Value3 = bReader.ReadInt16();
        }
    }
}
