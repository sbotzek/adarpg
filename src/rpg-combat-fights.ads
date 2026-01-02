with RPG.Creatures; use RPG.Creatures;
with RPG.Game; use RPG.Game;

package RPG.Combat.Fights is
   procedure Run_Fight_Game_Mode(G : in out Game_State);
   type Hit_Roll is new Float;

   type Fight is record
      Fighter1 : Creature;
      Fighter2 : Creature;
   end record;

   function Random_Fight(Fighter1 : in Creature) return Fight;
   procedure Run_Fight(F : in out Fight);
   procedure Run_Round(F : in out Fight);

   function Fighter1_Won(F : Fight) return Boolean;
end RPG.Combat.Fights;
