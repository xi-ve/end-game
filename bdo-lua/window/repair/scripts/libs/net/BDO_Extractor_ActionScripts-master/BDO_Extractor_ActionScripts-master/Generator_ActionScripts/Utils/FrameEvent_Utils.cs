using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.ActionCharts.FrameEvents;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.Utils
{
    public class FrameEvent_Utils
    {
        public static FrameEventBase GetFrameEventBase(BinaryReader br, eActionChart_FrameEvent type, List<string> stringTable)
        {
            switch (type)
            {
                case eActionChart_FrameEvent.eFrameEvent_Attack:
                    return new FrameEvent_Attack(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AttackSkill:
                    return new FrameEvent_AttackSkill(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AttackArrow:
                    return new FrameEvent_AttackArrow(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AttackArrowSkill:
                    return new FrameEvent_AttackArrowSkill(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AttackCatch:
                    return new FrameEvent_AttackCatch(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AttackThrow:
                    return new FrameEvent_AttackThrow(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Effect:
                    return new FrameEvent_Effect(br, type, stringTable);

                case eActionChart_FrameEvent.eFrameEvent_EffectGround:
                    return new FrameEvent_EffectGround(br, type, stringTable);

                case eActionChart_FrameEvent.eFrameEvent_EffectSwitch:
                    return new FrameEvent_EffectSwitch(br, type);

                case eActionChart_FrameEvent.eFrameEvent_EffectSwitchChain:
                    return new FrameEvent_EffectSwitchChain(br, type);


                case eActionChart_FrameEvent.eFrameEvent_EffectSwitchTarget:
                    return new FrameEvent_EffectSwitchTarget(br, type);


                case eActionChart_FrameEvent.eFrameEvent_EffectSwitchTargetAllOff:
                    return new FrameEvent_EffectSwitchTargetAllOff(br, type);


                case eActionChart_FrameEvent.eFrameEvent_EffectSwitchChange:
                    return new FrameEvent_EffectSwitchChange(br, type);


                case eActionChart_FrameEvent.eFrameEvent_EffectSwitchAllOff:
                    return new FrameEvent_EffectSwitchAllOff(br, type);


                case eActionChart_FrameEvent.eFrameEvent_CharacterEffect:
                    return new FrameEvent_CharacterEffect(br, type);

                case eActionChart_FrameEvent.eFrameEvent_GrassShake:
                    return new FrameEvent_GrassShake(br, type);


                case eActionChart_FrameEvent.eFrameEvent_CameraShake:
                    return new FrameEvent_CameraShake(br, type);

                case eActionChart_FrameEvent.eFrameEvent_CameraDirShake:
                    return new FrameEvent_CameraDirShake(br, type);

                case eActionChart_FrameEvent.eFrameEvent_CameraMotion:
                    return new FrameEvent_CameraMotion(br, type);

                case eActionChart_FrameEvent.eFrameEvent_CameraPulse:
                    return new FrameEvent_CameraPulse(br, type);

                case eActionChart_FrameEvent.eFrameEvent_OrderToSummon:
                    return new FrameEvent_OrderToSummon(br, type);

                case eActionChart_FrameEvent.eFrameEvent_OrderToHorse:
                    return new FrameEvent_OrderToHorse(br, type);

                case eActionChart_FrameEvent.eFrameEvent_OrderToRideVehicle:
                    return new FrameEvent_OrderToRideVehicle(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ShowBubbleBox:
                    return new FrameEvent_ShowBubbleBox(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Delay:
                    return new FrameEvent_Delay(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AnimationSpeed:
                    return new FrameEvent_AnimationSpeed(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Speed:
                    return new FrameEvent_Speed(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Rotate:
                    return new FrameEvent_Rotate(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Variable:
                    return new FrameEvent_Variable(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SwordTrail:
                    return new FrameEvent_SwordTrail(br, type);

                case eActionChart_FrameEvent.eFrameEvent_BounceBack:
                    return new FrameEvent_BounceBack(br, type);

                case eActionChart_FrameEvent.eFrameEvent_PushBack:
                    return new FrameEvent_PushBack(br, type);

                case eActionChart_FrameEvent.eFrameEvent_PickItemDropList:
                    return new FrameEvent_PickItemDropList(br, type);

                case eActionChart_FrameEvent.eFrameEvent_MeshOn:
                    return new FrameEvent_MeshOn(br, type);

                case eActionChart_FrameEvent.eFrameEvent_MeshOff:
                    return new FrameEvent_MeshOff(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Jump:
                    return new FrameEvent_Jump(br, type);

                case eActionChart_FrameEvent.eFrameEvent_WeaponIn:
                    return new FrameEvent_WeaponIn(br, type);

                case eActionChart_FrameEvent.eFrameEvent_WeaponOut:
                    return new FrameEvent_WeaponOut(br, type);

                case eActionChart_FrameEvent.eFrameEvent_WeaponMeshOn:
                    return new FrameEvent_WeaponMeshOn(br, type);

                case eActionChart_FrameEvent.eFrameEvent_WeaponMeshOff:
                    return new FrameEvent_WeaponMeshOff(br, type);

                case eActionChart_FrameEvent.eFrameEvent_PointBlur:
                    return new FrameEvent_PointBlur(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ChromaticBlur:
                    return new FrameEvent_ChromaticBlur(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Blur:
                    return new FrameEvent_Blur(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SlowMotion:
                    return new FrameEvent_SlowMotion(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ColorByPass:
                    return new FrameEvent_ColorByPass(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ColorBalance:
                    return new FrameEvent_ColorBalance(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Glitter:
                    return new FrameEvent_Glitter(br, type);

                case eActionChart_FrameEvent.eFrameEvent_BoneScale:
                    return new FrameEvent_BoneScale(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundKill:
                    return new FrameEvent_SoundKill(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundBase:
                    return new FrameEvent_SoundBase(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Sound:
                    return new FrameEvent_Sound(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Voice:
                    return new FrameEvent_Voice(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundExternal:
                    return new FrameEvent_SoundExternal(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundWeaponSwing:
                    return new FrameEvent_SoundWeaponSwing(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundFootstep:
                    return new FrameEvent_SoundFootstep(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundJumpUp:
                    return new FrameEvent_SoundJumpUp(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundJumpLand:
                    return new FrameEvent_SoundJumpLand(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundMovement:
                    return new FrameEvent_SoundMovement(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundWeaponIn:
                    return new FrameEvent_SoundWeaponIn(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundWeaponOut:
                    return new FrameEvent_SoundWeaponOut(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundImpact:
                    return new FrameEvent_SoundImpact(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundCommon:
                    return new FrameEvent_SoundCommon(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundBodyfall:
                    return new FrameEvent_SoundBodyfall(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundMovementStop:
                    return new FrameEvent_SoundMovementStop(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundWeaponReady:
                    return new FrameEvent_SoundWeaponReady(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SoundPassingGrass:
                    return new FrameEvent_SoundPassingGrass(br, type);

                case eActionChart_FrameEvent.eFrameEvent_FacialAnimation:
                    return new FrameEvent_FacialAnimation(br, type);

                case eActionChart_FrameEvent.eFrameEvent_FacialAnimationWeight:
                    return new FrameEvent_FacialAnimationWeight(br, type);

                case eActionChart_FrameEvent.eFrameEvent_FaceMorphWeight:
                    return new FrameEvent_FaceMorphWeight(br, type);

                case eActionChart_FrameEvent.eFrameEvent_KeepAimOn:
                    return new FrameEvent_KeepAimOn(br, type);

                case eActionChart_FrameEvent.eFrameEvent_KeepAimOff:
                    return new FrameEvent_KeepAimOff(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Collect:
                    return new FrameEvent_Collect(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Product:
                    return new FrameEvent_Product(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ReTargetPosition:
                    return new FrameEvent_ReTargetPosition(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ChangeSpeedToTarget:
                    return new FrameEvent_ChangeSpeedToTarget(br, type);

                case eActionChart_FrameEvent.eFrameEvent_FindTarget:
                    return new FrameEvent_FindTarget(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SetFindedTarget:
                    return new FrameEvent_SetFindedTarget(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SetCameraFov:
                    return new FrameEvent_SetCameraFov(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ResetCameraFov:
                    return new FrameEvent_ResetCameraFov(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SetCameraPos:
                    return new FrameEvent_SetCameraPos(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ResetCameraPos:
                    return new FrameEvent_ResetCameraPos(br, type);

                case eActionChart_FrameEvent.eFrameEvent_RiderIK:
                    return new FrameEvent_RiderIK(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AdditiveAnimation:
                    return new FrameEvent_AdditiveAnimation(br, type);

                case eActionChart_FrameEvent.eFrameEvent_LookAt:
                    return new FrameEvent_LookAt(br, type);

                case eActionChart_FrameEvent.eFrameEvent_StartCameraWave:
                    return new FrameEvent_StartCameraWave(br, type);

                case eActionChart_FrameEvent.eFrameEvent_StopCameraWave:
                    return new FrameEvent_StopCameraWave(br, type);

                case eActionChart_FrameEvent.eFrameEvent_MovePos:
                    return new FrameEvent_MovePos(br, type);

                case eActionChart_FrameEvent.eFrameEvent_VaryStat:
                    return new FrameEvent_VaryStat(br, type);

                case eActionChart_FrameEvent.eFrameEvent_VaryVehicleStat:
                    return new FrameEvent_VaryVehicleStat(br, type);

                case eActionChart_FrameEvent.eFrameEvent_TowerAim:
                    return new FrameEvent_TowerAim(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Fishing:
                    return new FrameEvent_Fishing(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SetHitPartHp:
                    return new FrameEvent_SetHitPartHp(br, type);

                case eActionChart_FrameEvent.eFrameEvent_VaryHitPartHp:
                    return new FrameEvent_VaryHitPartHp(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SetHitPartAvoid:
                    return new FrameEvent_SetHitPartAvoid(br, type);

                case eActionChart_FrameEvent.eFrameEvent_BuildTent:
                    return new FrameEvent_BuildTent(br, type);

                case eActionChart_FrameEvent.eFrameEvent_TakeDownTent:
                    return new FrameEvent_TakeDownTent(br, type);

                case eActionChart_FrameEvent.eFrameEvent_RollRateDice:
                    return new FrameEvent_RollRateDice(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Manufacture:
                    return new FrameEvent_Manufacture(br, type);

                case eActionChart_FrameEvent.eFrameEvent_HideCharacter:
                    return new FrameEvent_HideCharacter(br, type);

                case eActionChart_FrameEvent.eFrameEvent_RevealCharacter:
                    return new FrameEvent_RevealCharacter(br, type);

                case eActionChart_FrameEvent.eFrameEvent_HeadLineMessage:
                    return new FrameEvent_HeadLineMessage(br, type);

                case eActionChart_FrameEvent.eFrameEvent_RepairItem:
                    return new FrameEvent_RepairItem(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Campfire:
                    return new FrameEvent_Campfire(br, type);

                case eActionChart_FrameEvent.eFrameEvent_StartSitDownIk:
                    return new FrameEvent_StartSitDownIk(br, type);

                case eActionChart_FrameEvent.eFrameEvent_EndSitDownIk:
                    return new FrameEvent_EndSitDownIk(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Greet:
                    return new FrameEvent_Greet(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Steal:
                    return new FrameEvent_Steal(br, type);

                case eActionChart_FrameEvent.eFrameEvent_StartCasting:
                    return new FrameEvent_StartCasting(br, type);

                case eActionChart_FrameEvent.eFrameEvent_CancelCasting:
                    return new FrameEvent_CancelCasting(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ReadBook:
                    return new FrameEvent_ReadBook(br, type);

                case eActionChart_FrameEvent.eFrameEvent_CallLuaEvent:
                    return new FrameEvent_CallLuaEvent(br, type);

                case eActionChart_FrameEvent.eFrameEvent_CreateDecal:
                    return new FrameEvent_CreateDecal(br, type);

                case eActionChart_FrameEvent.eFrameEvent_RetryActionMoveReady:
                    return new FrameEvent_RetryActionMoveReady(br, type);

                case eActionChart_FrameEvent.eFrameEvent_RetryActionMove:
                    return new FrameEvent_RetryActionMove(br, type);

                case eActionChart_FrameEvent.eFrameEvent_WeaponType:
                    return new FrameEvent_WeaponType(br, type);

                case eActionChart_FrameEvent.eFrameEvent_FishingFloatIK:
                    return new FrameEvent_FishingFloatIK(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AdditionalDamageType:
                    return new FrameEvent_AdditionalDamageType(br, type);

                case eActionChart_FrameEvent.eFrameEvent_UsePetSkill:
                    return new FrameEvent_UsePetSkill(br, type);

                case eActionChart_FrameEvent.eFrameEvent_FlashBang:
                    return new FrameEvent_FlashBang(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Lighten:
                    return new FrameEvent_Lighten(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Weather:
                    return new FrameEvent_Weather(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Thunder:
                    return new FrameEvent_Thunder(br, type);

                case eActionChart_FrameEvent.eFrameEvent_CharacterParticle:
                    return new FrameEvent_CharacterParticle(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SetBerserk:
                    return new FrameEvent_SetBerserk(br, type);

                case eActionChart_FrameEvent.eFrameEvent_OperateCommonGauge:
                    return new FrameEvent_OperateCommonGauge(br, type);

                case eActionChart_FrameEvent.eFrameEvent_TakeDownCannon:
                    return new FrameEvent_TakeDownCannon(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SummonCharacter:
                    return new FrameEvent_SummonCharacter(br, type);

                case eActionChart_FrameEvent.eFrameEvent_CannonAngle:
                    return new FrameEvent_CannonAngle(br, type);

                case eActionChart_FrameEvent.eFrameEvent_PoseFemale:
                    return new FrameEvent_PoseFemale(br, type);

                case eActionChart_FrameEvent.eFrameEvent_CameraRotate:
                    return new FrameEvent_CameraRotate(br, type);

                case eActionChart_FrameEvent.eFrameEvent_CommandRepair:
                    return new FrameEvent_CommandRepair(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ActiveSkill:
                    return new FrameEvent_ActiveSkill(br, type);

                case eActionChart_FrameEvent.eFrameEvent_BuildingUpgrade:
                    return new FrameEvent_BuildingUpgrade(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AttackBounds:
                    return new FrameEvent_AttackBounds(br, type);

                case eActionChart_FrameEvent.eFrameEvent_PredictCannonAtkPos:
                    return new FrameEvent_PredictCannonAtkPos(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Banquet:
                    return new FrameEvent_Banquet(br, type);

                case eActionChart_FrameEvent.eFrameEvent_GenerateWave:
                    return new FrameEvent_GenerateWave(br, type);

                case eActionChart_FrameEvent.eFrameEvent_WeaponBoneFlag:
                    return new FrameEvent_WeaponBoneFlag(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ActionTimer:
                    return new FrameEvent_ActionTimer(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ModelAnimation:
                    return new FrameEvent_ModelAnimation(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Observer:
                    return new FrameEvent_Observer(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Texture:
                    return new FrameEvent_Texture(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ResetTargetList:
                    return new FrameEvent_ResetTargetList(br, type);

                case eActionChart_FrameEvent.eFrameEvent_SummonCharacters:
                    return new FrameEvent_SummonCharacters(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AttackSkillSimple:
                    return new FrameEvent_AttackSkillSimple(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AttackArrowSkillSimple:
                    return new FrameEvent_AttackArrowSimple(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ResetGuard:
                    return new FrameEvent_ResetGuard(br, type);

                case eActionChart_FrameEvent.eFrameEvent_BaseMeshOff:
                    return new FrameEvent_BaseMeshOff(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ControlApStack:
                    return new FrameEvent_ControlApStack(br, type);

                case eActionChart_FrameEvent.eFrameEvent_Ragdollize:
                    return new FrameEvent_Ragdollize(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ReqGuildTeamBattle:
                    return new FrameEvent_ReqGuildTeamBattle(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AttackForClient:
                    return new FrameEvent_AtackForClient(br, type);

                case eActionChart_FrameEvent.eFrameEvent_AttackBullet:
                    return new FrameEvent_BulletAttack(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ReloadAmmo:
                    return new FrameEvent_ReloadAmmo(br, type);

                case eActionChart_FrameEvent.eFrameEvent_DecreaseAmmo:
                    return new FrameEvent_DecreaseAmmo(br, type);

                case eActionChart_FrameEvent.eFrameEvent_ResetUpper:
                    return new FrameEvent_ResetUpper(br, type);


                default:
                    return null;
            }
        }
    }
}
