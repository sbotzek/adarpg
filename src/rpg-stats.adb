with RPG.Dice;

package body RPG.Stats is
   use type Creature_Maximum_HP.Base_T;
   Primary_Stat_Roll : constant RPG.Dice.Dieroll := (Number => 3, Size => 6, Bonus => 0);

   procedure Roll_Primary_Stats (S : in Out Creature_Stats) is
   begin
      S.Vigor.Base := Vigor.Base_T(RPG.Dice.Roll(Primary_Stat_Roll));
      S.Agility.Base := Agility.Base_T(RPG.Dice.Roll(Primary_Stat_Roll));
      S.Intelligence.Base := Intelligence.Base_T(RPG.Dice.Roll(Primary_Stat_Roll));
      S.Spirit.Base := Spirit.Base_T(RPG.Dice.Roll(Primary_Stat_Roll));
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
      Max_Value   : constant Natural := Natural(HP.Maximum.Value);
   begin
      if New_Current >= Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      else
         HP.Current := Creature_Current_HP(New_Current);
      end if;
   end Heal;

   procedure Full_Heal (HP : in Out Creature_HP) is
   begin
      HP.Current := Creature_Current_HP(HP.Maximum.Value);
   end Full_Heal;

   procedure Increase_Maximum_Base (HP : in Out Creature_HP; Amount : Creature_Maximum_HP.Base_T) is
      New_Base : constant Natural := Natural(HP.Maximum.Base) + Natural(Amount);
      New_Current : constant Natural := Natural(HP.Current) + Natural(Amount);
   begin
      HP.Maximum.Base := Creature_Maximum_HP.Base_T(New_Base);
      HP.Current := Creature_Current_HP(New_Current);
   end Increase_Maximum_Base;

   procedure Decrease_Maximum_Base (HP : in Out Creature_HP; Amount : Creature_Maximum_HP.Base_T) is
      Max_Value : Natural;
   begin
      if Amount >= HP.Maximum.Base then
         HP.Maximum.Base := 0;
      else
         HP.Maximum.Base := HP.Maximum.Base - Amount;
      end if;
      Max_Value := Natural(HP.Maximum.Value);
      if Natural(HP.Current) > Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      end if;
   end Decrease_Maximum_Base;

   procedure Modify_Maximum (HP : in Out Creature_HP; Amount : Creature_Maximum_HP.Modifier_T) is
      New_Modifier : constant Integer := Integer(HP.Maximum.Modifier) + Integer(Amount);
      Max_Value : Natural;
   begin
      if New_Modifier < Integer(Creature_Maximum_HP.Modifier_T'First) then
         HP.Maximum.Modifier := Creature_Maximum_HP.Modifier_T'First;
      elsif New_Modifier > Integer(Creature_Maximum_HP.Modifier_T'Last) then
         HP.Maximum.Modifier := Creature_Maximum_HP.Modifier_T'Last;
      else
         HP.Maximum.Modifier := Creature_Maximum_HP.Modifier_T(New_Modifier);
      end if;
      Max_Value := Natural(HP.Maximum.Value);
      if Natural(HP.Current) > Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      end if;
   end Modify_Maximum;

   function Defense (S : Creature_Stats) return Natural is
   begin
      return 10 + Natural(S.Agility.Value) / 2;
   end Defense;

   function Is_Dead (HP : Creature_HP) return Boolean is
   begin
      return HP.Current = 0;
   end Is_Dead;
end RPG.Stats;
