# DBS Zadanie 4 - Návrh databázy - _Tibor Galambos, Zsolt Kiss_

___
## Users
#!!! E-mail registrácia Facebook !!!
Tabuľka **Users** predstavuje používateľa v systéme, ktorý môže byť zaregistrovaný pomocou vlastného e-mailu alebo pomocou účtov Facebook alebo Google. [`registered_with`]
- Pri registrácií s vlastným e-mailom sa vyžaduje, aby používateľ zadal svoj meno a priezvisko [`first_and_last_name`]. Pri registrácií s Facebook/Google tieto údaje budú automaticky prevzaté z danej stránky.
- Používateľské meno [`username`] zvolí používateľ počas registrácie.
- Vo všetkých prípadoch je potrebné, aby používateľ vytvoril heslo [`password`] k svojho účtu.  
- Ak registrácia uskutočnila pomocou vlastného e-mailu, vyžaduje sa verifikácia [`verified_with`] e-mailovej adresy. Na druhej strane, ak používateľ na registráciu používal svoj Facebook alebo Google účet, je automaticky verifikovaný.
- Používateľ musí mať aspoň 18 rokov, aby mohol hrať túto hru. Vek je vypočítaný podľa dátumu narodenia [`date_of_birth`].
- Každý používateľ môze mať viac konverzácií (**Converstations**) a v rámci konverzácie viac správ (**Messages**).

## Use case
Používateľ zaregistruje vybraním jednej metódy (t.j. e-mail, facebook, Google) do hry. 
Aplikácia následne vyexportuje jeho priateľov, ktorý sú tiež zaregistrovaný a ponúkne používateľovi možnosť, pridať si ich medzi priateľov aj v samotnej hre.
Hráč, ktorý je priateľom používateľa na sociálnej sieti v hre môže byť medzi zablokovanými ľudmi. 
Tiež platí, ak používateľ chce zobraziť štatistiky iného používateľa, musia byť v hre priateľmi.
Hráč, ktorý sa zaregistroval a nemá 18 rokov, tak sa jeho e-mail a dátum narodenia uloží, a keď dovŕší 18 rokov, príde mu notifikácia na e-mail, že môže už hru hrať, a vytvoriť si postavu.


___
## Friendships
Tabuľka **Friendships** predstavuje vzťah medzi dvoma používateľmi [`id_requester -> Users.id` a `id_addresee -> Users.id`] v hre.
- Každý friendship má stav [`status`] a ten môže byť: `1` - *requested*, `2` - *accepted*, `3` - *declined*, `4` - *blocked*.

## Converstations
Tabuľka **Conversations** predstavuje konverzácie používateľa. **Users** môže mať koľkokoľvek konverzácií.
- Konverzácia má prijímateľa [`receiver_id -> Users.id`] a odosielateľa  [`sender_id -> Users.id`] a každá konverzácia obsahuje 0 až n správ (**Messages**)

## Team_messages
Tabuľka **Team_messages** predstavuje tímovú konverzáciu medzi členmi
- Tímová konverzácia obsahuje `team_id -> Teams.id`, ktorý je spojený so skupinou **Teams** a prijímatelia budú všetci členovia skupiny okrem odosielateľa.

## Messages
Tabuľka **Messages** predstavuje jednu správu v danej konverzácie.
- Správa je súčasťou normálnej konverzácie [`conversation_id -> Converstations.id`]
- Správa obsahuje dátum, kedy bol odoslaný [`sent_at`]

## Use case
Podmienkou komunikácie, teda vytvorenie konverzácie je, aby kontaktovaný používateľ nebol medzi zablokovanými. Napríklad User1 zablokoval Usera2. 
Po nejakom čase sa User1 rozhodul, že kontaktuje Usera2, avšak toto mu nebude umožnené, kým ho neodblokuje. 
Teda blokovanie sa vzťahuje na obe strany, ale odblokovať vie len tá strana, ktorá blokovanie iniciovala.
Každá konverzácia sa vzťahuje k používateľovi, ktorý je buď odosielateľom alebo prijímateľom niektorej správy v rámci konverzácie. 
Každá správa obsahuje text, ktorá je zobrazovaná zo stĺpca [`text`]. Konverzácia sa môže vzťahovať aj k viacerým používateľom, ak ide o tímový chat. 
V tom prípade ak v rámci tímu používateľ pošle správu do takéhoto chatu, prijímatelia budú všetci členovia tímu okrem neho.


