package body RPG.Skills is
   Skills : constant array (Skill_Id) of Skill :=
     (Toughness_Id    => (Id           => Toughness_Id,
                          Name         => Skill_Name.Create("Toughness"),
                          Primary_Stat => Toughness.Bonus_Stat_Id),
      Strength_Id     => (Id           => Strength_Id,
                          Name         => Skill_Name.Create("Strength"),
                          Primary_Stat => Strength.Bonus_Stat_Id),
      Reflex_Id       => (Id           => Reflex_Id,
                          Name         => Skill_Name.Create("Reflex"),
                          Primary_Stat => Reflex.Bonus_Stat_Id),
      Timing_Id       => (Id           => Timing_Id,
                          Name         => Skill_Name.Create("Timing"),
                          Primary_Stat => Timing.Bonus_Stat_Id),
      Anticipation_Id => (Id           => Anticipation_Id,
                          Name         => Skill_Name.Create("Anticipation"),
                          Primary_Stat => Anticipation.Bonus_Stat_Id),
      Deception_Id    => (Id           => Deception_Id,
                          Name         => Skill_Name.Create("Deception"),
                          Primary_Stat => Deception.Bonus_Stat_Id),
      Willpower_Id    => (Id           => Willpower_Id,
                          Name         => Skill_Name.Create("Willpower"),
                          Primary_Stat => Willpower.Bonus_Stat_Id),
      Domination_Id   => (Id           => Domination_Id,
                          Name         => Skill_Name.Create("Domination"),
                          Primary_Stat => Domination.Bonus_Stat_Id));

   function Find_Skill(Id : Skill_Id) return Skill is
   begin
      return Skills(Id);
   end Find_Skill;
end RPG.Skills;
