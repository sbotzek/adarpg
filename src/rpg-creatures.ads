with Text_Bounded;
with RPG.Stat;
with RPG.Primary_Stats; use RPG.Primary_Stats;

package RPG.Creatures is
   package Creature_Name is new Text_Bounded(Min => 3, Max => 20);
   type Creature_Level is new Natural range 0 .. 20 with Default_Value => 0;

   -- HP
   package Creature_Maximum_HP is new RPG.Stat
     (Base_Min      => 0,
      Base_Max      => 10_000,
      Base_Default  => 0,
      Effective_Min => 0,
      Effective_Max => 10_000);

   type Creature_Current_HP is new Natural with Default_Value => 0;

   type Creature_HP is record
      Maximum : Creature_Maximum_HP.T;
      Current : Creature_Current_HP;
   end record;

   procedure Damage (HP : in Out Creature_HP; Amount : Creature_Current_HP);
   procedure Heal (HP : in Out Creature_HP; Amount : Creature_Current_HP);
   procedure Full_Heal (HP : in Out Creature_HP);
   procedure Increase_Maximum_Base (HP : in Out Creature_HP; Amount : Creature_Maximum_HP.Base_T);
   procedure Decrease_Maximum_Base (HP : in Out Creature_HP; Amount : Creature_Maximum_HP.Base_T);
   procedure Modify_Maximum (HP : in Out Creature_HP; Amount : Creature_Maximum_HP.Modifier_T);
   function Is_Dead (HP : Creature_HP) return Boolean;

   type Creature_Stats is record
      HP           : Creature_HP;
      Vigor        : Primary_Stats.Vigor.T;
      Agility      : Primary_Stats.Agility.T;
      Intelligence : Primary_Stats.Intelligence.T;
      Spirit       : Primary_Stats.Spirit.T;
   end record;

   procedure Roll_Primary_Stats (S : in Out Creature_Stats);
   function Defense (S : Creature_Stats) return Integer;

   type Creature is record
      Name : Creature_Name.T;
      Level : Creature_Level := 1;
      Stats : Creature_Stats;
   end record;
end RPG.Creatures;
