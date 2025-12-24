with RPG.Game;
with RPG.Creatures; use RPG.Creatures;

package RPG.Combat is
   type Fight is record
      Fighter1 : Creature;
      Fighter2 : Creature;
   end record;

   function Random_Fight(Fighter1 : in Creature) return Fight;
   procedure Run_Fight(F : in out Fight);
   procedure Run_Round(F : in out Fight);
end RPG.Combat;
