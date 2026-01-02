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
      Max_Value   : constant Natural := Natural(Creature_Maximum_HP.To_Integer(HP.Maximum.Value));
   begin
      if New_Current >= Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      else
         HP.Current := Creature_Current_HP(New_Current);
      end if;
   end Heal;

   procedure Full_Heal(HP : in out Creature_HP) is
   begin
      HP.Current := Creature_Current_HP(Creature_Maximum_HP.To_Integer(HP.Maximum.Value));
   end Full_Heal;

   procedure Increase_Maximum_Base(HP : in out Creature_HP; Amount : Creature_Maximum_HP.Base) is
   begin
      HP.Maximum.Add_Base(Amount);
   end Increase_Maximum_Base;

   procedure Decrease_Maximum_Base(HP : in out Creature_HP; Amount : Creature_Maximum_HP.Base) is
      Max_Value : Integer;
   begin
      HP.Maximum.Subtract_Base(Amount);
      Max_Value := Creature_Maximum_HP.To_Integer(HP.Maximum.Value);
      if Integer(HP.Current) > Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      end if;
   end Decrease_Maximum_Base;

   procedure Modify_Maximum(HP : in out Creature_HP; Amount : Creature_Maximum_HP.Modifier) is
      Max_Value : Integer;
   begin
      HP.Maximum.Modify(Amount);

      Max_Value := Creature_Maximum_HP.To_Integer(HP.Maximum.Value);
      if Integer(HP.Current) > Max_Value then
         HP.Current := Creature_Current_HP(Max_Value);
      end if;
   end Modify_Maximum;

   function Is_Dead(HP : Creature_HP) return Boolean is
   begin
      return HP.Current = 0;
   end Is_Dead;

   function Defense(S : Creature_Stats) return Creature_Defense is
   begin
      return Creature_Defense(Skills.Reflex.To_Integer(S.Reflex)
                            + Skills.Anticipation.To_Integer(S.Anticipation));
   end Defense;

   function Toughness(S : Creature_Stats) return Skills.Toughness.Effective is
   begin
      return S.Skills.Toughness.Value(S.Primary);
   end Toughness;

   function Strength(S : Creature_Stats) return Skills.Strength.Effective is
   begin
      return S.Skills.Strength.Value(S.Primary);
   end Strength;

   function Reflex(S : Creature_Stats) return Skills.Reflex.Effective is
   begin
      return S.Skills.Reflex.Value(S.Primary);
   end Reflex;

   function Timing(S : Creature_Stats) return Skills.Timing.Effective is
   begin
      return S.Skills.Timing.Value(S.Primary);
   end Timing;

   function Anticipation(S : Creature_Stats) return Skills.Anticipation.Effective is
   begin
      return S.Skills.Anticipation.Value(S.Primary);
   end Anticipation;

   function Deception(S : Creature_Stats) return Skills.Deception.Effective is
   begin
      return S.Skills.Deception.Value(S.Primary);
   end Deception;

   function Willpower(S : Creature_Stats) return Skills.Willpower.Effective is
   begin
      return S.Skills.Willpower.Value(S.Primary);
   end Willpower;

   function Domination(S : Creature_Stats) return Skills.Domination.Effective is
   begin
      return S.Skills.Domination.Value(S.Primary);
   end Domination;

end RPG.Creatures;
