with Ada.Text_IO; use Ada.Text_IO;
with RPG.Player_Creation;
with RPG.Main_Menu;
with RPG.Combat;
with RPG.Creatures;
with RPG.Experience; use RPG.Experience;
with RPG.Game; use RPG.Game;
with RPG.Players;

package body RPG is
   procedure Game_Loop(G : in out Game_State);

   procedure Run is
      G : Game_State;
   begin
      Put_Line("Hello World!");
      G.Push_Mode(Pick_Name);

      loop
         exit when G.Modes.Last_Element = Quit;
         Game_Loop(G);
      end loop;
   end Run;

   procedure Game_Loop(G : in out Game_State) is
   begin
      Put_Line("");
      case G.Modes.Last_Element is
         when Pick_Name =>
            RPG.Player_Creation.Run_Pick_Name(G);
         when Pick_Class =>
            RPG.Player_Creation.Run_Pick_Class(G);
         when Game.Main_Menu =>
            RPG.Main_Menu.Run(G);
         when Fight =>
            declare
               F : RPG.Combat.Fight := RPG.Combat.Random_Fight(G.Player.Creature);
            begin
               RPG.Combat.Run_Fight(F);
               G.Player.Creature := F.Fighter1;

               if RPG.Combat.Fighter1_Won(F) then
                  RPG.Players.Award_XP(G.Player, XP_Award(Average));
               end if;
            end;
            G.Pop_Mode;
         when Quit =>
            Put_Line("Goodbye!");
      end case;
   end Game_Loop;
end RPG;
