using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class AiFunction
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public int m_FunctionHash { get; set; }

        private long m_AiConstantsCount { get; set; }
        public List<AIConstant> m_AiConstants { get; set; }

        public AiFunction(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;

            m_AiConstants = new List<AIConstant>();
        }

        public void Parse()
        {
            m_FunctionHash = bReader.ReadInt32();

            m_AiConstantsCount = bReader.ReadInt64();

            for(int i = 0; i < m_AiConstantsCount; i++)
            {
                AIConstant nAiConstant = new AIConstant(bReader, m_StringTable);
                nAiConstant.Parse();

                m_AiConstants.Add(nAiConstant);
            }
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}
