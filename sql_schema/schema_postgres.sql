-- -----------------------------------------------------
-- Table "Users"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Users" CASCADE;

CREATE TABLE  "Users" (
  "id" INT NOT NULL,
  "email" VARCHAR(45) NOT NULL,
  "first_and_last_name" VARCHAR(100) NOT NULL,
  "username" VARCHAR(45) NOT NULL,
  "password" VARCHAR(45) NOT NULL,
  "registered_with" INT NOT NULL,
  "verified" INT NOT NULL,
  "date_of_birth" TIMESTAMP NOT NULL,
  PRIMARY KEY ("id"));


-- -----------------------------------------------------
-- Table "Gears"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Gears" CASCADE;

CREATE TABLE  "Gears" (
  "id" INT NOT NULL,
  "name" VARCHAR(45) NOT NULL,
  "attack_cons" float NOT NULL,
  "defense_cons" float NOT NULL,
  "hp_cons" float NOT NULL,
  "inventory_id" INT NOT NULL,
  "weight" INT NOT NULL,
  PRIMARY KEY ("id")
);
  

-- -----------------------------------------------------
-- Table "Equipped_gears"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Equipped_gears" CASCADE;

CREATE TABLE  "Equipped_gears" (
  "weapon" INT NULL,
  "armour" INT NULL,
  "shield" INT NULL,
  "id" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "weapon"
    FOREIGN KEY ("weapon")
    REFERENCES "Gears" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "armour"
    FOREIGN KEY ("armour")
    REFERENCES "Gears" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "shield"
    FOREIGN KEY ("shield")
    REFERENCES "Gears" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);





-- -----------------------------------------------------
-- Table "Inventories"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Inventories" CASCADE;

