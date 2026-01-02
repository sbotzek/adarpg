with Ada.Containers.Vectors;
with RPG.Players; use RPG.Players;

package RPG.Game is
   type Game_Mode is (Pick_Name, Pick_Class, Main_Menu, Fight, Quit);

   package Game_Mode_Stacks is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Game_Mode);

   type Game_State is tagged record
      Modes  : Game_Mode_Stacks.Vector;
      Player : RPG.Players.Player;
   end record;

   procedure Push_Mode(G : in out Game_State; Mode : Game_Mode);
   procedure Pop_Mode(G : in out Game_State);
   procedure Replace_Mode(G : in out Game_State; Mode : Game_Mode);
end RPG.Game;
