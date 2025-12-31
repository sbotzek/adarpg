package body RPG.Stat_Values is

   function To_Base(V : Integer) return Base is
   begin
      return Base(V);
   end To_Base;

   function To_Effective(V : Integer) return Effective is
   begin
      return Effective(V);
   end To_Effective;

   procedure Set_Base(S : in out T; Amount : Base) is
   begin
      S.Base := Amount;
   end Set_Base;

   procedure Add_Base(S : in out T; Amount : Base) is
      New_Value : constant Integer := Integer(S.Base) + Integer(Amount);
   begin
      S.Base := To_Base(New_Value);
   end Add_Base;

   procedure Subtract_Base(S : in out T; Amount : Base) is
      New_Value : constant Integer := Integer(S.Base) - Integer(Amount);
   begin
      S.Base := To_Base(New_Value);
   end Subtract_Base;

   procedure Modify(S : in out T; Amount : Modifier) is
   begin
      S.Modifier := S.Modifier + Amount;
   end Modify;

   function Value(S : T) return Effective is
      Total : constant Integer := Integer(S.Base) + Integer(S.Modifier);
   begin
      if Total < Integer(Effective'First) then
         return Effective'First;
      elsif Total > Integer(Effective'Last) then
         return Effective'Last;
      else
         return Effective(Total);
      end if;
   end Value;

   function Value_To_Integer(S : T) return Integer is
   begin
      return Integer(S.Value);
   end Value_To_Integer;

   function Effective_To_Integer(E : Effective) return Integer is
   begin
      return Integer(E);
   end Effective_To_Integer;

end RPG.Stat_Values;