___
## Characters
Tabuľka **Characters** predstavuje jednu postavu, ktorej vlastníkom [`owner -> User.id`] je používateľ (**Users**)
- Každý charakter má práve jednu rolu [`role -> Roles.id`].
- Každý charakter má meno [`name`]. 
- Každý charakter má úroveň [`level`]. 
- Každý charakter má skúsenostné body [`exp`].
- Každý charakter má stav online [`is_online`].
- Každý charakter má práve jeden inventár [`inventory_id -> Inventory.id`].
- Každý charakter má počet úspešne dokončených úloh [`quest_count`].

## Character_stats
Tabuľka **Character_stats** predstavuje vlastnosti jednej postavy [`characters_id -> Characters.id`]
- Postava má zdravotné body [`hp`].
- Postava má počet životov [`lives`].
- Postava má útočnú hodnotu [`attack`].
- Postava má obrannú hodnotu [`defense`].
- Postava má určitú rýchlosť [`speed`], ktorou sa pohybuje na mape.
- Postava má x-ovú pozíciu na mapu, kde sa momentálne nachádza [`x_position`].
- Postava má y-ovú pozíciu na mapu, kde sa momentálne nachádza [`y_position`].
- Postava vždy nachádza na niektorej mape [`map_id -> Maps.id`].

## Roles
Tabuľka **Roles** predstavuje rolu jednej postavy (**Characters**)
- Na základe používateľom vybranej roli budú modifikované štatistiky postavy 
- `Character_stats.attack` bude vynásobené s konštantou `attack_cons`
- `Character_stats.defense` bude vynásobené s konštantou `defense_cons`
- `Character_stats.hp` bude vynásobené s konštantou `hp_cons`

## Monsters
Tabuľka **Monsters** predstavuje jednu príšeru, ktorá má niektoré charakteristiky rovnaké ako postava **Characters**
- Príšera môže byť šéf [`is_boss`].
- Každá príšera poskytuje určitý počet skúsenostných bodov [`exp_for_kill`].
- Každá príšera má stav zabitia [`is_killed`].
- Každá príšera patrí do nejakej kategórie [`type ->  Monster_types.id`].

## Monster_stats
Tabuľka **Creature_stats** predstavuje vlastnosti jedného príšera [`monsters_id -> Monsters.id`]
- Príšera má zdravotné body [`hp`].
- Príšera má počet životov [`lives`].
- Príšera má útočnú hodnotu [`attack`].
- Príšera má obrannú hodnotu [`defense`].
- Príšera má určitú rýchlosť [`speed`], ktorou sa pohybuje na mape.
- Príšera má x-ovú pozíciu na mapu, kde sa momentálne nachádza [`x_position`].
- Príšera má y-ovú pozíciu na mapu, kde sa momentálne nachádza [`y_position`].
- Príšera vždy nachádza na niektorej mape [`map_id -> Maps.id`].

## Monster_types
Tabuľka **Roles** predstavuje rolu jednej postavy (**Characters**)
- Na základe používateľom vybranej roli budú modifikované štatistiky postavy 
- `Monster_stats.attack` bude vynásobené s konštantou `attack_cons`
- `Monster_stats.defense` bude vynásobené s konštantou `defense_cons`
- `Monster_stats.hp` bude vynásobené s konštantou `hp_cons`

## Use case
Ak používateľ vytvorí novú postavu, musí si vybrať nejakú rolu (bojovník, čarodejník, lukostrelec), ktorú potom nie je možné zmeniť. 
Nová postava má level 1, jej začiatočné statistiky sú vopred určené podľa roli. Napríklad čarodejník má konštantu na attack 1.2, konštantu na defense 1.5 a konštantu na hp 1.3.
Jeho finálne štatistiky budú `attack = 5 * 1.2 = 6`, `defense = 5 * 1.5 = 7.5` a `hp = 5 * 1.3 = 6.5`. Každá rola má iné konštanty, ale na začiatku konštanty dávajú sumu 4. 

| Rola        | Attack | Defense | HP  |
|-------------|--------|---------|-----|
| Bojovník    | 1.5    | 1.3     | 1.2 |
| Čarodejník  | 1.2    | 1.5     | 1.3 |
| Lukostrelec | 1.3    | 1.2     | 1.5 |

Finálne konštanty závisia aj od vybavenia postavy (zbraň, brnenie, štít).
Za zabitie príšeri postava získava skúsenostné body v závislosti od úrovne hráča a taktiež príšery. Príšera je vždy na rovnakej úrovni, ako postava. 
Obyčajnú príšeru stačí iba raz zabiť, ale šéf môže mať viac životov. 
Každá príšera má unikátny ID, čiže ID ukazuje na konkrétnu príšeru, a nie na typ. Atribút `type` v tabuľke **Monsters** určuje typ príšeri. 
Tabuľke **Monster_types** reprezentuje silu príšery podobne ako tabuľka **Roles** pre postavu.


