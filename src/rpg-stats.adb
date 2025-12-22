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
      Max_Value   : constant Natural := Natural(Creature_Maximum_HP.Value(HP.Maximum));
   begin
      if New_Current >= Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      else
         HP.Current := Creature_Current_HP(New_Current);
      end if;
   end Heal;

   procedure Full_Heal (HP : in Out Creature_HP) is
   begin
      HP.Current := Creature_Current_HP(Creature_Maximum_HP.Value(HP.Maximum));
   end Full_Heal;

   procedure Increase_Maximum_Natural (HP : in Out Creature_HP; Amount : Creature_Maximum_HP_Natural) is
      New_Natural : constant Natural := Natural(HP.Maximum.Natural) + Natural(Amount);
      New_Current : constant Natural := Natural(HP.Current) + Natural(Amount);
   begin
      HP.Maximum.Natural := Creature_Maximum_HP_Natural(New_Natural);
      HP.Current := Creature_Current_HP(New_Current);
   end Increase_Maximum_Natural;

   procedure Decrease_Maximum_Natural (HP : in Out Creature_HP; Amount : Creature_Maximum_HP_Natural) is
      Max_Value : Natural;
   begin
      if Amount >= HP.Maximum.Natural then
         HP.Maximum.Natural := 0;
      else
         HP.Maximum.Natural := HP.Maximum.Natural - Amount;
      end if;
      Max_Value := Natural(Creature_Maximum_HP.Value(HP.Maximum));
      if Natural(HP.Current) > Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      end if;
   end Decrease_Maximum_Natural;

   procedure Modify_Maximum (HP : in Out Creature_HP; Amount : Creature_Maximum_HP_Modified) is
      New_Modified : constant Integer := Integer(HP.Maximum.Modified) + Integer(Amount);
      Max_Value : Natural;
   begin
      if New_Modified < Integer(Creature_Maximum_HP_Modified'First) then
         HP.Maximum.Modified := Creature_Maximum_HP_Modified'First;
      elsif New_Modified > Integer(Creature_Maximum_HP_Modified'Last) then
         HP.Maximum.Modified := Creature_Maximum_HP_Modified'Last;
      else
         HP.Maximum.Modified := Creature_Maximum_HP_Modified(New_Modified);
      end if;
      Max_Value := Natural(Creature_Maximum_HP.Value(HP.Maximum));
      if Natural(HP.Current) > Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      end if;
   end Modify_Maximum;
end RPG.Stats;
