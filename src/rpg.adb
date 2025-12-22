with Ada.Text_IO; use Ada.Text_IO;
with RPG.Player_Creation;
with RPG.Combat;
with RPG.Stats;
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
            -- After main menu, start a fight
            RPG.Stats.Full_Heal(G.Player_Creature.Stats.HP);
            G.Modes.Delete_Last;
            G.Modes.Append(Fight);
         when Fight =>
            declare
               F : RPG.Combat.Fight := RPG.Combat.Random_Fight(G.Player_Creature);
            begin
               RPG.Combat.Run_Fight(F);
               -- Update player creature state after fight
               G.Player_Creature := F.Fighter1;
            end;
            G.Modes.Delete_Last;
            G.Modes.Append(Quit);
         when Quit =>
            Put_Line("Goodbye!");
      end case;
   end Game_Loop;
end RPG;
