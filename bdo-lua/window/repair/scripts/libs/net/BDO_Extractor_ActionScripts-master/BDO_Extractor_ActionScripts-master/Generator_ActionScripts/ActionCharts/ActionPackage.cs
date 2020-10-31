using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class ActionPackage
    {
        private BinaryReader bReader { get; set; }
        private bool m_IsPcActionScript { get; set; }
        private List<string> m_StringTable { get; set; }

        public int m_PackageHash { get; set; }
        public byte m_Value0 { get; set; }
        public byte m_Value1 { get; set; }
        public string m_PackageName { get; set; }
        public List<string> m_DefaultActions { get; set; }
        public short m_Value2 { get; set; }
        public byte m_Value3 { get; set; }
        public byte m_Value4 { get; set; }
        public byte m_Value5 { get; set; }
        public int m_Value6 { get; set; }
        
        private long m_AiFunctionsCount { get; set; }
        public List<AiFunction> m_AiFunctions { get; set; }

        private long m_VariablesCount { get; set; }
        public List<VariableMap> m_Variables { get; set; }

        private long m_ActionChartFuncCount { get; set; }
        public List<ActionChartFuncT> m_ActionChartFuncs { get; set; }

        private long m_ActionPackageTCount { get; set; }
        public List<ActionPackageT> m_ActionPackagesT { get; set; }

        public byte[] m_Data0 { get; set; }

        public ActionPackage(BinaryReader br, bool isPcActionScript, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;
            m_IsPcActionScript = isPcActionScript;

            m_DefaultActions = new List<string>();
            m_AiFunctions = new List<AiFunction>();
            m_Variables = new List<VariableMap>();
            m_ActionChartFuncs = new List<ActionChartFuncT>();
            m_ActionPackagesT = new List<ActionPackageT>();

            m_Data0 = new byte[60];
        }

        public void Parse()
        {
            m_PackageHash = bReader.ReadInt32();

            m_Value0 = bReader.ReadByte();
            m_Value1 = bReader.ReadByte();

            m_PackageName = GetString(bReader.ReadInt32());

            for(int i = 0; i < 10; i++)
                m_DefaultActions.Add(GetString(bReader.ReadInt32()));

            m_Value2 = bReader.ReadInt16();
            m_Value3 = bReader.ReadByte();
            m_Value4 = bReader.ReadByte();
            m_Value5 = bReader.ReadByte();
            m_Value6 = bReader.ReadInt32();

            //readUnkownData1
            long Count0 = bReader.ReadInt64();

            for (int i = 0; i < Count0; i++)
            {
                int Value0 = bReader.ReadInt32();

                long Count1 = bReader.ReadInt64();

                for (int ii = 0; ii < Count1; ii++)
                {
                    int Value1 = bReader.ReadInt32();
                    int Value2 = bReader.ReadInt32();
                    string Text0 = GetString(bReader.ReadInt32());
                    int Value3 = bReader.ReadInt32();
                }
            }

            //m_AiFunctionsCount = bReader.ReadInt64();

            //for (int i = 0; i < m_AiFunctionsCount; i++)
            //{
            //    AiFunction nAiFunction = new AiFunction(bReader, m_StringTable);

            //    nAiFunction.Parse();
                
            //    m_AiFunctions.Add(nAiFunction);
            //}

            m_VariablesCount = bReader.ReadInt64();

            for (int i = 0; i < m_VariablesCount; i++)
            {
                VariableMap nVariableMap = new VariableMap(bReader);

                nVariableMap.Parse();
                
                m_Variables.Add(nVariableMap);
            }

            m_ActionChartFuncCount = bReader.ReadInt64();

            for (int i = 0; i < m_ActionChartFuncCount; i++)
            {
                ActionChartFuncT nActionChartFuncT = new ActionChartFuncT(bReader, m_StringTable);

                nActionChartFuncT.Parse();
                
                m_ActionChartFuncs.Add(nActionChartFuncT);
            }

            m_ActionPackageTCount = bReader.ReadInt64();

            for (int i = 0; i < m_ActionPackageTCount; i++)
            {
                ActionPackageT nActionPackageT = new ActionPackageT(bReader, m_IsPcActionScript, m_StringTable);

                nActionPackageT.Parse();
                
                m_ActionPackagesT.Add(nActionPackageT);
            }

            for (int i = 0; i < 60; i++)
                m_Data0[i] = bReader.ReadByte();
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}
