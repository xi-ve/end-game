using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class ActionChartFuncT
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        private long m_ActionBranchIdxCount { get; set; }
        public List<int> m_ActionBranchIdx { get; set; }

        private long m_SubFuncCount { get; set; }
        public List<ActionChartSubFuncT> m_ActionChartSubFuncs { get; set; }

        public string m_ActionChartFunction { get; set; }
        
        public ActionChartFuncT(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;

            m_ActionBranchIdx = new List<int>();
            m_ActionChartSubFuncs = new List<ActionChartSubFuncT>();
        }

        public void Parse()
        {
            m_ActionBranchIdxCount = bReader.ReadInt64();

            for(int i = 0; i < m_ActionBranchIdxCount; i++)
                m_ActionBranchIdx.Add(bReader.ReadInt32());

            m_SubFuncCount = bReader.ReadInt64();

            for (int i = 0; i < m_SubFuncCount; i++)
            {
                ActionChartSubFuncT nActionChartSubFuncT = new ActionChartSubFuncT(bReader);
                nActionChartSubFuncT.Parse();

                m_ActionChartSubFuncs.Add(nActionChartSubFuncT);
            }

            m_ActionChartFunction = GetString(bReader.ReadInt32());
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}
