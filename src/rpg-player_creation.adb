with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with RPG.Classes; use RPG.Classes;
with RPG.Game; use RPG.Game;
with RPG.Creatures; use RPG.Creatures;

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

   procedure Run_Pick_Name(G : in out Game_State) is
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

   procedure Run_Pick_Class(G : in out Game_State) is
   begin
      Put_Line("Choose a class:");
      declare
         Index : Natural := 0;
      begin
         for Id in Class_Id loop
            Index := Index + 1;
            Put_Line(Index'Image & ". " & Class_Name.To_String(RPG.Classes.Find_Class(Id).Name));
         end loop;
      end;

      Put("Enter a number: ");
      declare
         Input   : constant String := Trim(Get_Line, Both);
         Choice  : Natural;
         Index   : Natural := 0;
      begin
         begin
            Choice := Natural'Value(Input);
         exception
            when Constraint_Error =>
               Put_Line("Please enter a valid number.");
               return;
         end;

         for Id in Class_Id loop
            Index := Index + 1;
            if Index = Choice then
               G.Player_Class_Id := Id;
               Roll_Primary_Stats(G.Player_Creature.Stats);
               RPG.Classes.Initialize_Creature(G.Player_Creature, Id, 1);
               G.Modes.Delete_Last;
               G.Modes.Append(Main_Menu);
               exit;
            end if;
         end loop;

         if G.Player_Class_Id = None then
            Put_Line("Invalid number.");
            return;
         end if;
      end;
   end Run_Pick_class;
end RPG.Player_Creation;
