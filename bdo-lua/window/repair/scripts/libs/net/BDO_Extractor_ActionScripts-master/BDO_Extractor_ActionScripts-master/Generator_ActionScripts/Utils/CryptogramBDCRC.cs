using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.Utils
{
    public static class CryptogramBDCRC
    {
        public static uint process(string text, uint tLength, uint cType)
        {
            uint v2; // eax@1
            int v3; // ebx@1
            int v4; // ecx@1
            int v5; // esi@1
            byte[] v6; // edi@1
            int v7; // ebx@5
            int v8; // ecx@5
            int v9; // eax@5
            int v10; // eax@5
            int v11; // ebx@5
            int v12; // edx@5
            int v13; // edx@5
            int v14; // eax@5
            int v15; // edi@5
            int v16; // edi@5
            int v17; // edx@5
            int v18; // esi@5
            int v19; // esi@5
            int v20; // edi@5
            int v21; // ecx@5
            int v22; // ecx@5
            int v23; // ebx@5
            int v24; // eax@18
            int v26; // edx@23
            int v27; // eax@23
            int v28; // eax@23
            int v29; // edx@23
            int v30; // ecx@23
            int v31; // ecx@23
            int v32; // eax@23
            int v33; // ebx@23
            int v34; // ebx@23
            int v35; // ecx@23
            int v36; // esi@23
            int v37; // esi@23
            int v38; // ebx@23
            int v39; // eax@23
            int v40; // ecx@23
            int v41; // edx@23
            int v42; // ebx@40
            int v43; // eax@40
            int v44; // eax@40
            int v45; // ebx@40
            int v46; // ecx@40
            int v47; // ecx@40
            int v48; // eax@40
            int v49; // edx@40
            int v50; // edx@40
            int v51; // ecx@40
            int v52; // esi@40
            int v53; // esi@40
            int v54; // edx@40
            int v55; // eax@40
            int v56; // ecx@40
            int v57; // ebx@40
            int v58; // edx@56
            int v59; // ebx@56
            int v60; // eax@56
            int v61; // edx@56
            int v62; // eax@56
            int v63; // ecx@56
            int v64; // eax@56
            int v65; // ebx@56
            int v66; // edi@56
            int v67; // esi@56
            int v68; // edx@56
            int v69; // ecx@56
            int v70; // edx@56
            uint v71; // [sp+Ch] [bp-4h]@3
            uint v72; // [sp+Ch] [bp-4h]@22
            uint v73; // [sp+Ch] [bp-4h]@39
            int v74; // [sp+18h] [bp+8h]@23
            int v75; // [sp+18h] [bp+8h]@40

            v2 = tLength;
            v3 = (int)tLength - 558228019;
            v4 = (int)tLength - 558228019;
            v5 = (int)tLength - 558228019;
            v6 = Encoding.Default.GetBytes(text);
            int v6Index = 0;

            
            if (cType != 3) // (uint32)a1 & 3
            {
                if (cType != 1) // (uint32)a1 & 1
                {
                    if (tLength > 0xC)
                    {
                        v73 = (tLength - 13) / 0xC + 1;
                        do
                        {
                            v75 = ((v6[v6Index + 5] + ((v6[v6Index + 6] + (v6[v6Index + 7] << 8)) << 8)) << 8) + v4 + v6[v6Index + 4];
                            v42 = ((v6[v6Index + 9] + ((v6[v6Index + 10] + (v6[v6Index + 11] << 8)) << 8)) << 8) + v6[v6Index + 8] + v3;
                            v43 = BitUtils.ROL4(v42, 4);
                            v44 = (v5 + v6[v6Index] + ((v6[v6Index + 1] + ((v6[v6Index + 2] + (v6[v6Index + 3] << 8)) << 8)) << 8) - v42) ^ v43;
                            v45 = v75 + v42;
                            v46 = BitUtils.ROL4(v44, 6);
                            v47 = (v75 - v44) ^ v46;

                            tLength -= 12;

                            v48 = v45 + v44;
                            v49 = BitUtils.ROL4(v47, 8);
                            v50 = (v45 - v47) ^ v49;
                            v51 = v48 + v47;
                            v52 = BitUtils.ROL4(v50, 16);
                            v53 = (v48 - v50) ^ v52;
                            v54 = v51 + v50;
                            v55 = BitUtils.ROR4(v53, 13);
                            v56 = v55 ^ (v51 - v53);
                            v5 = v54 + v53;
                            v57 = BitUtils.ROL4(v56, 4);
                            v3 = (v54 - v56) ^ v57;
                            v4 = v5 + v56;

                            v6Index += 12;

                            --v73;
                        } while (v73 != 0);
                        v2 = tLength;
                    }
                    switch (v2)
                    {
                        case 0u:
                            return (uint)v3;
                        case 0xCu:
                        {
                            v3 += v6[v6Index + 11] << 24;
                            v3 += v6[v6Index + 10] << 16;
                            v3 += v6[v6Index + 9] << 8;
                            v3 += v6[v6Index + 8];
                            v4 += v6[v6Index + 7] << 24;
                            v4 += v6[v6Index + 6] << 16;
                            v4 += v6[v6Index + 5] << 8;
                            v4 += v6[v6Index + 4];
                            v5 += v6[v6Index + 3] << 24;
                            v5 += v6[v6Index + 2] << 16;
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        }
                        case 0xBu:
                            v3 += v6[v6Index + 10] << 16;
                            v3 += v6[v6Index + 9] << 8;
                            v3 += v6[v6Index + 8];
                            v4 += v6[v6Index + 7] << 24;
                            v4 += v6[v6Index + 6] << 16;
                            v4 += v6[v6Index + 5] << 8;
                            v4 += v6[v6Index + 4];
                            v5 += v6[v6Index + 3] << 24;
                            v5 += v6[v6Index + 2] << 16;
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        case 0xAu:
                            v3 += v6[v6Index + 9] << 8;
                            v3 += v6[v6Index + 8];
                            v4 += v6[v6Index + 7] << 24;
                            v4 += v6[v6Index + 6] << 16;
                            v4 += v6[v6Index + 5] << 8;
                            v4 += v6[v6Index + 4];
                            v5 += v6[v6Index + 3] << 24;
                            v5 += v6[v6Index + 2] << 16;
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        case 9u:
                            v3 += v6[v6Index + 8];
                            v4 += v6[v6Index + 7] << 24;
                            v4 += v6[v6Index + 6] << 16;
                            v4 += v6[v6Index + 5] << 8;
                            v4 += v6[v6Index + 4];
                            v5 += v6[v6Index + 3] << 24;
                            v5 += v6[v6Index + 2] << 16;
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        case 8u:
                            v4 += v6[v6Index + 7] << 24;
                            v4 += v6[v6Index + 6] << 16;
                            v4 += v6[v6Index + 5] << 8;
                            v4 += v6[v6Index + 4];
                            v5 += v6[v6Index + 3] << 24;
                            v5 += v6[v6Index + 2] << 16;
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        case 7u:
                            v4 += v6[v6Index + 6] << 16;
                            v4 += v6[v6Index + 5] << 8;
                            v4 += v6[v6Index + 4];
                            v5 += v6[v6Index + 3] << 24;
                            v5 += v6[v6Index + 2] << 16;
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        case 6u:
                            v4 += v6[v6Index + 5] << 8;
                            v4 += v6[v6Index + 4];
                            v5 += v6[v6Index + 3] << 24;
                            v5 += v6[v6Index + 2] << 16;
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        case 5u:
                            v4 += v6[v6Index + 4];
                            v5 += v6[v6Index + 3] << 24;
                            v5 += v6[v6Index + 2] << 16;
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        case 4u:
                            v5 += v6[v6Index + 3] << 24;
                            v5 += v6[v6Index + 2] << 16;
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        case 3u:
                            v5 += v6[v6Index + 2] << 16;
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        case 2u:
                            v5 += v6[v6Index + 1] << 8;
                            break;
                        case 1u:
                            break;
                        default:
                            v58 = BitUtils.ROL4(v4, 14);
                            v59 = (v4 ^ v3) - v58;
                            v60 = BitUtils.ROL4(v59, 11);
                            v61 = (v5 ^ v59) - v60;
                            v62 = BitUtils.ROR4(v61, 7);
                            v63 = (v61 ^ v4) - v62;
                            v64 = BitUtils.ROL4(v63, 16);
                            v65 = (v63 ^ v59) - v64;
                            v66 = BitUtils.ROL4(v65, 4);
                            v67 = (v61 ^ v65) - v66;
                            v68 = BitUtils.ROL4(v67, 14);
                            v69 = (v67 ^ v63) - v68;
                            v70 = BitUtils.ROR4(v69, 8);
                            return (uint)((v69 ^ v65) - v70);
                    }

                    v24 = v6[v6Index];
                    v5 += v24;
                }
                else
                {
                    if (tLength > 0xC)
                    {
                        v72 = (tLength - 13) / 0xC + 1;
                        do
                        {
                            v74 = (BitConverter.ToInt16(v6, v6Index + 6) << 16) + v4 + BitConverter.ToInt16(v6, v6Index + 4);
                            v26 = (BitConverter.ToInt16(v6, v6Index + 10) << 16) + v3 + BitConverter.ToInt16(v6, v6Index + 8);
                            v27 = BitUtils.ROL4(v26, 4);
                            v28 = (v5 + (BitConverter.ToInt16(v6, v6Index + 2) << 16) - v26 + BitConverter.ToInt16(v6, v6Index)) ^ v27;
                            v29 = v74 + v26;
                            v30 = BitUtils.ROL4(v28, 6);
                            v31 = (v74 - v28) ^ v30;
                            tLength -= 12;
                            v32 = v29 + v28;
                            v33 = BitUtils.ROL4(v31, 8);
                            v34 = (v29 - v31) ^ v33;
                            v35 = v32 + v31;
                            v36 = BitUtils.ROL4(v34, 16);
                            v37 = (v32 - v34) ^ v36;
                            v38 = v35 + v34;
                            v39 = BitUtils.ROR4(v37, 13);
                            v40 = v39 ^ (v35 - v37);
                            v5 = v38 + v37;
                            v41 = BitUtils.ROL4(v40, 4);
                            v3 = v41 ^ (v38 - v40);
                            v4 = v5 + v40;

                            v6Index += 12;

                            --v72;
                        } while (v72 != 0);
                        v2 = tLength;
                    }
                    switch (v2)
                    {
                        case 0u:
                            return (uint)v3;
                        case 0xCu:
                            v3 += (BitConverter.ToInt16(v6, v6Index + 10) << 16) + BitConverter.ToInt16(v6, v6Index + 8);
                            v4 += (BitConverter.ToInt16(v6, v6Index + 6) << 16) + BitConverter.ToInt16(v6, v6Index + 4);
                            v24 = BitConverter.ToInt16(v6, v6Index + 2) << 16;
                            v5 += BitConverter.ToInt16(v6, v6Index);
                            v5 += v24;
                            break;
                        case 4u:
                            v24 = BitConverter.ToInt16(v6, v6Index + 2) << 16;
                            v5 += BitConverter.ToInt16(v6, v6Index);
                            v5 += v24;
                            break;
                        case 0xBu:
                            v3 += v6[v6Index + 10] << 16;
                            v3 += BitConverter.ToInt16(v6, v6Index + 8);
                            v4 += (BitConverter.ToInt16(v6, v6Index + 6) << 16) + BitConverter.ToInt16(v6, v6Index + 4);
                            v24 = BitConverter.ToInt16(v6, v6Index + 2) << 16;
                            v5 += BitConverter.ToInt16(v6, v6Index);
                            v5 += v24;
                            break;
                        case 0xAu:
                            v3 += BitConverter.ToInt16(v6, v6Index + 8);
                            v4 += (BitConverter.ToInt16(v6, v6Index + 6) << 16) + BitConverter.ToInt16(v6, v6Index + 4);
                            v24 = BitConverter.ToInt16(v6, v6Index + 2) << 16;
                            v5 += BitConverter.ToInt16(v6, v6Index);
                            v5 += v24;
                            break;
                        case 9u:
                            v3 += v6[v6Index + 8];
                            v4 += (BitConverter.ToInt16(v6, v6Index + 6) << 16) + BitConverter.ToInt16(v6, v6Index + 4);
                            v5 += (BitConverter.ToInt16(v6, v6Index + 2) << 16) + BitConverter.ToInt16(v6, v6Index);
                            break;
                        case 8u:
                            v4 += (BitConverter.ToInt16(v6, v6Index + 6) << 16) + BitConverter.ToInt16(v6, v6Index + 4);
                            v5 += (BitConverter.ToInt16(v6, v6Index + 2) << 16) + BitConverter.ToInt16(v6, v6Index);
                            break;
                        case 7u:
                            v4 += v6[v6Index + 6] << 16;
                            v4 += BitConverter.ToInt16(v6, v6Index + 4);
                            v5 += (BitConverter.ToInt16(v6, v6Index + 2) << 16) + BitConverter.ToInt16(v6, v6Index);
                            break;
                        case 6u:
                            v4 += BitConverter.ToInt16(v6, v6Index + 4);
                            v5 += (BitConverter.ToInt16(v6, v6Index + 2) << 16) + BitConverter.ToInt16(v6, v6Index);
                            break;
                        case 5u:
                            v4 += v6[v6Index + 4];
                            v24 = BitConverter.ToInt16(v6, v6Index + 2) << 16;
                            v5 += BitConverter.ToInt16(v6, v6Index);
                            v5 += v24;
                            break;
                        case 3u:
                            v5 += v6[v6Index + 2] << 16;
                            v5 += BitConverter.ToInt16(v6, v6Index);
                            break;
                        case 2u:
                            v5 += BitConverter.ToInt16(v6, v6Index);
                            break;
                        case 1u:
                            v24 = v6[v6Index];
                            v5 += v24;
                            break;
                        default:
                            break;
                    }
                }
            }
            else
            {
                if (tLength <= 0xC)
                {
                    switch (v2)
                    {
                        case 0xCu:
                            v3 += BitConverter.ToInt32(v6, v6Index + 8);
                            v4 += BitConverter.ToInt32(v6, v6Index + 4);
                            v5 += BitConverter.ToInt32(v6, v6Index);
                            v58 = BitUtils.ROL4(v4, 14);
                            v59 = (v4 ^ v3) - v58;
                            v60 = BitUtils.ROL4(v59, 11);
                            v61 = (v5 ^ v59) - v60;
                            v62 = BitUtils.ROR4(v61, 7);
                            v63 = (v61 ^ v4) - v62;
                            v64 = BitUtils.ROL4(v63, 16);
                            v65 = (v63 ^ v59) - v64;
                            v66 = BitUtils.ROL4(v65, 4);
                            v67 = (v61 ^ v65) - v66;
                            v68 = BitUtils.ROL4(v67, 14);
                            v69 = (v67 ^ v63) - v68;
                            v70 = BitUtils.ROR4(v69, 8);
                            return (uint)((v69 ^ v65) - v70);
                        case 8u:
                            v4 += BitConverter.ToInt32(v6, v6Index + 4);
                            v5 += BitConverter.ToInt32(v6, v6Index);
                            v58 = BitUtils.ROL4(v4, 14);
                            v59 = (v4 ^ v3) - v58;
                            v60 = BitUtils.ROL4(v59, 11);
                            v61 = (v5 ^ v59) - v60;
                            v62 = BitUtils.ROR4(v61, 7);
                            v63 = (v61 ^ v4) - v62;
                            v64 = BitUtils.ROL4(v63, 16);
                            v65 = (v63 ^ v59) - v64;
                            v66 = BitUtils.ROL4(v65, 4);
                            v67 = (v61 ^ v65) - v66;
                            v68 = BitUtils.ROL4(v67, 14);
                            v69 = (v67 ^ v63) - v68;
                            v70 = BitUtils.ROR4(v69, 8);
                            return (uint)((v69 ^ v65) - v70);
                        case 4u:
                            v5 += BitConverter.ToInt32(v6, v6Index);
                            v58 = BitUtils.ROL4(v4, 14);
                            v59 = (v4 ^ v3) - v58;
                            v60 = BitUtils.ROL4(v59, 11);
                            v61 = (v5 ^ v59) - v60;
                            v62 = BitUtils.ROR4(v61, 7);
                            v63 = (v61 ^ v4) - v62;
                            v64 = BitUtils.ROL4(v63, 16);
                            v65 = (v63 ^ v59) - v64;
                            v66 = BitUtils.ROL4(v65, 4);
                            v67 = (v61 ^ v65) - v66;
                            v68 = BitUtils.ROL4(v67, 14);
                            v69 = (v67 ^ v63) - v68;
                            v70 = BitUtils.ROR4(v69, 8);
                            return (uint)((v69 ^ v65) - v70);
                        case 0xBu:
                            v4 += BitConverter.ToInt32(v6, v6Index + 4);
                            v3 += BitConverter.ToInt32(v6, v6Index + 8) & 0xFFFFFF;
                            v5 += BitConverter.ToInt32(v6, v6Index);
                            v58 = BitUtils.ROL4(v4, 14);
                            v59 = (v4 ^ v3) - v58;
                            v60 = BitUtils.ROL4(v59, 11);
                            v61 = (v5 ^ v59) - v60;
                            v62 = BitUtils.ROR4(v61, 7);
                            v63 = (v61 ^ v4) - v62;
                            v64 = BitUtils.ROL4(v63, 16);
                            v65 = (v63 ^ v59) - v64;
                            v66 = BitUtils.ROL4(v65, 4);
                            v67 = (v61 ^ v65) - v66;
                            v68 = BitUtils.ROL4(v67, 14);
                            v69 = (v67 ^ v63) - v68;
                            v70 = BitUtils.ROR4(v69, 8);
                            return (uint)((v69 ^ v65) - v70);
                        case 0xAu:
                            v4 += BitConverter.ToInt32(v6, v6Index + 4);
                            v3 += BitConverter.ToInt16(v6, v6Index + 8);
                            v5 += BitConverter.ToInt32(v6, v6Index);
                            v58 = BitUtils.ROL4(v4, 14);
                            v59 = (v4 ^ v3) - v58;
                            v60 = BitUtils.ROL4(v59, 11);
                            v61 = (v5 ^ v59) - v60;
                            v62 = BitUtils.ROR4(v61, 7);
                            v63 = (v61 ^ v4) - v62;
                            v64 = BitUtils.ROL4(v63, 16);
                            v65 = (v63 ^ v59) - v64;
                            v66 = BitUtils.ROL4(v65, 4);
                            v67 = (v61 ^ v65) - v66;
                            v68 = BitUtils.ROL4(v67, 14);
                            v69 = (v67 ^ v63) - v68;
                            v70 = BitUtils.ROR4(v69, 8);
                            return (uint)((v69 ^ v65) - v70);
                        case 9u:
                            v4 += BitConverter.ToInt32(v6, v6Index + 4);
                            v3 += v6[v6Index + 8];
                            v5 += BitConverter.ToInt32(v6, v6Index);
                            v58 = BitUtils.ROL4(v4, 14);
                            v59 = (v4 ^ v3) - v58;
                            v60 = BitUtils.ROL4(v59, 11);
                            v61 = (v5 ^ v59) - v60;
                            v62 = BitUtils.ROR4(v61, 7);
                            v63 = (v61 ^ v4) - v62;
                            v64 = BitUtils.ROL4(v63, 16);
                            v65 = (v63 ^ v59) - v64;
                            v66 = BitUtils.ROL4(v65, 4);
                            v67 = (v61 ^ v65) - v66;
                            v68 = BitUtils.ROL4(v67, 14);
                            v69 = (v67 ^ v63) - v68;
                            v70 = BitUtils.ROR4(v69, 8);
                            return (uint)((v69 ^ v65) - v70);
                        case 7u:
                            v4 += BitConverter.ToInt32(v6, v6Index + 4) & 0xFFFFFF;
                            v5 += BitConverter.ToInt32(v6, v6Index);
                            v58 = BitUtils.ROL4(v4, 14);
                            v59 = (v4 ^ v3) - v58;
                            v60 = BitUtils.ROL4(v59, 11);
                            v61 = (v5 ^ v59) - v60;
                            v62 = BitUtils.ROR4(v61, 7);
                            v63 = (v61 ^ v4) - v62;
                            v64 = BitUtils.ROL4(v63, 16);
                            v65 = (v63 ^ v59) - v64;
                            v66 = BitUtils.ROL4(v65, 4);
                            v67 = (v61 ^ v65) - v66;
                            v68 = BitUtils.ROL4(v67, 14);
                            v69 = (v67 ^ v63) - v68;
                            v70 = BitUtils.ROR4(v69, 8);
                            return (uint)((v69 ^ v65) - v70);
                        case 6u:
                            v4 += BitConverter.ToInt16(v6, v6Index + 4);
                            v5 += BitConverter.ToInt32(v6, v6Index);
                            v58 = BitUtils.ROL4(v4, 14);
                            v59 = (v4 ^ v3) - v58;
                            v60 = BitUtils.ROL4(v59, 11);
                            v61 = (v5 ^ v59) - v60;
                            v62 = BitUtils.ROR4(v61, 7);
                            v63 = (v61 ^ v4) - v62;
                            v64 = BitUtils.ROL4(v63, 16);
                            v65 = (v63 ^ v59) - v64;
                            v66 = BitUtils.ROL4(v65, 4);
                            v67 = (v61 ^ v65) - v66;
                            v68 = BitUtils.ROL4(v67, 14);
                            v69 = (v67 ^ v63) - v68;
                            v70 = BitUtils.ROR4(v69, 8);
                            return (uint)((v69 ^ v65) - v70);
                        case 5u:
                            v4 += v6[v6Index + 4];
                            v5 += BitConverter.ToInt32(v6, v6Index);
                            v58 = BitUtils.ROL4(v4, 14);
                            v59 = (v4 ^ v3) - v58;
                            v60 = BitUtils.ROL4(v59, 11);
                            v61 = (v5 ^ v59) - v60;
                            v62 = BitUtils.ROR4(v61, 7);
                            v63 = (v61 ^ v4) - v62;
                            v64 = BitUtils.ROL4(v63, 16);
                            v65 = (v63 ^ v59) - v64;
                            v66 = BitUtils.ROL4(v65, 4);
                            v67 = (v61 ^ v65) - v66;
                            v68 = BitUtils.ROL4(v67, 14);
                            v69 = (v67 ^ v63) - v68;
                            v70 = BitUtils.ROR4(v69, 8);
                            return (uint)((v69 ^ v65) - v70);
                        case 3u:
                            v24 = BitConverter.ToInt32(v6, v6Index) & 0xFFFFFF;
                            v5 += v24;
                            break;
                        case 0u:
                            return (uint)v3;
                        case 2u:
                            v5 += BitConverter.ToInt16(v6, v6Index);
                            break;
                        case 1u:
                            v24 = v6[v6Index];
                            v5 += v24;
                            break;
                        default:
                            return (uint)v3;
                    }
                }
                while (true)
                {
                    v71 = (v2 - 13) / 0xC + 1;
                    while (true)
                    {
                        v7 = BitConverter.ToInt32(v6, v6Index + 8) + v3;
                        v8 = BitConverter.ToInt32(v6, v6Index + 4) + v4;
                        v9 = BitUtils.ROL4(v7, 4);
                        v10 = (v5 + BitConverter.ToInt32(v6, v6Index) - v7) ^ v9;
                        v11 = v8 + v7;
                        v12 = BitUtils.ROL4(v10, 6);
                        v13 = (v8 - v10) ^ v12;
                        v14 = v11 + v10;
                        v15 = BitUtils.ROL4(v13, 8);
                        v16 = (v11 - v13) ^ v15;
                        v17 = v14 + v13;
                        v18 = BitUtils.ROL4(v16, 16);
                        v19 = (v14 - v16) ^ v18;
                        v20 = v17 + v16;
                        v21 = BitUtils.ROR4(v19, 13);
                        v22 = (v17 - v19) ^ v21;
                        v5 = v20 + v19;
                        v23 = BitUtils.ROL4(v22, 4);
                        tLength -= 12;
                        
                        v3 = (v20 - v22) ^ v23;
                        v4 = v5 + v22;
                        if (--v71 == 0)
                            break;
                        v6Index += 12;
                    }
                    if (tLength > 0xC)
                        break;
                    v2 = tLength;
                    v6Index = 0;
                    
                }
            }

            v58 = BitUtils.ROL4(v4, 14);
            v59 = (v4 ^ v3) - v58;
            v60 = BitUtils.ROL4(v59, 11);
            v61 = (v5 ^ v59) - v60;
            v62 = BitUtils.ROR4(v61, 7);
            v63 = (v61 ^ v4) - v62;
            v64 = BitUtils.ROL4(v63, 16);
            v65 = (v63 ^ v59) - v64;
            v66 = BitUtils.ROL4(v65, 4);
            v67 = (v61 ^ v65) - v66;
            v68 = BitUtils.ROL4(v67, 14);
            v69 = (v67 ^ v63) - v68;
            v70 = BitUtils.ROR4(v69, 8);
            return (uint)((v69 ^ v65) - v70);
        }
    }
}
