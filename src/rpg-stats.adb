with RPG.Dice;

package body RPG.Stats is
   Primary_Stat_Roll : constant RPG.Dice.Dieroll := (Number => 3, Size => 6, Bonus => 0);

   procedure Roll_Primary_Stats (S : in Out Creature_Stats) is
   begin
      S.Vigor.Natural := Vigor_Natural(RPG.Dice.Roll(Primary_Stat_Roll));
      S.Agility.Natural := Agility_Natural(RPG.Dice.Roll(Primary_Stat_Roll));
      S.Intelligence.Natural := Intelligence_Natural(RPG.Dice.Roll(Primary_Stat_Roll));
      S.Charisma.Natural := Charisma_Natural(RPG.Dice.Roll(Primary_Stat_Roll));
   end Roll_Primary_Stats;
   procedure Damage (HP : in out Creature_HP; Amount : Creature_Current_HP) is
   begin
      if Amount >= HP.Current then
         HP.Current := 0;
      else
         HP.Current := HP.Current - Amount;
      end if;
   end Damage;

   procedure Heal (HP : in Out Creature_HP; Amount : Creature_Current_HP) is
      New_Current : constant Natural := Natural(HP.Current) + Natural(Amount);
      Max_Value   : constant Natural := Natural(HP.Maximum);
   begin
      if New_Current >= Max_Value then
         HP.Current := Creature_Current_HP(HP.Maximum);
      else
         HP.Current := Creature_Current_HP(New_Current);
      end if;
   end Heal;

   procedure Full_Heal (HP : in Out Creature_HP) is
   begin
      HP.Current := Creature_Current_HP(HP.Maximum);
   end Full_Heal;

   procedure Increase_Maximum(HP : in Out Creature_HP; Amount : Creature_Maximum_HP) is
      New_Max     : constant Natural := Natural(HP.Maximum) + Natural(Amount);
      New_Current : constant Natural := Natural(HP.Current) + Natural(Amount);
   begin
      HP.Maximum := Creature_Maximum_HP(New_Max);
      HP.Current := Creature_Current_HP(New_Current);
   end Increase_Maximum;
end RPG.Stats;
