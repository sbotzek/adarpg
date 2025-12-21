with RPG.Types; use RPG.Types;

package body RPG.Classes is
   Classes : constant array (Class_Id) of Class :=
     (Cleric  => (Id => Cleric,  Name => Class_Name.Create("Cleric")),
      Fighter => (Id => Fighter, Name => Class_Name.Create("Fighter")),
      Thief   => (Id => Thief,   Name => Class_Name.Create("Thief")),
      Wizard  => (Id => Wizard,  Name => Class_Name.Create("Wizard")));

   function Find_Class(Id : Class_Id) return Class is
   begin
      return Classes(Id);
   end Find_Class;
end RPG.Classes;
