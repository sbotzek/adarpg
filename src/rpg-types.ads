with Ada.Containers.Vectors;
with RPG.Stats; use RPG.Stats;
with RPG.Creatures; use RPG.Creatures;
with RPG.Classes; use RPG.Classes;

package RPG.Types is
   -- See RPG.Stats for stat types.
   -- See RPG.Creatures for creature types.
   -- See RPG.Classes for class types.

   -- Top Level Game State
   type Game_Mode is (Pick_Name, Pick_Class, Main_Menu, Fight, Quit);

   package Game_Mode_Stack is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Game_Mode);

   subtype Game_Mode_Stack_T is Game_Mode_Stack.Vector;

   type Game is record
      Modes           : Game_Mode_Stack_T;
      Player_Creature : Creature;
      Player_Class_Id : Optional_Class_Id := None;
   end record;
end RPG.Types;
