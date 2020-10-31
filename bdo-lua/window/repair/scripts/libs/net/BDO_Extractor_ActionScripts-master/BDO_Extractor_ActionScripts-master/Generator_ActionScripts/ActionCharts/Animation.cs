using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class Animation
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public int m_AnimationHash { get; set; }
        public string m_AnimationName { get; set; }
        public string m_AnimationFileName { get; set; }
        
        public Animation(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;
        }

        public void Parse()
        {
            m_AnimationHash = bReader.ReadInt32();
            m_AnimationName = GetString(bReader.ReadInt32());
            m_AnimationFileName = GetString(bReader.ReadInt32());

            short unkDataCount = bReader.ReadInt16();
            if (unkDataCount > 0)
                bReader.BaseStream.Position += 24;

            bool unkBool = bReader.ReadBoolean();
            if (unkBool)
                bReader.BaseStream.Position += 12;

            int defaultLoopAnimationCount = bReader.ReadInt32();

            for (int iLA = 0; iLA < defaultLoopAnimationCount; iLA++)
            {
                DefaultLoopAnimation nLoopAnimation = new DefaultLoopAnimation(bReader);
                nLoopAnimation.Parse();
            }
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}
