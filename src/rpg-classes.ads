with RPG.Types; use RPG.Types;
with RPG.Creatures; use RPG.Creatures;

package RPG.Classes is
   function Find_Class(Id : Class_Id) return Class;
   procedure Level_Up(C : in out Creature; Id : Class_Id);
   procedure Initialize_Creature(C : in Out Creature; Id : Class_Id; Level : Creature_Level);
end RPG.Classes;
