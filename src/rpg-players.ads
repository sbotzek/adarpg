with RPG.Creatures; use RPG.Creatures;
with RPG.Classes; use RPG.Classes;
with RPG.Experience; use RPG.Experience;

package RPG.Players is

   type Player is record
      Creature : RPG.Creatures.Creature;
      Class_Id : Optional_Class_Id := None;
      XP       : Experience_Points := 0;
   end record;

   procedure Award_XP(P : in out Player; Amount : Experience_Points);

end RPG.Players;
