"# zadanie4-str10-findura-z4_galambos_kiss" 

### Users

Tabuľka **Users** predstavuje používateľa v systéme, ktorý môže byť zaregistrovaný pomocou vlastného e-mailu alebo pomocou účtov Facebook alebo Google. [`registered_with`]

- Pri registrácií s vlastným e-mailom sa vyžaduje, aby používateľ zadal svoj meno a priezvisko [`first_and_last_name`]. Pri registrácií s Facebook/Google tieto údaje budú automaticky prevzaté z danej stránky.
- Používateľské meno [`username`] zvolí používateľ počas registrácie.
- Vo všetkých prípadoch je potrebné, aby používateľ vytvoril heslo [`password`] k svojho účtu.  
- Ak registrácia uskutočnila pomocou vlastného e-mailu, vyžaduje sa verifikácia [`verified_with`] e-mailovej adresy. Na druhej strane, ak používateľ na registráciu používal svoj Facebook alebo Google účet, je automaticky verifikovaný.
- Používateľ musí mať aspoň 18 rokov, aby mohol registrovať a teda hrať túto hru. Vek je vypočítaný podľa dátumu narodenia [`date_of_birth`].
- Každý používateľ môze mať viac konverzácií (**Converstations**) a v rámci konverzácie viac správ (**Message**).

### Converstations

Tabuľka **Conversation** predstavuje konverzácie používateľa. **Users** môže mať koľkokoľvek konverzácií.
- Konverzácia má prijímateľa [`receiver_id -> Users.id`] a odosielateľa  [`sender_id -> Users.id`] a každá konverzácia obsahuje 0 až n správ (**Message**)

### Team_converstations

Tabuľka **Team_converstations** predstavuje tímovú konverzáciu medzi členmi

- Tímová konverzácia obsahuje `team_id -> Teams.id`, ktorý je spojený so skupinou **Teams** a prijímatelia budú všetci členovia skupiny okrem odosielateľa ktorý je definovaný v tabuľke **Message**

### Message

Tabuľka **Message** predstavuje jednu správu v danej konverzácie.

- Správa môže byť súčasťou aj normálnej aj tímovej konverzácie [`conversation_id -> Converstations.id` alebo `conversation_id -> Team_converstations.id`]
- Správa obsahuje dátum, kedy bol odoslaný [`sent_at`]

### Characters

Tabuľka **Characters** predstavuje jednu postavu, ktorej vlastníkom [`owner -> User.id`] je používateľ (**Users**)

- Každý charakter má práve jednu rolu [`role -> Roles.id`].
- Každý charakter má meno [`name`]. 
- Každý charakter má úroveň [`level`]. 
- Každý charakter má skúsenostné body [`exp`].
- Každý charakter má stav online [`is_online`].
- Každý charakter má práve jeden inventár [`inventory_id -> Inventory.id`].
- Každý charakter má počet úspešne dokončených úloh [`quest_count`].

### Monsters

Tabuľka **Monsters** predstavuje jednu príšeru, ktorá má niektoré charakteristiky rovnaké ako postava **Characters**

- Príšera môže byť šéf [`is_boss`].
- Príšera môže ale nemusí byť dostupná [`is_available`].
- Každá príšera poskytuje určitý počet skúsenostných bodov [`exp_for_kill`].
- Každá príšera má stav zabitia [`is_killed`].


### Creature_stats

Tabuľka **Creature_stats** predstavuje vlastnosti jednej postavy alebo jedného príšera [`creature_id -> Characters.id` alebo `creature_id -> Monsters.id`]

- Postava/Príšera má zdravotné body [`hp`].
- Postava/Príšera má počet životov [`lives`].
- Postava/Príšera má útočnú hodnotu [`attack`].
- Postava/Príšera má obrannú hodnotu [`defense`].
- Postava/Príšera má x-ovú pozíciu na mapu, kde sa momentálne nachádza [`x_position`].
- Postava/Príšera má y-ovú pozíciu na mapu, kde sa momentálne nachádza [`y_position`].
- Postava/Príšera vždy nachádza na niektorej mape [`map_id -> Maps.id`].


