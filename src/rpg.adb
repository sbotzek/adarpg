with Ada.Text_IO; use Ada.Text_IO;
with RPG.Player_Creation;

package body RPG is
   procedure Game_Loop(G : in out Game);

   procedure Replace(S : in out Game_Mode_Stack_T; M : Game_Mode) is
   begin
      S.Replace_Element(S.Last_Index, M);
   end Replace;

   procedure Run is
      G : Game;
   begin
      Put_Line ("Hello World!");
      G.Modes.Append(Pick_Name);

      loop
         exit when G.Modes.Last_Element = Quit;
         Game_Loop(G);
      end loop;
   end Run;

   procedure Game_Loop(G : in out Game) is
   begin
      case G.Modes.Last_Element is
         when Pick_Name =>
            RPG.Player_Creation.Run_Pick_Name(G);
         when Pick_Class =>
            RPG.Player_Creation.Run_Pick_Class(G);
         when Main_Menu =>
            Put_Line("Main Menu!");
            RPG.Replace(G.Modes, Quit);
         when Quit =>
            Put_Line("Goodbye!");
      end case;
   end Game_Loop;
end RPG;
