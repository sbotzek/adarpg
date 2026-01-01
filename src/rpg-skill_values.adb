package body RPG.Skill_Values is

   function Get_Bonus (PSV : Primary_Stats.Primary_Stat_Values) return Integer is
   begin
      case Bonus_Stat is
         when Primary_Stats.Vigor_Id =>
            return Primary_Stats.Vigor.To_Integer(PSV.Vigor.Value);
         when Primary_Stats.Agility_Id =>
            return Primary_Stats.Agility.To_Integer(PSV.Agility.Value);
         when Primary_Stats.Intelligence_Id =>
            return Primary_Stats.Intelligence.To_Integer(PSV.Intelligence.Value);
         when Primary_Stats.Spirit_Id =>
            return Primary_Stats.Spirit.To_Integer(PSV.Spirit.Value);
      end case;
   end Get_Bonus;

   procedure Set_Base (S : in Out T; Amount : Base) is
   begin
      S.Stat.Set_Base (Amount);
   end Set_Base;

   procedure Add_Base (S : in Out T; Amount : Base) is
   begin
      S.Stat.Add_Base (Amount);
   end Add_Base;

   procedure Subtract_Base (S : in Out T; Amount : Base) is
   begin
      S.Stat.Subtract_Base (Amount);
   end Subtract_Base;

   procedure Modify (S : in Out T; Amount : Modifier) is
   begin
      S.Stat.Modify (Amount);
   end Modify;

   function Value (S : T; PSV : Primary_Stats.Primary_Stat_Values)
     return Effective
   is
      Base_Value : constant Integer := Stats.To_Integer(S.Stat.Value);
      Bonus      : constant Integer := Get_Bonus (PSV);
      Total      : constant Integer := Base_Value + Bonus;
      Clamped    : Integer;
   begin
      if Total < 0 then
         Clamped := 0;
      elsif Total > Natural'Last then
         Clamped := Natural'Last;
      else
         Clamped := Total;
      end if;
      return Stats.To_Effective (Clamped);
   end Value;

   function To_Integer (E : Effective) return Integer is
   begin
      return Stats.To_Integer (Stats.Effective (E));
   end To_Integer;

end RPG.Skill_Values;
