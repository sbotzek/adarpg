with Text_Bounded;
with RPG.Stats; use RPG.Stats;

package RPG.Creatures is
   package Creature_Name is new Text_Bounded(Min => 3, Max => 20);
   type Creature_Level is new Natural range 0 .. 20 with Default_Value => 0;

   type Creature is record
      Name : Creature_Name.T;
      Level : Creature_Level := 1;
      Stats : Creature_Stats;
   end record;
end RPG.Creatures;
