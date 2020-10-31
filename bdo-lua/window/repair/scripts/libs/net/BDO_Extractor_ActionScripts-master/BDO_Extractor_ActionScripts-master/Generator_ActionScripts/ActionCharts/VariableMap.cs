using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class VariableMap
    {
        private BinaryReader bReader { get; set; }

        public int m_Hash0 { get; set; }
        public int m_Hash1 { get; set; }

        public VariableMap(BinaryReader br)
        {
            bReader = br;
        }

        public void Parse()
        {
            m_Hash0 = bReader.ReadInt32();
            m_Hash1 = bReader.ReadInt32();
        }
    }
}
