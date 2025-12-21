with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with RPG.Types; use RPG.Types;

package body RPG.Player_Creation is
   function Is_Valid_Name(S : String) return Boolean is
   begin
      for C of S loop
         if not Is_Letter(C) then
            return False;
         end if;
      end loop;
      return True;
   end Is_Valid_Name;

   procedure Run_Pick_Name(G : in out Game) is
   begin
      Put("Enter your name: ");
      declare
         Input   : constant String := Get_Line;
         Trimmed : constant String := Trim(Input, Both);
      begin
         if Trimmed'Length < Creature_Name.Min_Length then
            Put_Line("Error: Name too short (min" & Creature_Name.Min_Length'Image & " characters) ");
            return;
         end if;
         if Trimmed'Length > Creature_Name.Max_Length then
            Put_Line("Error: Name too long (max" & Creature_Name.Max_Length'Image & " characters).");
            return;
         end if;
         if not Is_Valid_Name(Trimmed) then
            Put_Line("Error: Name must contain only letters.");
            return;
         end if;

         G.Player_Creature.Name := Creature_Name.Create(Trimmed);
         G.Modes.Delete_Last;
         G.Modes.Append(Pick_Class);

         Put_Line("Welcome, " & Creature_Name.To_String(G.Player_Creature.Name) & "!");
      end;
   end Run_Pick_Name;

   procedure Run_Pick_Class(G : in out Game) is
   begin
      Put_Line("Pick Class!");
      G.Modes.Delete_Last;
      G.Modes.Append(Main_Menu);
   end Run_Pick_class;
end RPG.Player_Creation;
