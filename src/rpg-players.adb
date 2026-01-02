with Ada.Text_IO; use Ada.Text_IO;

package body RPG.Players is

   procedure Award_XP(P : in out Player; Amount : Experience_Points) is
      New_Level : Creature_Level;
   begin
      P.XP := P.XP + Amount;
      Put_Line("You gained" & Experience_Points'Image(Amount) & " XP! (Total:" & Experience_Points'Image(P.XP) & ")");

      New_Level := Level_For_XP(P.XP);

      while P.Creature.Level < New_Level loop
         if P.Class_Id /= None then
            RPG.Classes.Level_Up(P.Creature, P.Class_Id);
         end if;
         Put_Line("LEVEL UP! You are now level" & Creature_Level'Image(P.Creature.Level) & "!");
      end loop;
   end Award_XP;

end RPG.Players;
