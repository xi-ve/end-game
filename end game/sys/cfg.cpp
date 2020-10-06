#include <inc.h>
bool sys::c_config::proc(std::string a, std::string b, std::string c, bool local)
{
	if (a.empty() || b.empty()) return false;
	if (this->gvar(a, b)) return false;
	auto t = new sys::s_cfg_v(a, b, c);
	t->local = local;
	this->cfg_list.push_back(t);
	return true;
}
bool sys::c_config::proc(int a, int b, std::string c, bool local)
{
	if (!a || !b) return false;
	auto s1 = core::gstr(a);
	auto s2 = core::gstr(b);
	if (this->gvar(s1, s2)) return false;
	auto t = new sys::s_cfg_v(s1, s2, c);
	t->local = local;
	this->cfg_list.push_back(t);
	return true;
}
sys::s_cfg_v* sys::c_config::gvar(std::string t, std::string v)
{
	for (auto a : this->cfg_list) if (strstr(a->table.c_str(), t.c_str()) && strstr(a->val.c_str(), v.c_str())) return a;
	return nullptr;
}

void sys::c_config::read()
{
	std::ifstream t(core::gstr(3));
	if (!t.is_open()) return;
	std::string s;
	while (std::getline(t, s))
	{
		if (s.empty()) continue;
		auto f = s.find(":");
		auto cpy = s;
		if (f == std::string::npos) continue;
		cpy.erase(f, cpy.size());
		auto first_var = cpy;
		s.erase(0, f + 1);
		cpy = s;
		f = cpy.find(":");
		cpy.erase(f, cpy.size());
		auto second_var = cpy;
		s.erase(0, f + 1);
		cpy = s;
		if (!this->proc(first_var, second_var, s))
		{
			auto x = this->gvar(first_var, second_var);
			if (x->t == 1) x->iv = std::stoi(s);
			if (x->t == 2) x->fv = std::stof(s);
			if (x->t == 0) x->val = s;
			continue;
		}
	}
	t.close();
}
void sys::c_config::save()
{
	std::ofstream t(core::gstr(3));
	if (!t.is_open()) return;
	for (auto&& a : this->cfg_list)
	{
		if (a->local) continue;
		switch (a->t)
		{
		case 0:
		{
			t << a->table << ":" << a->val << ":" << a->rval << "\n";
			break;
		}
		case 1:
		{
			t << a->table << ":" << a->val << ":" << a->iv << "\n";
			break;
		}
		case 2:
		{
			t << a->table << ":" << a->val << ":" << a->fv << "\n";
			break;
		}
		default: break;
		}
	}
	t.close();
}
void sys::c_config::vars()
{
	ClearStart();
	using namespace core;
	auto str4_9636_loot14 = new s_str_container(std::vector<int>{101, 102, 102, 125}); /*loot*/
	auto str7_22122_ienable18 = new s_str_container(std::vector<int>{96, 108, 103, 104, 107, 101, 108}); /*ienable*/
	auto str6_9636_packet16 = new s_str_container(std::vector<int>{121, 104, 106, 98, 108, 125}); /*packet*/
	auto str13_22122_ibypass_trial25 = new s_str_container(std::vector<int>{96, 107, 112, 121, 104, 122, 122, 86, 125, 123, 96, 104, 101}); /*ibypass_trial*/
	auto str14_22122_iteleport_gen226 = new s_str_container(std::vector<int>{96, 125, 108, 101, 108, 121, 102, 123, 125, 86, 110, 108, 103, 59}); /*iteleport_gen2*/
	auto str5_9636_debug15 = new s_str_container(std::vector<int>{109, 108, 107, 124, 110}); /*debug*/
	auto str14_22122_ientity_update26 = new s_str_container(std::vector<int>{96, 108, 103, 125, 96, 125, 112, 86, 124, 121, 109, 104, 125, 108}); /*ientity_update*/
	auto str11_22122_ientity_alt23 = new s_str_container(std::vector<int>{96, 108, 103, 125, 96, 125, 112, 86, 104, 101, 125}); /*ientity_alt*/
	auto str9_9636_auto_loot19 = new s_str_container(std::vector<int>{104, 124, 125, 102, 86, 101, 102, 102, 125}); /*auto_loot*/
	auto str23_22122_string_whitelist_config35 = new s_str_container(std::vector<int>{122, 125, 123, 96, 103, 110, 86, 126, 97, 96, 125, 108, 101, 96, 122, 125, 86, 106, 102, 103, 111, 96, 110}); /*string_whitelist_config*/
	auto str23_22122_string_blacklist_config35 = new s_str_container(std::vector<int>{122, 125, 123, 96, 103, 110, 86, 107, 101, 104, 106, 98, 101, 96, 122, 125, 86, 106, 102, 103, 111, 96, 110}); /*string_blacklist_config*/
	auto str10_22122_ipick_grey22 = new s_str_container(std::vector<int>{96, 121, 96, 106, 98, 86, 110, 123, 108, 112}); /*ipick_grey*/
	auto str11_22122_ipick_green23 = new s_str_container(std::vector<int>{96, 121, 96, 106, 98, 86, 110, 123, 108, 108, 103}); /*ipick_green*/
	auto str10_22122_ipick_blue22 = new s_str_container(std::vector<int>{96, 121, 96, 106, 98, 86, 107, 101, 124, 108}); /*ipick_blue*/
	auto str12_22122_ipick_orange24 = new s_str_container(std::vector<int>{96, 121, 96, 106, 98, 86, 102, 123, 104, 103, 110, 108}); /*ipick_orange*/
	auto str12_22122_ipick_yellow24 = new s_str_container(std::vector<int>{96, 121, 96, 106, 98, 86, 112, 108, 101, 101, 102, 126}); /*ipick_yellow*/
	auto str14_22122_ienable_filter26 = new s_str_container(std::vector<int>{96, 108, 103, 104, 107, 101, 108, 86, 111, 96, 101, 125, 108, 123}); /*ienable_filter*/
	auto str7_9636_visuals17 = new s_str_container(std::vector<int>{127, 96, 122, 124, 104, 101, 122}); /*visuals*/
	auto str18_22122_ienable_store_path30 = new s_str_container(std::vector<int>{96, 108, 103, 104, 107, 101, 108, 86, 122, 125, 102, 123, 108, 86, 121, 104, 125, 97}); /*ienable_store_path*/
	auto str17_22122_ienable_roar_path29 = new s_str_container(std::vector<int>{96, 108, 103, 104, 107, 101, 108, 86, 123, 102, 104, 123, 86, 121, 104, 125, 97}); /*ienable_roar_path*/
	auto str24_22122_ienable_roar_path_pause35 = new s_str_container(std::vector<int>{96, 108, 103, 104, 107, 101, 108, 86, 123, 102, 104, 123, 86, 121, 104, 125, 97, 86, 121, 104, 124, 122, 108, 122}); /*ienable_roar_path_pauses*/
	auto str14_22122_ienable_portal26 = new s_str_container(std::vector<int>{96, 108, 103, 104, 107, 101, 108, 86, 121, 102, 123, 125, 104, 101}); /*ienable_portal*/
	auto str13_22122_ienable_debug25 = new s_str_container(std::vector<int>{96, 108, 103, 104, 107, 101, 108, 86, 109, 108, 107, 124, 110}); /*ienable_debug*/
	auto str13_22122_ialive_byname25 = new s_str_container(std::vector<int>{96, 104, 101, 96, 127, 108, 86, 107, 112, 103, 104, 100, 108}); /*ialive_byname*/
	auto str8_9636_roar_bot18 = new s_str_container(std::vector<int>{123, 102, 104, 123, 86, 107, 102, 125}); /*roar_bot*/
	auto str14_22122_ibot_timescale26 = new s_str_container(std::vector<int>{96, 107, 102, 125, 86, 125, 96, 100, 108, 122, 106, 104, 101, 108}); /*ibot_timescale*/
	auto str14_22122_ibot_lootrange26 = new s_str_container(std::vector<int>{96, 107, 102, 125, 86, 101, 102, 102, 125, 123, 104, 103, 110, 108}); /*ibot_lootrange*/
	auto str8_22122_iloot_tp19 = new s_str_container(std::vector<int>{96, 101, 102, 102, 125, 86, 125, 121}); /*iloot_tp*/
	auto str17_22122_ibot_storage_roar29 = new s_str_container(std::vector<int>{96, 107, 102, 125, 86, 122, 125, 102, 123, 104, 110, 108, 86, 123, 102, 104, 123}); /*ibot_storage_roar*/
	auto str14_9689_ivis_linestart25 = new s_str_container(std::vector<int>{96, 127, 96, 122, 86, 101, 96, 103, 108, 122, 125, 104, 123, 125}); /*ivis_linestart*/
	auto str8_16025_roar_bot19 = new s_str_container(std::vector<int>{123, 102, 104, 123, 86, 107, 102, 125}); /*roar_bot*/
	auto str16_9689_string_last_path27 = new s_str_container(std::vector<int>{122, 125, 123, 96, 103, 110, 86, 101, 104, 122, 125, 86, 121, 104, 125, 97}); /*string_last_path*/
	auto str8_16025_rebuffer19 = new s_str_container(std::vector<int>{123, 108, 107, 124, 111, 111, 108, 123}); /*rebuffer*/
	auto str7_9689_ienable17 = new s_str_container(std::vector<int>{96, 108, 103, 104, 107, 101, 108}); /*ienable*/
	auto str12_9689_string_buffs23 = new s_str_container(std::vector<int>{122, 125, 123, 96, 103, 110, 86, 107, 124, 111, 111, 122}); /*string_buffs*/
	auto str8_16025_keybinds19 = new s_str_container(std::vector<int>{98, 108, 112, 107, 96, 103, 109, 122}); /*keybinds*/
	auto str7_9689_itp_key17 = new s_str_container(std::vector<int>{96, 125, 121, 86, 98, 108, 112}); /*itp_key*/
	auto str9_9689_ilock_key19 = new s_str_container(std::vector<int>{96, 101, 102, 106, 98, 86, 98, 108, 112}); /*ilock_key*/
	auto str7_16025_overlay18 = new s_str_container(std::vector<int>{102, 127, 108, 123, 101, 104, 112}); /*overlay*/
	auto str16_9689_ioverlay_toggled27 = new s_str_container(std::vector<int>{96, 102, 127, 108, 123, 101, 104, 112, 86, 125, 102, 110, 110, 101, 108, 109}); /*ioverlay_toggled*/


	auto str1_5123_111 = new s_str_container(std::vector<int>{56}); /*1*/
	auto str1_31513_012 = new s_str_container(std::vector<int>{57}); /*0*/
	auto str1_5123_011 = new s_str_container(std::vector<int>{57}); /*0*/
	auto str1_31513_112 = new s_str_container(std::vector<int>{56}); /*1*/
	auto str0_31513_11 = new s_str_container(std::vector<int>{}); /**/
	auto str0_5123_10 = new s_str_container(std::vector<int>{}); /**/
	auto str3_5123_35013 = new s_str_container(std::vector<int>{58, 60, 57}); /*350*/
	auto str3_31513_40014 = new s_str_container(std::vector<int>{61, 57, 57}); /*400*/
	auto str6_31513_def_2817 = new s_str_container(std::vector<int>{109, 108, 111, 39, 59, 49}); /*def.28*/
	auto str2_5123_9612 = new s_str_container(std::vector<int>{48, 63}); /*96*/
	auto str3_31513_11614 = new s_str_container(std::vector<int>{56, 56, 63}); /*116*/


	this->proc(str4_9636_loot14->get(), str7_22122_ienable18->get(), str1_5123_111->get());
	this->proc(str6_9636_packet16->get(), str13_22122_ibypass_trial25->get(), str1_31513_012->get());
	this->proc(str6_9636_packet16->get(), str14_22122_iteleport_gen226->get(), str1_31513_012->get());
	this->proc(str5_9636_debug15->get(), str14_22122_ientity_update26->get(), str1_5123_111->get());
	this->proc(str5_9636_debug15->get(), str11_22122_ientity_alt23->get(), str1_31513_012->get());
	this->proc(str9_9636_auto_loot19->get(), str23_22122_string_whitelist_config35->get(), str0_31513_11->get());
	this->proc(str9_9636_auto_loot19->get(), str23_22122_string_blacklist_config35->get(), str0_31513_11->get());
	this->proc(str9_9636_auto_loot19->get(), str10_22122_ipick_grey22->get(), str1_5123_111->get());
	this->proc(str9_9636_auto_loot19->get(), str11_22122_ipick_green23->get(), str1_5123_111->get());
	this->proc(str9_9636_auto_loot19->get(), str10_22122_ipick_blue22->get(), str1_5123_111->get());
	this->proc(str9_9636_auto_loot19->get(), str12_22122_ipick_orange24->get(), str1_5123_111->get());
	this->proc(str9_9636_auto_loot19->get(), str12_22122_ipick_yellow24->get(), str1_5123_111->get());
	this->proc(str9_9636_auto_loot19->get(), str7_22122_ienable18->get(), str1_5123_111->get());
	this->proc(str9_9636_auto_loot19->get(), str14_22122_ienable_filter26->get(), str1_5123_111->get());
	this->proc(str7_9636_visuals17->get(), str18_22122_ienable_store_path30->get(), str1_5123_111->get());
	this->proc(str7_9636_visuals17->get(), str17_22122_ienable_roar_path29->get(), str1_5123_111->get());
	this->proc(str7_9636_visuals17->get(), str24_22122_ienable_roar_path_pause35->get(), str1_31513_012->get());
	this->proc(str7_9636_visuals17->get(), str14_22122_ienable_portal26->get(), str1_5123_111->get());
	this->proc(str7_9636_visuals17->get(), str13_22122_ienable_debug25->get(), str1_31513_012->get());
	this->proc(str7_9636_visuals17->get(), str13_22122_ialive_byname25->get(), str1_31513_012->get());
	this->proc(str8_9636_roar_bot18->get(), str14_22122_ibot_timescale26->get(), str3_5123_35013->get());
	this->proc(str8_9636_roar_bot18->get(), str14_22122_ibot_lootrange26->get(), str3_31513_40014->get());
	this->proc(str8_9636_roar_bot18->get(), str8_22122_iloot_tp19->get(), str1_5123_111->get());
	this->proc(str8_9636_roar_bot18->get(), str17_22122_ibot_storage_roar29->get(), str1_5123_111->get());
	this->proc(str8_9636_roar_bot18->get(), str14_9689_ivis_linestart25->get(), str1_5123_111->get());
	this->proc(str8_9636_roar_bot18->get(), str16_9689_string_last_path27->get(), str6_31513_def_2817->get());
	this->proc(str8_16025_rebuffer19->get(), str7_22122_ienable18->get(), str1_31513_012->get());
	this->proc(str8_16025_rebuffer19->get(), str12_9689_string_buffs23->get(), str0_31513_11->get());
	this->proc(str8_16025_keybinds19->get(), str7_9689_itp_key17->get(), str2_5123_9612->get());
	this->proc(str8_16025_keybinds19->get(), str9_9689_ilock_key19->get(), str3_31513_11614->get());
	this->proc(str7_16025_overlay18->get(), str16_9689_ioverlay_toggled27->get(), str1_5123_111->get());

	delete str1_5123_111;
	delete str1_31513_012;
	delete str1_5123_011;
	delete str1_31513_112;
	delete str0_31513_11;
	delete str0_5123_10;
	delete str3_5123_35013;
	delete str3_31513_40014;
	delete str6_31513_def_2817;
	delete str2_5123_9612;
	delete str3_31513_11614;

	delete str4_9636_loot14;
	delete str7_22122_ienable18;
	delete str6_9636_packet16;
	delete str13_22122_ibypass_trial25;
	delete str14_22122_iteleport_gen226;
	delete str5_9636_debug15;
	delete str14_22122_ientity_update26;
	delete str11_22122_ientity_alt23;
	delete str9_9636_auto_loot19;
	delete str23_22122_string_whitelist_config35;
	delete str23_22122_string_blacklist_config35;
	delete str10_22122_ipick_grey22;
	delete str11_22122_ipick_green23;
	delete str10_22122_ipick_blue22;
	delete str12_22122_ipick_orange24;
	delete str12_22122_ipick_yellow24;
	delete str14_22122_ienable_filter26;
	delete str7_9636_visuals17;
	delete str18_22122_ienable_store_path30;
	delete str17_22122_ienable_roar_path29;
	delete str24_22122_ienable_roar_path_pause35;
	delete str14_22122_ienable_portal26;
	delete str13_22122_ienable_debug25;
	delete str13_22122_ialive_byname25;
	delete str8_9636_roar_bot18;
	delete str14_22122_ibot_timescale26;
	delete str14_22122_ibot_lootrange26;
	delete str8_22122_iloot_tp19;
	delete str17_22122_ibot_storage_roar29;
	delete str14_9689_ivis_linestart25;
	delete str8_16025_roar_bot19;
	delete str16_9689_string_last_path27;
	delete str8_16025_rebuffer19;
	delete str7_9689_ienable17;
	delete str12_9689_string_buffs23;
	delete str8_16025_keybinds19;
	delete str7_9689_itp_key17;
	delete str9_9689_ilock_key19;
	delete str7_16025_overlay18;
	delete str16_9689_ioverlay_toggled27;

	ClearEnd();
}
sys::c_config* sys::config;