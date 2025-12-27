with RPG.Dice;

package body RPG.Creatures is
   use type Creature_Maximum_HP.Base;

   procedure Damage(HP : in out Creature_HP; Amount : Creature_Current_HP) is
   begin
      if Amount >= HP.Current then
         HP.Current := 0;
      else
         HP.Current := HP.Current - Amount;
      end if;
   end Damage;

   procedure Heal(HP : in out Creature_HP; Amount : Creature_Current_HP) is
      New_Current : constant Natural := Natural(HP.Current) + Natural(Amount);
      Max_Value   : constant Natural := Natural(HP.Maximum.Value_To_Integer);
   begin
      if New_Current >= Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      else
         HP.Current := Creature_Current_HP(New_Current);
      end if;
   end Heal;

   procedure Full_Heal(HP : in out Creature_HP) is
   begin
      HP.Current := Creature_Current_HP(HP.Maximum.Value_To_Integer);
   end Full_Heal;

   procedure Increase_Maximum_Base(HP : in out Creature_HP; Amount : Creature_Maximum_HP.Base) is
   begin
      HP.Maximum.Add_Base(Amount);
   end Increase_Maximum_Base;

   procedure Decrease_Maximum_Base(HP : in out Creature_HP; Amount : Creature_Maximum_HP.Base) is
      Max_Value : Integer;
   begin
      HP.Maximum.Subtract_Base(Amount);
      Max_Value := HP.Maximum.Value_To_Integer;
      if Integer(HP.Current) > Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      end if;
   end Decrease_Maximum_Base;

   procedure Modify_Maximum(HP : in out Creature_HP; Amount : Creature_Maximum_HP.Modifier) is
      Max_Value : Integer;
   begin
      HP.Maximum.Modify(Amount);

      Max_Value := HP.Maximum.Value_To_Integer;
      if Integer(HP.Current) > Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      end if;
   end Modify_Maximum;

   function Is_Dead(HP : Creature_HP) return Boolean is
   begin
      return HP.Current = 0;
   end Is_Dead;

   function Defense(S : Creature_Stats) return Integer is
   begin
      return 10 + S.Primary.Agility.Value_To_Integer / 2;
   end Defense;
end RPG.Creatures;
