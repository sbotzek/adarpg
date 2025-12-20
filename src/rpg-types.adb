package body RPG.Types is
   procedure Replace(S : in out Game_Mode_Stack_T; M : Game_Mode) is
   begin
      S.Replace_Element(S.Last_Index, M);
   end Replace;
end RPG.Types;
