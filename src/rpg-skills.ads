with Text_Bounded;
with RPG.Skill_Values;
with RPG.Primary_Stats;

package RPG.Skills is
   type Skill_Id is (Toughness_Id, Strength_Id,
                     Reflex_Id, Timing_Id,
                     Anticipation_Id, Deception_Id,
                     Willpower_Id, Domination_Id);
   package Skill_Name is new Text_Bounded(Min => 1, Max => 20);

   type Skill is record
      Id : Skill_Id;
      Name : Skill_Name.T;
      Primary_Stat : Primary_Stats.Primary_Stat_Id;
   end record;

   function Find_Skill(Id : Skill_Id) return Skill;

   package Toughness is new RPG.Skill_Values
     (Bonus_Stat => Primary_Stats.Vigor_Id);
   package Reflex is new RPG.Skill_Values
     (Bonus_Stat => Primary_Stats.Agility_Id);
   package Anticipation is new RPG.Skill_Values
     (Bonus_Stat => Primary_Stats.Intelligence_Id);
   package Willpower is new RPG.Skill_Values
     (Bonus_Stat => Primary_Stats.Spirit_Id);

   package Strength is new RPG.Skill_Values
     (Bonus_Stat => Primary_Stats.Vigor_Id);
   package Timing is new RPG.Skill_Values
     (Bonus_Stat => Primary_Stats.Agility_Id);
   package Deception is new RPG.Skill_Values
     (Bonus_Stat => Primary_Stats.Intelligence_Id);
   package Domination is new RPG.Skill_Values
     (Bonus_Stat => Primary_Stats.Spirit_Id);

   type Skill_Proficiencies is record
      Toughness : Skills.Toughness.T;
      Reflex : Skills.Reflex.T;
      Anticipation : Skills.Anticipation.T;
      Willpower : Skills.Willpower.T;

      Strength : Skills.Strength.T;
      Timing : Skills.Timing.T;
      Deception : Skills.Deception.T;
      Domination : Skills.Domination.T;
   end record;
end RPG.Skills;
