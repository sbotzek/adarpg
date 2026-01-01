with Text_Bounded;
with RPG.Dice;
with RPG.Creatures; use RPG.Creatures;
with RPG.Skills;

package RPG.Classes is
   type Class_Skill_Gain is record
      Level_Interval : Creature_Level_Interval;
      Amount : Natural;
   end record;
   type Class_Skill_Gains is array (RPG.Skills.Skill_Id) of Class_Skill_Gain;

   type Optional_Class_Id is (None, Cleric, Fighter, Thief, Wizard)
     with Default_Value => None;
   subtype Class_Id is Optional_Class_Id range Cleric .. Wizard;
   package Class_Name is new Text_Bounded(Min => 3, Max => 20);

   type Class is record
      Id : Class_Id := Cleric;
      Name : Class_Name.T;
      HP_Per_Level : RPG.Dice.Dieroll;
      Skills : Class_Skill_Gains;
   end record;

   function Find_Class(Id : Class_Id) return Class;
   procedure Level_Up(C : in out Creature; Id : Class_Id);
   procedure Initialize_Creature(C : in out Creature; Id : Class_Id; Level : Creature_Level);
end RPG.Classes;
