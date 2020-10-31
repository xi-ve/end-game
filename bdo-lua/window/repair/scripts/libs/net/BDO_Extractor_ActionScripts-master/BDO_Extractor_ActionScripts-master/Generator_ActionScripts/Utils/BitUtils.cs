using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.Utils
{
    public static class BitUtils
    {
        public static int ROL4(int value, int count)
        {
            return (value << count) | (value >> (32 - count));
        }

        public static int ROR4(int value, int count)
        {
            return (value >> count) | (value << (32 - count));
        }
    }
}
