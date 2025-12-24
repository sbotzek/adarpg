package body RPG.Game is
   procedure Push_Mode(G : in out Game_State; Mode : Game_Mode) is
   begin
      G.Modes.Append(Mode);
   end Push_Mode;

   procedure Pop_Mode(G : in out Game_State) is
   begin
      G.Modes.Delete_Last;
   end Pop_Mode;

   procedure Replace_Mode(G : in out Game_State; Mode : Game_Mode) is
   begin
      G.Modes.Delete_Last;
      G.Modes.Append(Mode);
   end Replace_Mode;
end RPG.Game;
