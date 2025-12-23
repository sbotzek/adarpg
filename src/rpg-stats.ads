with RPG.Stat;

package RPG.Stats is
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

   -- Primary Stats
   package Vigor is new RPG.Stat
     (Base_Min      => 0,
      Base_Max      => 25,
      Base_Default  => 0,
      Effective_Min => 0,
      Effective_Max => 30);

   package Agility is new RPG.Stat
     (Base_Min      => 0,
      Base_Max      => 25,
      Base_Default  => 0,
      Effective_Min => 0,
      Effective_Max => 30);

   package Intelligence is new RPG.Stat
     (Base_Min      => 0,
      Base_Max      => 25,
      Base_Default  => 0,
      Effective_Min => 0,
      Effective_Max => 30);

   package Spirit is new RPG.Stat
     (Base_Min      => 0,
      Base_Max      => 25,
      Base_Default  => 0,
      Effective_Min => 0,
      Effective_Max => 30);

   type Creature_Stats is record
      HP           : Creature_HP;
      Vigor        : Stats.Vigor.T;
      Agility      : Stats.Agility.T;
      Intelligence : Stats.Intelligence.T;
      Spirit       : Stats.Spirit.T;
   end record;

   procedure Roll_Primary_Stats (S : in out Creature_Stats);
   function Defense (S : Creature_Stats) return Natural;

   function Is_Dead (HP : Creature_HP) return Boolean;
end RPG.Stats;
