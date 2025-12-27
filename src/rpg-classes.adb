with RPG.Dice;
with RPG.Creatures; use RPG.Creatures;

package body RPG.Classes is
   Classes : constant array (Class_Id) of Class :=
     (Cleric  => (Id => Cleric,
                 Name => Class_Name.Create("Cleric"),
                 HP_Per_Level => (Number => 1, Size => 8, Bonus => 0)),
      Fighter => (Id => Fighter,
                 Name => Class_Name.Create("Fighter"),
                 HP_Per_Level => (Number => 1, Size => 10, Bonus => 0)),
      Thief   => (Id => Thief,
                 Name => Class_Name.Create("Thief"),
                 HP_Per_Level => (Number => 1, Size => 6, Bonus => 0)),
      Wizard  => (Id => Wizard,
                 Name => Class_Name.Create("Wizard"),
                 HP_Per_Level => (Number => 1, Size => 4, Bonus => 0)));

   function Find_Class(Id : Class_Id) return Class is
   begin
      return Classes(Id);
   end Find_Class;

   procedure Level_Up(C : in out Creature; Id : Class_Id) is
      C_Class : constant Class := Find_Class(Id);
   begin
      C.Level := C.Level + 1;
      declare
        HP_Gain : Integer := RPG.Dice.Roll(C_Class.HP_Per_Level);
      begin
         if HP_Gain > 0 then
            Increase_Maximum_Base(C.Stats.HP, Creature_Maximum_HP.To_Base(HP_Gain));
         end if;
      end;
   end Level_Up;

   procedure Initialize_Creature(C : in out Creature; Id : Class_Id; Level : Creature_Level) is
   begin
      C.Level := 0;
      C.Stats.HP := (others => <>);
      for I in 1 .. Level loop
         Level_Up(C, Id);
      end loop;
   end Initialize_Creature;
end RPG.Classes;
