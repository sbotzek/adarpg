with RPG.Dice;
with RPG.Creatures; use RPG.Creatures;
with RPG.Skills;

package body RPG.Classes is
   Classes : constant array (Class_Id) of Class :=
     (Cleric  => (Id => Cleric,
                  Name => Class_Name.Create("Cleric"),
                  HP_Per_Level => (Number => 1, Size => 8, Bonus => 0),
                  Skills => (RPG.Skills.Endurance_Id => (Level_Interval => 1, Amount => 3),
                             RPG.Skills.Strength_Id => (Level_Interval => 1, Amount => 3),

                             RPG.Skills.Reflex_Id => (Level_Interval => 1, Amount => 2),
                             RPG.Skills.Timing_Id => (Level_Interval => 1, Amount => 2),

                             RPG.Skills.Anticipation_Id => (Level_Interval => 1, Amount => 4),
                             RPG.Skills.Deception_Id => (Level_Interval => 1, Amount => 4),

                             RPG.Skills.Willpower_Id => (Level_Interval => 1, Amount => 5),
                             RPG.Skills.Domination_Id => (Level_Interval => 1, Amount => 5))),
      Fighter => (Id => Fighter,
                  Name => Class_Name.Create("Fighter"),
                  HP_Per_Level => (Number => 1, Size => 10, Bonus => 0),
                  Skills => (RPG.Skills.Endurance_Id => (Level_Interval => 1, Amount => 5),
                             RPG.Skills.Strength_Id => (Level_Interval => 1, Amount => 5),

                             RPG.Skills.Reflex_Id => (Level_Interval => 1, Amount => 4),
                             RPG.Skills.Timing_Id => (Level_Interval => 1, Amount => 4),

                             RPG.Skills.Anticipation_Id => (Level_Interval => 1, Amount => 2),
                             RPG.Skills.Deception_Id => (Level_Interval => 1, Amount => 2),

                             RPG.Skills.Willpower_Id => (Level_Interval => 1, Amount => 3),
                             RPG.Skills.Domination_Id => (Level_Interval => 1, Amount => 3))),
      Thief   => (Id => Thief,
                  Name => Class_Name.Create("Thief"),
                  HP_Per_Level => (Number => 1, Size => 6, Bonus => 0),
                  Skills => (RPG.Skills.Endurance_Id => (Level_Interval => 1, Amount => 3),
                             RPG.Skills.Strength_Id => (Level_Interval => 1, Amount => 3),

                             RPG.Skills.Reflex_Id => (Level_Interval => 1, Amount => 5),
                             RPG.Skills.Timing_Id => (Level_Interval => 1, Amount => 5),

                             RPG.Skills.Anticipation_Id => (Level_Interval => 1, Amount => 4),
                             RPG.Skills.Deception_Id => (Level_Interval => 1, Amount => 4),

                             RPG.Skills.Willpower_Id => (Level_Interval => 1, Amount => 2),
                             RPG.Skills.Domination_Id => (Level_Interval => 1, Amount => 2))),
      Wizard  => (Id => Wizard,
                  Name => Class_Name.Create("Wizard"),
                  HP_Per_Level => (Number => 1, Size => 4, Bonus => 0),
                  Skills => (RPG.Skills.Endurance_Id => (Level_Interval => 1, Amount => 2),
                             RPG.Skills.Strength_Id => (Level_Interval => 1, Amount => 2),

                             RPG.Skills.Reflex_Id => (Level_Interval => 1, Amount => 3),
                             RPG.Skills.Timing_Id => (Level_Interval => 1, Amount => 3),

                             RPG.Skills.Anticipation_Id => (Level_Interval => 1, Amount => 5),
                             RPG.Skills.Deception_Id => (Level_Interval => 1, Amount => 5),

                             RPG.Skills.Willpower_Id => (Level_Interval => 1, Amount => 4),
                             RPG.Skills.Domination_Id => (Level_Interval => 1, Amount => 4))));

   function Find_Class(Id : Class_Id) return Class is
   begin
      return Classes(Id);
   end Find_Class;

   procedure Level_Up(C : in out Creature; Id : Class_Id) is
      C_Class : constant Class := Find_Class(Id);
   begin
      C.Level := C.Level + 1;

      -- HP gain
      declare
        HP_Gain : Integer := RPG.Dice.Roll(C_Class.HP_Per_Level);
      begin
         if HP_Gain > 0 then
            Increase_Maximum_Base(C.Stats.HP, Creature_Maximum_HP.To_Base(HP_Gain));
         end if;
      end;

      -- Skill gains
      for Skill_Id in RPG.Skills.Skill_Id loop
         declare
            Gain : constant Class_Skill_Gain := C_Class.Skills(Skill_Id);
         begin
            if Natural(C.Level) mod Natural(Gain.Level_Interval) = 0 then
               case Skill_Id is
                  when RPG.Skills.Endurance_Id =>
                     RPG.Skills.Endurance.Add_Base(C.Stats.Skills.Endurance,
                       RPG.Skills.Endurance.To_Base(Gain.Amount));
                  when RPG.Skills.Strength_Id =>
                     RPG.Skills.Strength.Add_Base(C.Stats.Skills.Strength,
                       RPG.Skills.Strength.To_Base(Gain.Amount));
                  when RPG.Skills.Reflex_Id =>
                     RPG.Skills.Reflex.Add_Base(C.Stats.Skills.Reflex,
                       RPG.Skills.Reflex.To_Base(Gain.Amount));
                  when RPG.Skills.Timing_Id =>
                     RPG.Skills.Timing.Add_Base(C.Stats.Skills.Timing,
                       RPG.Skills.Timing.To_Base(Gain.Amount));
                  when RPG.Skills.Anticipation_Id =>
                     RPG.Skills.Anticipation.Add_Base(C.Stats.Skills.Anticipation,
                       RPG.Skills.Anticipation.To_Base(Gain.Amount));
                  when RPG.Skills.Deception_Id =>
                     RPG.Skills.Deception.Add_Base(C.Stats.Skills.Deception,
                       RPG.Skills.Deception.To_Base(Gain.Amount));
                  when RPG.Skills.Willpower_Id =>
                     RPG.Skills.Willpower.Add_Base(C.Stats.Skills.Willpower,
                       RPG.Skills.Willpower.To_Base(Gain.Amount));
                  when RPG.Skills.Domination_Id =>
                     RPG.Skills.Domination.Add_Base(C.Stats.Skills.Domination,
                       RPG.Skills.Domination.To_Base(Gain.Amount));
               end case;
            end if;
         end;
      end loop;
   end Level_Up;

   procedure Initialize_Creature(C : in out Creature; Id : Class_Id; Level : Creature_Level) is
   begin
      C.Level := 0;
      C.Stats.HP := (others => <>);
      C.Stats.Skills := (others => <>);
      for I in 1 .. Level loop
         Level_Up(C, Id);
      end loop;
   end Initialize_Creature;
end RPG.Classes;
