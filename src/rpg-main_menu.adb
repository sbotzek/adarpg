with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with RPG.Creatures;

package body RPG.Main_Menu is
   procedure Run(G : in Out Game_State) is
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
               RPG.Creatures.Full_Heal(G.Player_Creature.Stats.HP);
               G.Push_Mode(Fight);
            when 2 =>
               G.Replace_Mode(Quit);
            when others =>
               Put_Line("Please enter a valid number.");
         end case;
      end;
   end Run;
end RPG.Main_Menu;