### Roles

Tabuľka **Roles** predstavuje rolu jednej postavy (**Characters**)

- Na základe používateľom vybranej roli budú modifikované štatistiky postavy 
- `Creature_stats.attack` bude vynásobené s konštantou `attack_cons`
- `Creature_stats.defense` bude vynásobené s konštantou `defense_cons`
- `Creature_stats.hp` bude vynásobené s konštantou `hp_cons`

### Skill_list

Tabuľka **Skill_list** predstavuje zoznam schopností pre danú rolu

- Na základe používateľom vybranej roli [`role_id` -> Roles.id] bude priradený zoznam schopností pre postavy (**Characters**)

### Skills

Tabuľka **Skills** predstavuje jednu schopnosť, ktorá patrí do zoznamu schopností [`skill_list_id -> Skill_list.id`] danej roli 

- Každá schopnosť má meno
- Schopnosti majú stromovú štruktúru, a pri každej schopnosti sa vyžaduje, aby postava už vlastnila schopnosť o stupeň vyššie v strome [`required_skill_id -> Skills.id`]
- Každá schopnosť vyžaduje určitú úroveň postavy


### Friendships

Tabuľka **Friendships** predstavuje vzťah medzi dvoma používateľmi [`id_requester -> Users.id` a `id_addresee -> Users.id`] v hre.

- Každý friendship má stav [`status`] a ten môže byť: `1` - *requested*, `2` - *accepted*, `3` - *declined*, `4` - *blocked*.

### Teams

Tabuľka **Teams** predstavuje skupinu hráčov. Skupiny umožňujú, aby členovia mohli medzi sebou komunikovať pomocou chatu.

- Každý tím má meno  [`name`].
- Každý tím má admina [`admin_id -> Users.id`], ktorý vytvoril skupinu.


### Members

Tabuľka **Members** predstavuje členov tímu (**Teams**) 

- Atribút `team_id` definuje ku ktorému tímu patrí daný člen.
- V rámci tímov má každý hráč vlastné identifikačné číslo [`member_id`].


### Quests

Tabuľka **Quests** predstavuje jednu úlohu v hre.

- Každá úloha má určitý požadovaný level, aby k nej bolo možné prístúpiť [`required_level`].
- Každá úloha má stav, ktorá nám hovorí o tom, či je potrebné danú úlohu dokončiť, aby príbeh sa posunul vpred [`required_to_complete`].
- Každá úloha má stav, ktorá nám hovorí o tom, či daná úloha bola dokončená [`completed`].
- Za dokončenie každej úlohy postava získa určité množstvo skúsenostných bodov [`exp_for_completing`].
- Každá úloha má úroveň obtiažnosti [`difficulty`].
- Úlohu môžu schváliť aj viaceré postavy [`accepted_by -> Characters.id`].
- Každá úloha sa odohráva na určitej mape [`on_map -> Maps.id`].
- Každá úloha má nejaký popis s inštrukciami a požiadavkami, ktoré postava musí dokončiť a splniť. [`text`].


### Maps

Tabuľka **Maps** charakterizuje hracie pole v hre

- Atribút [`name`] predstavuje názov danej mapy.
- Každá mapa vyžaduje minimálnu úroveň [`required_level`] pred vstupom na ňu.
- Mapa má šírku [`width`] aj výšku [`height`]. Tieto atribúty definujú jej veľkosť a priestor, v ktorom sa môže postava pohybovať.


### Battle

Tabuľka **Battle** predstavuje bitku v hre.

- Každá bitka je buď PVP [`type -> PVP_battle.id`] alebo PVE [`type -> PVE_battle.id`].
- Každá bitka má víťaza [`winner_id -> Characters.id` alebo `winner_id -> Monsters.id`].
- Bitka sa vzťahuje na postavu [`character_id -> Character.id`].
- Bitka môže byť aj tímová, ak dva tímy bojujú proti sebe [`team1_id -> Teams.id` a `team2_id -> Teams.id`]. Ak nejde o tímový boj, tieto atribúty majú hodnotu `null`.


