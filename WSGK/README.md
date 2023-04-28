Примеры использования
```
"outcomes"
{
    //Аргументы (через | без пробелов):
    //1)Индекс скина/перчаток/ножа [для стикеров не важно значение]
    //2)Индекс оружия/группы перчаток [8000 - нож, 7000 стикеры.]
    //3)Тип считывания ID оружия
    "wsgk"       "wsgk_item;sint|int|bool"

    Если тип считывания ID оружия установлен на 0, то индекс оружия смотрите по первой цифре, если 1, то смотрите по второй цифре.
    Если вы работаете с перчатками, то у них указывается оригинальный id и Тип считывания ID оружия - bool будет работать, как выбор команды перчаток 0 - T, 1 - CT

    weapon_awp                   0   9
    weapon_ak47                  1   7
    weapon_m4a1                  2   16
    weapon_m4a1_silencer         3   60
    weapon_deagle                4   1
    weapon_usp_silencer          5   61
    weapon_hkp2000               6   32
    weapon_glock                 7   4
    weapon_elite                 8   2
    weapon_p250                  9   36
    weapon_cz75a                 10  63
    weapon_fiveseven             11  3
    weapon_tec9                  12  30
    weapon_revolver              13  64
    weapon_nova                  14  35
    weapon_xm1014                15  25
    weapon_mag7                  16  27
    weapon_sawedoff              17  29
    weapon_m249                  18  14
    weapon_negev                 19  28
    weapon_mp9                   20  34
    weapon_mac10                 21  17
    weapon_mp7                   22  33
    weapon_ump45                 23  24
    weapon_p90                   24  19
    weapon_bizon                 25  26
    weapon_famas                 26  10
    weapon_galilar               27  13
    weapon_ssg08                 28  40
    weapon_aug                   29  8
    weapon_sg556                 30  39
    weapon_scar20                31  38
    weapon_g3sg1                 32  11
    weapon_knife_karambit        33  507
    weapon_knife_m9_bayonet      34  508
    weapon_bayonet               35  500
    weapon_knife_survival_bowie  36  514
    weapon_knife_butterfly       37  515
    weapon_knife_flip            38  505
    weapon_knife_push            39  516
    weapon_knife_tactical        40  509
    weapon_knife_falchion        41  512
    weapon_knife_gut             42  506
    weapon_knife_ursus           43  519
    weapon_knife_gypsy_jackknife 44  520
    weapon_knife_stiletto        45  522
    weapon_knife_widowmaker      46  523
    weapon_mp5sd                 47  23
    weapon_knife_css             48  503
    weapon_knife_cord            49  517
    weapon_knife_canis           50  518
    weapon_knife_outdoor         51  521
    weapon_knife_skeleton        52  525
}
```
