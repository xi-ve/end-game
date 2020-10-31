using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.Utils
{
    public static class BinaryWriterExtension
    {
        public static void WriteFixedWString(this BinaryWriter bw, string text)
        {
            for (int i = 0; i < text.Length; i++)
            {
                bw.Write(text[i]);
                bw.Write((byte)0);
            }
        }

        public static void WriteFixedWString(this BinaryWriter bw, byte[] text)
        {
            for (int i = 0; i < text.Length; i++)
            {
                bw.Write(text[i]);
            }
        }
    }
}
