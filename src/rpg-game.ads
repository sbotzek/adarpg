with Ada.Containers.Vectors;
with RPG.Creatures; use RPG.Creatures;
with RPG.Classes; use RPG.Classes;

package RPG.Game is
   type Game_Mode is (Pick_Name, Pick_Class, Main_Menu, Fight, Quit);

   package Game_Mode_Stack is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Game_Mode);

   subtype Game_Mode_Stack_T is Game_Mode_Stack.Vector;

   type Game_State is record
      Modes           : Game_Mode_Stack_T;
      Player_Creature : Creature;
      Player_Class_Id : Optional_Class_Id := None;
   end record;
end RPG.Game;
