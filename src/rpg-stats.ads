with RPG.Stat;

package RPG.Stats is
   -- HP
   type Creature_Current_HP is new Natural with Default_Value => 0;
   type Creature_Maximum_HP is new Natural with Default_Value => 0;

   type Creature_HP is record
      Maximum : Creature_Maximum_HP := 0;
      Current : Creature_Current_HP := 0;
   end record;

   procedure Damage (HP : in out Creature_HP; Amount : Creature_Current_HP);
   procedure Heal (HP : in Out Creature_HP; Amount : Creature_Current_HP);
   procedure Full_Heal (HP : in Out Creature_HP);
   procedure Increase_Maximum(HP : in Out Creature_HP; Amount : Creature_Maximum_HP);

   -- Primary Stats
   type Primary_Stat_Natural is new Natural range 0 .. 99;
   type Primary_Stat_Modified is new Integer range -99 .. 99;
   type Primary_Stat_Effective is new Natural range 0 .. 198;

   type Vigor_Natural is new Primary_Stat_Natural;
   type Vigor_Modified is new Primary_Stat_Modified;
   type Vigor_Effective is new Primary_Stat_Effective;
   package Vigor is new RPG.Stat
     (Natural_Value   => Vigor_Natural,
      Modified_Value  => Vigor_Modified,
      Effective_Value => Vigor_Effective);

   type Agility_Natural is new Primary_Stat_Natural;
   type Agility_Modified is new Primary_Stat_Modified;
   type Agility_Effective is new Primary_Stat_Effective;
   package Agility is new RPG.Stat
     (Natural_Value   => Agility_Natural,
      Modified_Value  => Agility_Modified,
      Effective_Value => Agility_Effective);

   type Intelligence_Natural is new Primary_Stat_Natural;
   type Intelligence_Modified is new Primary_Stat_Modified;
   type Intelligence_Effective is new Primary_Stat_Effective;
   package Intelligence is new RPG.Stat
     (Natural_Value   => Intelligence_Natural,
      Modified_Value  => Intelligence_Modified,
      Effective_Value => Intelligence_Effective);

   type Charisma_Natural is new Primary_Stat_Natural;
   type Charisma_Modified is new Primary_Stat_Modified;
   type Charisma_Effective is new Primary_Stat_Effective;
   package Charisma is new RPG.Stat
     (Natural_Value   => Charisma_Natural,
      Modified_Value  => Charisma_Modified,
      Effective_Value => Charisma_Effective);

   type Creature_Stats is record
      HP           : Creature_HP;
      Vigor        : Stats.Vigor.T;
      Agility      : Stats.Agility.T;
      Intelligence : Stats.Intelligence.T;
      Charisma     : Stats.Charisma.T;
   end record;

   procedure Roll_Primary_Stats (S : in out Creature_Stats);
end RPG.Stats;
