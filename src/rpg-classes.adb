with RPG.Types; use RPG.Types;

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
end RPG.Classes;