___
## Skills
Tabuľka **Skills** predstavuje jednu schopnosť, ktorá patrí k danej roli.
- Každá schopnosť má meno [`name`].
- Schopnosti majú stromovú štruktúru, a pri každej schopnosti sa vyžaduje, aby postava už vlastnila schopnosť o stupeň vyššie v strome [`required_skill_id -> Skills.id`].
- Každá schopnosť vyžaduje určitú úroveň postavy [`required_level`].
- Na základe používateľom vybranej roli [`role_id` -> Roles.id] budú priradené schopnosti pre postavy (**Characters**)

## Use case
Ak postava postúpi na novú úroveň, musí vybrať jednu novú schopnosť, teda nemôže mať nevyužité body. 
Schopnosti predstavujú stromovú štruktúru, kde postava sama určí, ktorou cestou sa vyberie v strome. 
To znamená, že ak postava zvolil niektorú vetvu, nemôže sa vrátiť a otvoriť inú.
Na výber budú vždy 3 vetvy. Schopnosť bude nadväzovať na zvolenú rolu postavy (napr.: čarodejník nemôže mať schopnosť bojovníka).


___
## Teams
Tabuľka **Teams** predstavuje skupinu hráčov. Skupiny umožňujú, aby členovia mohli medzi sebou komunikovať pomocou chatu.
- Každý tím má meno  [`name`].
- Každý tím má admina [`admin_id -> Users.id`], ktorý vytvoril skupinu.

## Members
Tabuľka **Members** predstavuje členov tímu (**Teams**)
- Atribút `team_id` definuje ku ktorému tímu patrí daný člen.
- V rámci tímov má každý hráč vlastné identifikačné číslo [`member_id`].

## Use case
Tím vytvára jeden používateľ, ktorý sa zároveň stáva aj vedúcim tímu. Pozvánka do tímu vie poslať druhému používateľovi len vedúci a to pomocou linku. 
Výhodou byť členom tímu je možnosť využívať tímový chat. Ďalšou zaujímavou funkciu tímu je možnosť zúčastniť sa tímovej bitky.


___
## Quests
Tabuľka **Quests** predstavuje jednu úlohu v hre.
- Každá úloha má určitý požadovaný level, aby k nej bolo možné prístúpiť [`required_level`].
- Každá úloha má typ, ktorý nám hovorí o tom, či je potrebné danú úlohu dokončiť, aby príbeh sa posunul vpred [`required_to_complete`].
- Za dokončenie každej úlohy postava získa určité množstvo skúsenostných bodov [`exp_for_completing`].
- Každá úloha má úroveň obtiažnosti [`difficulty`].
- Každá úloha sa odohráva na určitej mape [`on_map -> Maps.id`].
- Každá úloha má nejaký popis s inštrukciami a požiadavkami, ktoré postava musí dokončiť a splniť. [`text`].

## Maps
Tabuľka **Maps** charakterizuje hracie pole v hre
- Atribút [`name`] predstavuje názov danej mapy.
- Každá mapa vyžaduje minimálnu úroveň [`required_level`] pred vstupom na ňu.
- Mapa má šírku [`width`] aj výšku [`height`]. Tieto atribúty definujú jej veľkosť a priestor, v ktorom sa môže postava pohybovať.

## Use case
Hra obsahuje určitý počet úloh, avšak niektoré nie sú povinné. Každá úloha sa vzťahuje na mapu, kde sa odohráva. 
Na prejdenie hry sa vyžaduje ukončenie vopred daných úloh, ktoré sú povinné. Na mape môžu byť umiestnené príšery, postavy a koristi. 
Na mapu môže vstúpiť postava len vtedy, ak dosiahol určitú úroveň.


___
## Battle_logs
Tabuľka **Battle_logs** predstavuje udalosti, ktoré sa udiali počas bitky. Obsahuje všetky potrebné informácie o bitke.
- Atribút `attacker_character_id -> Characters.id` hovorí o tom, ktorá postava bola útočníkom v bitke.
- Atribút `attacker_monster_id -> Monsters.id` hovorí o tom, ktorá príšera bola útočníkom v bitke.
- Atribút `target_character_id -> Characters.id` hovorí o tom, ktorá postava bola terčom útoku.
- Atribút `target_monster_id -> Monsters.id` hovorí o tom, ktorá príšera bola terčom útoku.
- Atribúty `team1_id -> Teams.id` a `team2_id -> Teams.id` hovoria o tom, ktoré tímy majú medzi sebou bitku. Ak neide o tímovú bitku, tak tie hodnoty majú hodnotu `null`.
- Atribút `damage_to_character` hovorí o spôsobenej škode na zdraví [`Character_stats.hp`] postavy.
- Atribút `damage_to_monster` hovorí o spôsobenej škode na zdraví [`Monster_stats.hp`] príšery.
- Atribút `hit_by -> Gears.id` hovorí o zbrani s ktorou bola spôsobená škoda.
- Atribút `used_skill -> Skills.id` hovorí a použitej schopnosti v bitke (v prípade, ak nebola použitá žiadna schopnosť, tak má hodnotu `null`)
- Atribút `exp_difference -> Characters.exp` je hodnota, ktorá sa buď pripočíta alebo odpočíta z ceľkovej hodnoty skúsenostných bodov.

