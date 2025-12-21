with Ada.Containers.Vectors;
with RPG.Dice;
with Text_Bounded;
with RPG.Stats; use RPG.Stats;

package RPG.Types is
   type Game_Mode is (Pick_Name, Pick_Class, Main_Menu, Quit);

   package Game_Mode_Stack is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Game_Mode);

   subtype Game_Mode_Stack_T is Game_Mode_Stack.Vector;

   -- Class
   type Optional_Class_Id is (None, Cleric, Fighter, Thief, Wizard)
     with Default_Value => None;
   subtype Class_Id is Optional_Class_Id range Cleric .. Wizard;
   package Class_Name is new Text_Bounded(Min => 3, Max => 20);
   type Class is record
      Id : Class_Id := Cleric;
      Name : Class_Name.T;
      HP_Per_Level : RPG.Dice.Dieroll;
   end record;

   -- Creature
   package Creature_Name is new Text_Bounded(Min => 3, Max => 20);
   type Creature_Level is new Natural with Default_Value => 0;

   type Creature_HP is record
      Maximum : Creature_Maximum_HP := 0;
      Current : Creature_Current_HP := 0;
   end record;
   procedure Damage (HP : in out Creature_HP; Amount : Creature_Current_HP);
   procedure Heal (HP : in out Creature_HP; Amount : Creature_Current_HP);
   procedure Full_Heal (HP : in out Creature_HP);
   procedure Increase_Maximum(HP : in out Creature_HP; Amount : Creature_Maximum_HP);

   type Creature is record
      Name : Creature_Name.T;
      Level : Creature_Level := 1;
      HP : Creature_HP;
   end record;

   type Game is record
      Modes           : Game_Mode_Stack_T;
      Player_Creature : Creature;
      Player_Class_Id : Optional_Class_Id := None;
   end record;
end RPG.Types;
