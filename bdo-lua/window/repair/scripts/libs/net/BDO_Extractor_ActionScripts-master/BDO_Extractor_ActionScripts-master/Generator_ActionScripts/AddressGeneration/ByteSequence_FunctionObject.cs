using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.AddressGeneration
{
    public class ByteSequence_FunctionObject
    {
        public string m_Name { get; private set; }
        public string m_IDA_pattern { get; private set; }
        public string m_IDA_mask { get; private set; }
        public int m_Offset { get; private set; }

        public List<long> m_Results { get; set; }

        public byte[] m_PatternBytes { get; private set; }
        public bool[] m_Mask { get; private set; }

        public ByteSequence_FunctionObject(string name, string ida_pattern, string ida_mask, int offset)
        {
            m_Name = name;
            m_IDA_pattern = ida_pattern;
            m_IDA_mask = ida_mask;
            m_Offset = offset;

            m_PatternBytes = ConvertPattern();
            m_Mask = ConvertMask();

            m_Results = new List<long>();
        }

        private byte[] ConvertPattern()
        {
            string[] s_bytes = m_IDA_pattern.Split('\\');

            List<byte> pattern = new List<byte>();

            foreach (var sByte in s_bytes)
            {
                if (sByte.StartsWith("x"))
                {
                    string t_sByte = sByte.TrimStart('x');

                    byte value = byte.Parse(t_sByte, System.Globalization.NumberStyles.HexNumber);

                    pattern.Add(value);
                }
            }

            return pattern.ToArray();
        }

        private bool[] ConvertMask()
        {
            bool[] mask = new bool[m_IDA_mask.Length];

            for (int i = 0; i < m_IDA_mask.Length; i++)
            {
                char c = m_IDA_mask[i];

                if (c == 'x')
                    mask[i] = true;
                else
                {
                    mask[i] = false;
                }
            }

            return mask;
        }
    }
}