### PVP_battle

Tabuľka **PVP_battle** predstavuje bitku, kde hráč bojuje proti inému hráčovi.

- `player1_id -> Characters.id` a `player2_id -> Characters.id` predstavujú účastníkov bitky.
- `battle_id -> Characters.id` ukazuje na postavu, ktorý bitku inicioval.


### PVE_battle

Tabuľka **PVE_battle** predstavuje bitku, kde hráč bojuje proti príšerovi.

- `character_id -> Characters.id` a `monster_id -> Monsters.id` predstavujú účastníkov bitky.
- `battle_id -> Characters.id` ukazuje na postavu.

### Combat_log

Tabuľka **Combat_log** predstavuje udalosti, ktoré sa udiali počas bitky.

- Atribút `attacker_id -> Characters.id` alebo `attacker_id -> Monsters.id` hovorí o tom, kto ako zaútočil na druhého v bitke.
- Atribút `hit_number` hovorí o spôsobenej škode na zdraví [`Creature_stats.hp`] druhej strane.
- Atribút `hit_by -> Gears.id` hovorí o zbrani s ktorou bola spôsobená škoda.
- Atribút `used_skill -> Skills.id` hovorí a použitej schopnosti v bitke (v prípade, ak nebola použitá žiadna schopnosť, tak má hodnotu `null`)
- Atribút `exp_difference -> Characters.exp` je hodnota, ktorá sa buď pripočíta alebo odpočíta z ceľkovej hodnoty skúsenostných bodov.
- Atribút `battle_type_id -> PVE_battle.id` alebo `battle_type_id -> PVP_battle.id` hovorí o typu bitky.

### Inventory

Tabuľka **Inventory** predstavuje kapsu s predmetmi, ktorú postava vlastní.

- Postava môže mať oblečené brnenie a môže mať pri sebe nejakú zbraň. Tieto predmety su definované v tabuľke **Equipped_gear**.


### Equipped_gear

Tabuľka **Equipped_gear** predstavuje tri predmety, ktoré sa nachádzaju v kapse postavy a zaroveň je nimi postava vyzbrojená.

- Zbraň [`weapon`] má vlastné identifikačné číslo, ktoré ukazuje na tabuľku Gear, kde je uvedená jej sila.
- Brnenie [`armour`] má vlastné identifikačné číslo, ktoré ukazuje na tabuľku Gear, kde je uvedená jeho sila.
- Štít [`shield`] má vlastné identifikačné číslo, ktoré ukazuje na tabuľku Gear, kde je uvedená jeho sila.


### Gear

Tabuľka **Gear** definuje silu daného predmetu

- Atribút `name` predstavuje názov predmetu
- Atribút `attack_cons` hovorí o tom, akou konštantou sa prenasobí ceľková hodnota útočného čisla `Creature_stats.attack`
- Atribút `defense_cons` hovorí o tom, akou konštantou sa prenasobí ceľková hodnota obranného čisla `Creature_stats.defense`
- Atribút `hp_cons` hovorí o tom, akou konštantou sa prenasobí ceľková hodnota zdravia `Creature_stats.health`

### Loot_list

Tabuľka **Loot_list** predstavuje zoznam koristi, ktoré na niektorej mape nachádzajú [`map_id -> Maps.id`]


### Loots
Tabuľka **Loots** definuje už konkrétnu korisť a opisuje kde na mape sa nachádza. Je súčasťou tabuľky **Loot_list**

- Atribút `x_position` udáva x-ovú pozíciu mapy, kde sa korisť nachádza
- Atribút `y_position` udáva y-ovú pozíciu mapy, kde sa korisť nachádza
- Atribút `gear_id -> Gears.id` hovorí o tom o aký predmet ide a v tabuľke **Gear** sú definované jeho vlastnosti.
