with RPG.Types;

package RPG.Combat is
   type Fight is record
      Fighter1 : RPG.Types.Creature;
      Fighter2 : RPG.Types.Creature;
   end record;

   function Random_Fight(Fighter1 : in RPG.Types.Creature) return Fight;
   procedure Run_Fight(F : in out Fight);
   procedure Run_Round(F : in out Fight);
end RPG.Combat;