CREATE TABLE  "Inventories" (
  "id" INT NOT NULL,
  "equipped_gears_id" INT NOT NULL,
  "capacity" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "equipped_gear_id"
    FOREIGN KEY ("equipped_gears_id")
    REFERENCES "Equipped_gears" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table "Roles"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Roles" CASCADE;

CREATE TABLE  "Roles" (
  "id" INT NOT NULL,
  "attack_cons" float NOT NULL,
  "defense_cons" float NOT NULL,
  "hp_cons" float NOT NULL,
  PRIMARY KEY ("id"));


-- -----------------------------------------------------
-- Table "Maps"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Maps" CASCADE;

CREATE TABLE  "Maps" (
  "id" INT NOT NULL,
  "name" VARCHAR(45) NOT NULL,
  "required_level" VARCHAR(45) NOT NULL,
  "height" VARCHAR(45) NOT NULL,
  "width" VARCHAR(45) NOT NULL,
  PRIMARY KEY ("id"));



-- -----------------------------------------------------
-- Table "Characters"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Characters" CASCADE;

CREATE TABLE  "Characters" (
  "id" INT NOT NULL,
  "owner" INT NOT NULL,
  "role" INT NOT NULL,
  "name" VARCHAR(45) NOT NULL,
  "level" SMALLINT NOT NULL,
  "exp" BIGINT NOT NULL,
  "is_online" INT NOT NULL,
  "quests_count" INT NOT NULL,
  "inventory_id" INT NOT NULL,
  "map_id" INT NOT NULL,
  "x_position" INT NOT NULL,
  "y_position" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "owner"
    FOREIGN KEY ("id")
    REFERENCES "Users" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "inventory_id"
    FOREIGN KEY ("inventory_id")
    REFERENCES "Inventories" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "role"
    FOREIGN KEY ("role")
    REFERENCES "Roles" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "map_id"
    FOREIGN KEY ("map_id")
    REFERENCES "Maps" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);






-- -----------------------------------------------------
-- Table "Friendships"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Friendships" CASCADE;

CREATE TABLE  "Friendships" (
  "id" INT NOT NULL,
  "id_requester" INT NOT NULL,
  "id_adressee" INT NOT NULL,
  "status" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "id_requester"
    FOREIGN KEY ("id_requester")
    REFERENCES "Users" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "id_addressee"
    FOREIGN KEY ("id_adressee")
    REFERENCES "Users" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);





-- -----------------------------------------------------
-- Table "Monster_types"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Monster_types" CASCADE;

CREATE TABLE  "Monster_types" (
  "id" INT NOT NULL,
  "attack_cons" float NOT NULL,
  "defense_cons" float NOT NULL,
  "hp_cons" float NOT NULL,
  PRIMARY KEY ("id"));


-- -----------------------------------------------------
-- Table "Monsters"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Monsters" CASCADE;

CREATE TABLE  "Monsters" (
  "id" INT NOT NULL,
  "is_boss" INT NOT NULL,
  "name" VARCHAR(45) NOT NULL,
  "level" INT NOT NULL,
  "is_available" INT NOT NULL,
  "exp_for_kill" INT NOT NULL,
  "is_killed" INT NOT NULL,
  "type" INT NOT NULL,
  "map_id" INT NOT NULL,
  "x_positon" INT NOT NULL,
  "y_position" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "type"
    FOREIGN KEY ("type")
    REFERENCES "Monster_types" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "map_id"
    FOREIGN KEY ("map_id")
    REFERENCES "Maps" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);





-- -----------------------------------------------------
-- Table "Character_stats"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Character_stats" CASCADE;

CREATE TABLE  "Character_stats" (
  "id" INT NOT NULL,
  "hp" INT NOT NULL,
  "lives" INT NOT NULL,
  "attack" INT NOT NULL,
  "defense" INT NOT NULL,
  "character_id" INT NOT NULL,
  "speed" INT NOT NULL,
  CONSTRAINT "character_id"
    FOREIGN KEY ("character_id")
    REFERENCES "Characters" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table "Quests"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Quests" CASCADE;

CREATE TABLE  "Quests" (
  "id" INT NOT NULL,
  "required_level" INT NOT NULL,
  "required_to complete" INT NOT NULL ,
  "exp_for_completing" INT NOT NULL,
  "difficulty" INT NOT NULL,
  "on_map" INT NOT NULL,
  "text" VARCHAR(45) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "on_map"
    FOREIGN KEY ("on_map")
    REFERENCES "Maps" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table "Teams"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Teams" CASCADE;

CREATE TABLE  "Teams" (
  "id" INT NOT NULL,
  "admin_id" INT NOT NULL,
  "name" VARCHAR(45) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "admin_id"
    FOREIGN KEY ("admin_id")
    REFERENCES "Users" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table "Members"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Members" CASCADE;

CREATE TABLE  "Members" (
  "member_id" INT NOT NULL ,
  "team_id" INT NOT NULL,
  "user_id" INT NOT NULL,
  PRIMARY KEY ("member_id"),
  CONSTRAINT "team_id"
    FOREIGN KEY ("team_id")
    REFERENCES "Teams" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "user_id"
    FOREIGN KEY ("user_id")
    REFERENCES "Users" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);





-- -----------------------------------------------------
-- Table "Skills"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Skills" CASCADE;

CREATE TABLE  "Skills" (
  "id" INT NOT NULL,
  "name" VARCHAR(45) NOT NULL,
  "required_skill_id" INT NULL,
  "required_level" INT NOT NULL,
  "role_id" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "required_skill_id"
    FOREIGN KEY ("required_skill_id")
    REFERENCES "Skills" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "role_id"
    FOREIGN KEY ("role_id")
    REFERENCES "Roles" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




-- -----------------------------------------------------
-- Table "Conversations"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Conversations" CASCADE;

CREATE TABLE  "Conversations" (
  "id" INT NOT NULL,
  "receiver_id" INT NOT NULL,
  "sender_id" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "receiver_id"
    FOREIGN KEY ("receiver_id")
    REFERENCES "Users" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "sender_id"
    FOREIGN KEY ("sender_id")
    REFERENCES "Users" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




-- -----------------------------------------------------
-- Table "Messages"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Messages" CASCADE;

CREATE TABLE  "Messages" (
  "id" INT NOT NULL,
  "sender_id" INT NOT NULL,
  "sent_at" TIMESTAMP NOT NULL,
  "text" VARCHAR(100) NOT NULL,
  "conversation_id" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "sender_id"
    FOREIGN KEY ("sender_id")
    REFERENCES "Users" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "conversation_id"
    FOREIGN KEY ("conversation_id")
    REFERENCES "Conversations" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




-- -----------------------------------------------------
-- Table "Loots"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Loots" CASCADE;

CREATE TABLE  "Loots" (
  "id" INT NOT NULL,
  "x_position" INT NOT NULL,
  "y_position" INT NOT NULL,
  "gear_id" INT NOT NULL,
  "map_id" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "gear_id"
    FOREIGN KEY ("gear_id")
    REFERENCES "Gears" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "map_id"
    FOREIGN KEY ("map_id")
    REFERENCES "Maps" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




-- -----------------------------------------------------
-- Table "Team_messages"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Team_messages" CASCADE;

CREATE TABLE  "Team_messages" (
  "id" INT NOT NULL,
  "team_id" INT NOT NULL,
  "sender_id" INT NOT NULL,
  "sent_at" TIMESTAMP NOT NULL,
  "text" VARCHAR(100) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "team_id"
    FOREIGN KEY ("team_id")
    REFERENCES "Teams" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "sender_id"
    FOREIGN KEY ("sender_id")
    REFERENCES "Users" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




-- -----------------------------------------------------
-- Table "Monster_stats"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Monster_stats" CASCADE;

CREATE TABLE  "Monster_stats" (
  "id" INT NOT NULL,
  "hp" INT NOT NULL,
  "lives" INT NOT NULL,
  "attack" float NOT NULL,
  "defense" float NOT NULL,
  "monster_id" INT NOT NULL,
  "speed" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "monster_id"
    FOREIGN KEY ("monster_id")
    REFERENCES "Monsters" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table "Battle_logs"
-- -----------------------------------------------------
DROP TABLE IF EXISTS "Battle_logs" CASCADE;

CREATE TABLE  "Battle_logs" (
  "id" INT NOT NULL,
  "attacker_character_id" INT NOT NULL,
  "attacker_monster_id" INT NOT NULL,
  "targer_character_id" INT NOT NULL,
  "target_monster_id" INT NOT NULL,
  "team1_id" INT NOT NULL,
  "team2_id" INT NULL,
  "damage_to_character" INT NULL,
  "damage_to_monster" INT NULL,
  "hit_by" INT NOT NULL,
  "used_skill" INT NULL,
  "exp_difference" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "attacker_character_id"
    FOREIGN KEY ("attacker_character_id")
    REFERENCES "Characters" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "attacker_monster_id"
    FOREIGN KEY ("attacker_monster_id")
    REFERENCES "Monsters" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "target_character_id"
    FOREIGN KEY ("targer_character_id")
    REFERENCES "Characters" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "target_monster_id"
    FOREIGN KEY ("target_monster_id")
    REFERENCES "Monsters" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "team1_id"
    FOREIGN KEY ("team1_id")
    REFERENCES "Teams" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "team2_id"
    FOREIGN KEY ("team2_id")
    REFERENCES "Teams" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "hit_by"
    FOREIGN KEY ("hit_by")
    REFERENCES "Gears" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "used_skill"
    FOREIGN KEY ("used_skill")
    REFERENCES "Skills" ("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE "Gears"
	ADD CONSTRAINT "inventory_id"
		FOREIGN KEY ("inventory_id")
		REFERENCES "Inventories" ("id")
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

