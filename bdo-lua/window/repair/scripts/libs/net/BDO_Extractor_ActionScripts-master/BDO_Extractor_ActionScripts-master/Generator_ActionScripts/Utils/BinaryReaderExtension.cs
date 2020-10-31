using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.Utils
{
    public static class BinaryReaderExtension
    {
        public static byte[] ReadFixedArray(this BinaryReader reader, int factor = 1)
        {
            long unkDataCount = reader.ReadInt64() * factor;
            List<byte> unkData = new List<byte>();
            for (int iUD = 0; iUD < unkDataCount; iUD++)
            {
                unkData.Add(reader.ReadByte());
            }

           return unkData.ToArray();
        }

        public static List<string> ReadStringTable(this BinaryReader reader)
        {
            List<string> stringTable = new List<string>();

            int count = reader.ReadInt32();

            reader.ReadByte();

            for (int i = 0; i < count; i++)
            {
                int sLength = reader.ReadInt32();

                byte[] sBuffer = reader.ReadBytes(sLength);

                reader.ReadByte();

                stringTable.Add(Encoding.Default.GetString(sBuffer, 0, sLength));
            }

            return stringTable;
        }
    }
}
