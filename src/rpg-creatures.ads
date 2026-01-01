with Text_Bounded;
with RPG.Stat_Values;
with RPG.Primary_Stats;
with RPG.Skills;

package RPG.Creatures is
   package Creature_Name is new Text_Bounded(Min => 3, Max => 20);
   type Creature_Level is new Natural range 0 .. 20 with Default_Value => 0;
   type Creature_Level_Interval is new Positive with Default_Value => 1;

   -- HP
   package Creature_Maximum_HP is new RPG.Stat_Values
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

   procedure Damage(HP : in out Creature_HP; Amount : Creature_Current_HP);
   procedure Heal(HP : in out Creature_HP; Amount : Creature_Current_HP);
   procedure Full_Heal(HP : in out Creature_HP);
   procedure Increase_Maximum_Base(HP : in out Creature_HP; Amount : Creature_Maximum_HP.Base);
   procedure Decrease_Maximum_Base(HP : in out Creature_HP; Amount : Creature_Maximum_HP.Base);
   procedure Modify_Maximum(HP : in out Creature_HP; Amount : Creature_Maximum_HP.Modifier);
   function Is_Dead(HP : Creature_HP) return Boolean;

   type Creature_Stats is tagged record
      HP           : Creature_HP;
      Primary : RPG.Primary_Stats.Primary_Stat_Values;
      Skills : RPG.Skills.Skill_Proficiencies;
   end record;

   type Creature_Defense is new Integer;
   function Defense(S : Creature_Stats) return Creature_Defense;

   -- Skill helper functions (automatically pass primary stats)
   function Endurance(S : Creature_Stats) return Skills.Endurance.Effective;
   function Strength(S : Creature_Stats) return Skills.Strength.Effective;
   function Reflex(S : Creature_Stats) return Skills.Reflex.Effective;
   function Timing(S : Creature_Stats) return Skills.Timing.Effective;
   function Anticipation(S : Creature_Stats) return Skills.Anticipation.Effective;
   function Deception(S : Creature_Stats) return Skills.Deception.Effective;
   function Willpower(S : Creature_Stats) return Skills.Willpower.Effective;
   function Domination(S : Creature_Stats) return Skills.Domination.Effective;

   type Creature is record
      Name : Creature_Name.T;
      Level : Creature_Level := 1;
      Stats : Creature_Stats;
   end record;
end RPG.Creatures;
