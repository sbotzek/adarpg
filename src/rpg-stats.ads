with RPG.Stat;

package RPG.Stats is
   -- HP
   type Creature_Maximum_HP_Base is new Natural range 0 .. 9999 with Default_Value => 0;
   type Creature_Maximum_HP_Modifier is new Integer range -9999 .. 9999 with Default_Value => 0;
   type Creature_Maximum_HP_Effective is new Natural range 0 .. 19998 with Default_Value => 0;
   package Creature_Maximum_HP is new RPG.Stat
     (Base_Value      => Creature_Maximum_HP_Base,
      Modifier_Value  => Creature_Maximum_HP_Modifier,
      Effective_Value => Creature_Maximum_HP_Effective);

   type Creature_Current_HP is new Natural with Default_Value => 0;

   type Creature_HP is record
      Maximum : Creature_Maximum_HP.T;
      Current : Creature_Current_HP;
   end record;

   procedure Damage (HP : in Out Creature_HP; Amount : Creature_Current_HP);
   procedure Heal (HP : in Out Creature_HP; Amount : Creature_Current_HP);
   procedure Full_Heal (HP : in Out Creature_HP);
   procedure Increase_Maximum_Base (HP : in Out Creature_HP; Amount : Creature_Maximum_HP_Base);
   procedure Decrease_Maximum_Base (HP : in Out Creature_HP; Amount : Creature_Maximum_HP_Base);
   procedure Modify_Maximum (HP : in Out Creature_HP; Amount : Creature_Maximum_HP_Modifier);

   -- Primary Stats
   type Primary_Stat_Base is new Natural range 0 .. 99 with Default_Value => 0;
   type Primary_Stat_Modifier is new Integer range -99 .. 99 with Default_Value => 0;
   type Primary_Stat_Effective is new Natural range 0 .. 198 with Default_Value => 0;

   type Vigor_Base is new Primary_Stat_Base;
   type Vigor_Modifier is new Primary_Stat_Modifier;
   type Vigor_Effective is new Primary_Stat_Effective;
   package Vigor is new RPG.Stat
     (Base_Value      => Vigor_Base,
      Modifier_Value  => Vigor_Modifier,
      Effective_Value => Vigor_Effective);

   type Agility_Base is new Primary_Stat_Base;
   type Agility_Modifier is new Primary_Stat_Modifier;
   type Agility_Effective is new Primary_Stat_Effective;
   package Agility is new RPG.Stat
     (Base_Value      => Agility_Base,
      Modifier_Value  => Agility_Modifier,
      Effective_Value => Agility_Effective);

   type Intelligence_Base is new Primary_Stat_Base;
   type Intelligence_Modifier is new Primary_Stat_Modifier;
   type Intelligence_Effective is new Primary_Stat_Effective;
   package Intelligence is new RPG.Stat
     (Base_Value      => Intelligence_Base,
      Modifier_Value  => Intelligence_Modifier,
      Effective_Value => Intelligence_Effective);

   type Spirit_Base is new Primary_Stat_Base;
   type Spirit_Modifier is new Primary_Stat_Modifier;
   type Spirit_Effective is new Primary_Stat_Effective;
   package Spirit is new RPG.Stat
     (Base_Value      => Spirit_Base,
      Modifier_Value  => Spirit_Modifier,
      Effective_Value => Spirit_Effective);

   type Creature_Stats is record
      HP           : Creature_HP;
      Vigor        : Stats.Vigor.T;
      Agility      : Stats.Agility.T;
      Intelligence : Stats.Intelligence.T;
      Spirit       : Stats.Spirit.T;
   end record;

   procedure Roll_Primary_Stats (S : in out Creature_Stats);
end RPG.Stats;
