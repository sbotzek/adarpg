with Ada.Text_IO; use Ada.Text_IO;
with RPG.Player_Creation;
with RPG.Types; use RPG.Types;

package body RPG is
   procedure Game_Loop(G : in out Game);

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
      Put_Line("");
      case G.Modes.Last_Element is
         when Pick_Name =>
            RPG.Player_Creation.Run_Pick_Name(G);
         when Pick_Class =>
            RPG.Player_Creation.Run_Pick_Class(G);
         when Main_Menu =>
            Put_Line("Main Menu!");
            G.Modes.Delete_Last;
            G.Modes.Append(Quit);
         when Quit =>
            Put_Line("Goodbye!");
      end case;
   end Game_Loop;
end RPG;
