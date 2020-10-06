#include <inc.h>
std::unordered_map<int, std::string> core::table;
void core::init_string_table()
{
	auto add = [&](int id, std::string i)
	{
		auto r = i;
		core::table[id] = r;
	};

	auto str13_32196_starting_init25 = new s_str_container(std::vector<int>{122, 125, 104, 123, 125, 96, 103, 110, 41, 96, 103, 96, 125}); /*starting init*/
	auto str16_60556_mh_failed_launch28 = new s_str_container(std::vector<int>{100, 97, 41, 111, 104, 96, 101, 108, 109, 41, 101, 104, 124, 103, 106, 97}); /*mh failed launch*/
	auto str15_32196_failed_hooking_27 = new s_str_container(std::vector<int>{111, 104, 96, 101, 108, 109, 41, 97, 102, 102, 98, 96, 103, 110, 40}); /*failed hooking!*/
	auto str13_60556_28802_cfg_txt25 = new s_str_container(std::vector<int>{59, 49, 49, 57, 59, 39, 106, 111, 110, 39, 125, 113, 125}); /*28802.cfg.txt*/
	auto str3_32196_eee14 = new s_str_container(std::vector<int>{108, 108, 108}); /*eee*/
	auto str6_32248_packet17 = new s_str_container(std::vector<int>{121, 104, 106, 98, 108, 125}); /*packet*/
	auto str13_54454_ibypass_trial25 = new s_str_container(std::vector<int>{96, 107, 112, 121, 104, 122, 122, 86, 125, 123, 96, 104, 101}); /*ibypass_trial*/
	auto str14_32248_iteleport_gen226 = new s_str_container(std::vector<int>{96, 125, 108, 101, 108, 121, 102, 123, 125, 86, 110, 108, 103, 59}); /*iteleport_gen2*/
	auto str4_54454_loot15 = new s_str_container(std::vector<int>{101, 102, 102, 125}); /*loot*/
	auto str7_32248_ienable18 = new s_str_container(std::vector<int>{96, 108, 103, 104, 107, 101, 108}); /*ienable*/
	auto str8_54454_keybinds19 = new s_str_container(std::vector<int>{98, 108, 112, 107, 96, 103, 109, 122}); /*keybinds*/
	auto str7_32248_itp_key18 = new s_str_container(std::vector<int>{96, 125, 121, 86, 98, 108, 112}); /*itp_key*/
	auto str9_54454_ilock_key20 = new s_str_container(std::vector<int>{96, 101, 102, 106, 98, 86, 98, 108, 112}); /*ilock_key*/
	auto str4_32248_Over15 = new s_str_container(std::vector<int>{70, 127, 108, 123}); /*Over*/
	auto str7_54454_MouseOn18 = new s_str_container(std::vector<int>{68, 102, 124, 122, 108, 70, 103}); /*MouseOn*/
	auto str7_32248_Tooltip18 = new s_str_container(std::vector<int>{93, 102, 102, 101, 125, 96, 121}); /*Tooltip*/
	auto str7_54454_ToolTip18 = new s_str_container(std::vector<int>{93, 102, 102, 101, 93, 96, 121}); /*ToolTip*/
	auto str3_32248_ANI14 = new s_str_container(std::vector<int>{72, 71, 64}); /*ANI*/
	auto str3_54454_Ani14 = new s_str_container(std::vector<int>{72, 103, 96}); /*Ani*/
	auto str6_32248_Update17 = new s_str_container(std::vector<int>{92, 121, 109, 104, 125, 108}); /*Update*/
	auto str5_54454_Frame16 = new s_str_container(std::vector<int>{79, 123, 104, 100, 108}); /*Frame*/
	auto str4_32248_Help15 = new s_str_container(std::vector<int>{65, 108, 101, 121}); /*Help*/
	auto str6_54454_Pushed17 = new s_str_container(std::vector<int>{89, 124, 122, 97, 108, 109}); /*Pushed*/
	auto str4_32248_Chat15 = new s_str_container(std::vector<int>{74, 97, 104, 125}); /*Chat*/
	auto str5_54454_quest16 = new s_str_container(std::vector<int>{120, 124, 108, 122, 125}); /*quest*/
	auto str5_32248_Quest16 = new s_str_container(std::vector<int>{88, 124, 108, 122, 125}); /*Quest*/
	auto str10_54454_MenuRemake22 = new s_str_container(std::vector<int>{68, 108, 103, 124, 91, 108, 100, 104, 98, 108}); /*MenuRemake*/
	auto str4_32248_Icon15 = new s_str_container(std::vector<int>{64, 106, 102, 103}); /*Icon*/
	auto str9_54454_QuickSlot20 = new s_str_container(std::vector<int>{88, 124, 96, 106, 98, 90, 101, 102, 125}); /*QuickSlot*/
	auto str4_32248_Hide15 = new s_str_container(std::vector<int>{65, 96, 109, 108}); /*Hide*/
	auto str7_54454_collect18 = new s_str_container(std::vector<int>{106, 102, 101, 101, 108, 106, 125}); /*collect*/
	//
	add(0, str13_32196_starting_init25->get());
	add(1, str16_60556_mh_failed_launch28->get());
	add(2, str15_32196_failed_hooking_27->get());
	add(3, str13_60556_28802_cfg_txt25->get());
	add(4, str3_32196_eee14->get());
	add(5, str6_32248_packet17->get());
	add(6, str13_54454_ibypass_trial25->get());
	add(7, str14_32248_iteleport_gen226->get());
	add(8, str4_54454_loot15->get());
	add(9, str7_32248_ienable18->get());
	add(10, str8_54454_keybinds19->get());
	add(11, str7_32248_itp_key18->get());
	add(12, str9_54454_ilock_key20->get());
	add(13, str4_32248_Over15->get());
	add(14, str7_54454_MouseOn18->get());
	add(15, str7_32248_Tooltip18->get());
	add(16, str7_54454_ToolTip18->get());
	add(17, str3_32248_ANI14->get());
	add(18, str3_54454_Ani14->get());
	add(19, str6_32248_Update17->get());
	add(20, str5_54454_Frame16->get());
	add(21, str4_32248_Help15->get());
	add(22, str6_54454_Pushed17->get());
	add(23, str4_32248_Chat15->get());
	add(24, str5_54454_quest16->get());
	add(25, str5_32248_Quest16->get());
	add(26, str10_54454_MenuRemake22->get());
	add(27, str4_32248_Icon15->get());
	add(28, str9_54454_QuickSlot20->get());
	add(29, str4_32248_Hide15->get());
	add(30, str7_54454_collect18->get());
	//
	delete str13_32196_starting_init25;
	delete str16_60556_mh_failed_launch28;
	delete str15_32196_failed_hooking_27;
	delete str13_60556_28802_cfg_txt25;
	delete str3_32196_eee14;
	delete str6_32248_packet17;
	delete str13_54454_ibypass_trial25;
	delete str14_32248_iteleport_gen226;
	delete str4_54454_loot15;
	delete str7_32248_ienable18;
	delete str8_54454_keybinds19;
	delete str7_32248_itp_key18;
	delete str9_54454_ilock_key20;
	delete str4_32248_Over15;
	delete str7_54454_MouseOn18;
	delete str7_32248_Tooltip18;
	delete str7_54454_ToolTip18;
	delete str3_32248_ANI14;
	delete str3_54454_Ani14;
	delete str6_32248_Update17;
	delete str5_54454_Frame16;
	delete str4_32248_Help15;
	delete str6_54454_Pushed17;
	delete str4_32248_Chat15;
	delete str5_54454_quest16;
	delete str5_32248_Quest16;
	delete str10_54454_MenuRemake22;
	delete str4_32248_Icon15;
	delete str9_54454_QuickSlot20;
	delete str4_32248_Hide15;
	delete str7_54454_collect18;

}
std::string core::gstr(int i)
{
	if (core::table[i].empty()) return "";
	return core::table[i];
}
