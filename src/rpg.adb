with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with RPG.Player_Creation;
with RPG.Combat;
with RPG.Game; use RPG.Game;

package body RPG is
   procedure Game_Loop(G : in Out Game_State);
   procedure Run_Main_Menu_Game_Mode(G : in Out Game_State);

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
            RPG.Player_Creation.Run_Pick_Name_Game_Mode(G);
         when Pick_Class =>
            RPG.Player_Creation.Run_Pick_Class_Game_Mode(G);
         when Main_Menu =>
            Run_Main_Menu_Game_Mode(G);
         when Fight =>
            RPG.Combat.Run_Fight_Game_Mode(G);
         when Quit =>
            Put_Line("Goodbye!");
      end case;
   end Game_Loop;

   procedure Run_Main_Menu_Game_Mode(G : in Out Game_State) is
   begin
      Put_Line("=== Main Menu ===");
      Put_Line(" 1. Fight");
      Put_Line(" 2. Quit");
      Put("Enter choice: ");

      declare
         Input  : constant String := Trim(Get_Line, Both);
         Choice : Natural;
      begin
         begin
            Choice := Natural'Value(Input);
         exception
            when Constraint_Error =>
               Put_Line("Please enter a valid number.");
               return;
         end;

         case Choice is
            when 1 =>
               G.Push_Mode(Fight);
            when 2 =>
               G.Replace_Mode(Quit);
            when others =>
               Put_Line("Please enter a valid number.");
         end case;
      end;
   end Run_Main_Menu_Game_Mode;
end RPG;