## Use case
Scenár: Postava [`attacker_character_id`] sa stretne s príšerou [`target_monster_id`] a zaútočí na ňu. Vyhodnotí sa, že ide o PVE battle. 
Postava použije schopnosť [`used_skill`] rotating sword, ktorá spôsobí 50 damage [`damage_to_monster`] na príšera. 
Príšera stratila veľkú časť svojho hp [`Monster_stats.hp`], ale udrie postavu s mečou [`hit_by`] a spôsobí 30 damage na postavu [`damage_to_character`]. 
Postava so svojou mečou následne spôsobí kritickú škodu príšere (70 damage). 
Keďže príšera mal celkom 100 zdravotných bodov a len jeden život, jej zdravotné body sa stanú záporným, teda sa zmení počet životov na 0 a stane sa mŕtvim. 
Víťazom sa stane postava, ktorá získa 100 skúsenostných bodov.


___
## Inventories
Tabuľka **Inventories** predstavuje kapsu s predmetmi, ktorú postava vlastní.
- Atribút `equipped_gears_id` hovorí o vybavených predmetoch, ktoré postava používa.
- Kapacita [`capacity`] určuje koľko predmetov môže byť v kapse.
- Kapsa, ktorá je plná, spomalí hráča (**Character_stats**)

## Equipped_gears
Tabuľka **Equipped_gears** predstavuje tri predmety, ktoré sa nachádzaju v kapse postavy a zaroveň je nimi postava vyzbrojená.
- Zbraň [`weapon`] má vlastné identifikačné číslo, ktoré ukazuje na tabuľku Gear, kde je uvedená jej sila.
- Brnenie [`armour`] má vlastné identifikačné číslo, ktoré ukazuje na tabuľku Gear, kde je uvedená jeho sila.
- Štít [`shield`] má vlastné identifikačné číslo, ktoré ukazuje na tabuľku Gear, kde je uvedená jeho sila.

## Gears
Tabuľka **Gear** definuje silu daného predmetu
- Atribút `name` predstavuje názov predmetu.
- Atribút `attack_cons` hovorí o tom, akou konštantou sa prenasobí ceľková hodnota útočného čisla `Characters_stats.attack`.
- Atribút `defense_cons` hovorí o tom, akou konštantou sa prenasobí ceľková hodnota obranného čisla `Characters_stats.defense`.
- Atribút `hp_cons` hovorí o tom, akou konštantou sa prenasobí ceľková hodnota zdravia `Characters_stats.health`.
- Atribút `weight` hovorí a váhe daného predmetu.
- Atribút `inventory_id` hovorí o tom, kto vlastní daný predmet. Ak predmet je korisť, tak `inventory_id` má hodnotu `null`.

## Use case
Každá postava má kapsu, ktorá má určitú veľkosť. To znamená, že kapsa unesie len určitú váhu. Tým pádom každý predmet má svoju vlastnú váhu. 
Ak sa kapsa naplní, nie je možné pridať do nej ďalší predmet a hráč je spomalený, kým z nej neodstráni niektorý predmet.


___
## Loots
Tabuľka **Loots** definuje konkrétnu korisť a opisuje kde na mape sa nachádza.
- Atribút `x_position` udáva x-ovú pozíciu mapy, kde sa korisť nachádza.
- Atribút `y_position` udáva y-ovú pozíciu mapy, kde sa korisť nachádza.
- Atribút `gear_id -> Gears.id` hovorí o tom o aký predmet ide a v tabuľke **Gears** sú definované jeho vlastnosti.
- Atribút `map_id -> Maps.id` hovorí o tom, na ktorej mape je možné nájsť danú korisť.

## Use case
Ku každej mape patria koristi. Koristí sa nachádzajú na určitej súradnici na danej mape. Ak postava zdvihne korisť, tak zmizne z mapy a uloží sa do kapsy.
Po určitej dobe sa na mape objavujú nové koristi. 