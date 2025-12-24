with RPG.Types;
with RPG.Creatures;

package RPG.Combat is
   type Fight is record
      Fighter1 : RPG.Creatures.Creature;
      Fighter2 : RPG.Creatures.Creature;
   end record;

   function Random_Fight(Fighter1 : in RPG.Creatures.Creature) return Fight;
   procedure Run_Fight(F : in out Fight);
   procedure Run_Round(F : in out Fight);
end RPG.Combat;
