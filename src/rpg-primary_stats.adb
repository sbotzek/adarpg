with RPG.Dice;

package body RPG.Primary_Stats is
   Primary_Stat_Dieroll : constant RPG.Dice.Dieroll := (Number => 3, Size => 6, Bonus => 0);

   procedure Roll(S : in out Primary_Stat_Values) is
   begin
      S.Vigor.Set_Base(Primary_Stats.Vigor.To_Base(RPG.Dice.Roll(Primary_Stat_Dieroll)));
      S.Agility.Set_Base(Primary_Stats.Agility.To_Base(RPG.Dice.Roll(Primary_Stat_Dieroll)));
      S.Intelligence.Set_Base(Primary_Stats.Intelligence.To_Base(RPG.Dice.Roll(Primary_Stat_Dieroll)));
      S.Spirit.Set_Base(Primary_Stats.Spirit.To_Base(RPG.Dice.Roll(Primary_Stat_Dieroll)));
   end Roll;
end RPG.Primary_Stats;
