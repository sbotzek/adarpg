with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with RPG;

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

   procedure Run_Pick_Name(G : in out RPG.Game) is
      Input : String(1 .. 100);
      Last  : Natural;
   begin
      Put("Enter your name: ");
      Get_Line(Input, Last);
      declare
         Trimmed : constant String := Trim(Input(1 .. Last), Both);
      begin
         if Trimmed'Length < RPG.Creature_Name.Min_Length then
            Put_Line("Error: Name too short (min" & RPG.Creature_Name.Min_Length'Image & " characters) ");
            return;
         end if;
         if Trimmed'Length > RPG.Creature_Name.Max_Length then
            Put_Line("Error: Name too long (max" & RPG.Creature_Name.Max_Length'Image & " characters).");
            return;
         end if;
         if not Is_Valid_Name(Trimmed) then
            Put_Line("Error: Name must contain only letters.");
            return;
         end if;

         G.Player_Creature.Name := RPG.Creature_Name.Create(Trimmed);
         RPG.Replace(G.Modes, Pick_Class);

         Put_Line("Welcome, " & RPG.Creature_Name.To_String(G.Player_Creature.Name) & "!");
      end;
   end Run_Pick_Name;

   procedure Run_Pick_Class(G : in out RPG.Game) is
   begin
      Put_Line("Pick Class!");
      RPG.Replace(G.Modes, Main_Menu);
   end Run_Pick_class;
end RPG.Player_Creation;
