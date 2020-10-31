using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class ActionChartData
    {
        public byte[] m_Data { get; set; }

        public int m_TargetTypes { get; set; }
        public float m_StartFrame { get; set; }
        public float m_EndFrame { get; set; }
        public float m_AnimationSpeed { get; set; }
        public short m_VarySRP { get; set; }
        public float m_StaminaSpeed { get; set; }
        public float m_MoveSpeed { get; set; }
        public short m_SkillId { get; set; }
        public short m_ApplySp { get; set; }
        public short m_IndexedActionCount { get; set; }
        public short m_AttackAbsorbAmount1 { get; set; }
        public short m_AttackAbsorbAmount2 { get; set; }
        public short m_VaryWp { get; set; }
        public short m_CombineWavePoint { get; set; }
        public short m_NeedCombineWavePoint { get; set; }
        public short m_AddDvForMonster { get; set; }
        public short m_AddPvForMonster { get; set; }
        public byte m_ActionType { get; set; }
        public byte m_MoveDirectionType { get; set; }
        public byte m_SpUseType { get; set; }
        public byte m_GuardType { get; set; }
        public byte m_ApplySpeedbuffType { get; set; }
        public byte m_AttackAbsorbType1 { get; set; }
        public byte m_AttackAbsorbType2 { get; set; }
        public sbyte m_NavigationTypes { get; set; }
        public sbyte m_VehicleSkillKey { get; set; }
        public byte m_BattleAimedActionType { get; set; }
        public sbyte m_AttachTerrainType { get; set; }
        public byte m_AddDv { get; set; }
        public byte m_AddPv { get; set; }
        public byte m_BitData1 { get; set; }
        public byte m_BitData2 { get; set; }
        public byte m_BitData3 { get; set; }
        public byte m_BitData4 { get; set; }
        public byte m_BitData5 { get; set; }
        public byte m_BitData6 { get; set; }
        public byte m_BitData7 { get; set; }

        public ActionChartData(byte[] data)
        {
            m_Data = data;
        }

        public void Parse()
        {
            //GCHandle pinnedArray = GCHandle.Alloc(m_Data, GCHandleType.Pinned);
            //IntPtr pointer = pinnedArray.AddrOfPinnedObject();
            
            using (var ms = new MemoryStream(m_Data))
            {
                using (var br = new BinaryReader(ms))
                {
                    try
                    {
                        m_TargetTypes = br.ReadInt32();
                        m_StartFrame = br.ReadSingle();
                        m_EndFrame = br.ReadSingle();
                        m_AnimationSpeed = br.ReadSingle();

                        br.BaseStream.Position += 104;

                        m_VarySRP = br.ReadInt16();

                        br.BaseStream.Position += 22;

                        m_StaminaSpeed = br.ReadSingle();

                        br.BaseStream.Position += 16;

                        m_MoveSpeed = br.ReadSingle();
                        m_SkillId = br.ReadInt16();

                        br.BaseStream.Position += 14;

                        m_ApplySp = br.ReadInt16();
                        m_IndexedActionCount = br.ReadInt16();

                        br.BaseStream.Position += 2;

                        m_AttackAbsorbAmount1 = br.ReadInt16();
                        m_AttackAbsorbAmount2 = br.ReadInt16();

                        br.BaseStream.Position += 4;

                        m_VaryWp = br.ReadInt16();
                        m_CombineWavePoint = br.ReadInt16();
                        m_NeedCombineWavePoint = br.ReadInt16();
                        m_AddDvForMonster = br.ReadInt16();
                        m_AddPvForMonster = br.ReadInt16();

                        br.BaseStream.Position += 4;

                        m_ActionType = br.ReadByte();
                        m_MoveDirectionType = br.ReadByte();
                        m_SpUseType = br.ReadByte();

                        br.BaseStream.Position += 4;

                        m_GuardType = br.ReadByte();
                        m_ApplySpeedbuffType = br.ReadByte();

                        br.BaseStream.Position += 8;

                        m_AttackAbsorbType1 = br.ReadByte();
                        m_AttackAbsorbType2 = br.ReadByte();

                        br.BaseStream.Position += 9;

                        m_NavigationTypes = br.ReadSByte();

                        br.BaseStream.Position += 3;

                        m_VehicleSkillKey = br.ReadSByte();

                        br.BaseStream.Position += 1;

                        m_BattleAimedActionType = br.ReadByte();

                        br.BaseStream.Position += 3;

                        m_AttachTerrainType = br.ReadSByte();

                        br.BaseStream.Position += 1;

                        m_AddDv = br.ReadByte();
                        m_AddPv = br.ReadByte();

                        br.BaseStream.Position += 4;

                        m_BitData1 = br.ReadByte();
                        m_BitData2 = br.ReadByte();
                        m_BitData3 = br.ReadByte();
                        m_BitData4 = br.ReadByte();
                        m_BitData5 = br.ReadByte();
                        m_BitData6 = br.ReadByte();
                        m_BitData7 = br.ReadByte();
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine("Failed to read ActionChartData!");
                    }
                }
            }
        }
    }
}
