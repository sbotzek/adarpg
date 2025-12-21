package body RPG.Types is
   procedure Damage (HP : in out Creature_HP; Amount : Creature_Current_HP) is
   begin
      if Amount >= HP.Current then
         HP.Current := 0;
      else
         HP.Current := HP.Current - Amount;
      end if;
   end Damage;

   procedure Heal (HP : in out Creature_HP; Amount : Creature_Current_HP) is
      New_Current : constant Natural := Natural(HP.Current) + Natural(Amount);
      Max_Value   : constant Natural := Natural(HP.Maximum);
   begin
      if New_Current >= Max_Value then
         HP.Current := Creature_Current_HP(HP.Maximum);
      else
         HP.Current := Creature_Current_HP(New_Current);
      end if;
   end Heal;

   procedure Full_Heal (HP : in out Creature_HP) is
   begin
      HP.Current := Creature_Current_HP(HP.Maximum);
   end Full_Heal;

   procedure Increase_Maximum(HP : in out Creature_HP; Amount : Creature_Maximum_HP) is
      New_Max     : constant Natural := Natural(HP.Maximum) + Natural(Amount);
      New_Current : constant Natural := Natural(HP.Current) + Natural(Amount);
   begin
      HP.Maximum := Creature_Maximum_HP(New_Max);
      HP.Current := Creature_Current_HP(New_Current);
   end Increase_Maximum;
end RPG.Types;
