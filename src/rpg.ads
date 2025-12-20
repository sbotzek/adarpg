with Ada.Containers.Vectors;
with Text_Bounded;

package RPG is
   procedure Run;

   type Game_Mode is (Pick_Name, Pick_Class, Main_Menu, Quit);
   package Game_Mode_Stack is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Game_Mode);
   subtype Game_Mode_Stack_T is Game_Mode_Stack.Vector;
   procedure Replace(S : in out Game_Mode_Stack_T; M : Game_Mode);

   package Creature_Name is new Text_Bounded(Min => 3, Max => 20);

   type Creature is record
      Name : Creature_Name.T;
   end record;

   type Game is record
      Modes           : Game_Mode_Stack_T;
      Player_Creature : Creature;
   end record;
end RPG;
