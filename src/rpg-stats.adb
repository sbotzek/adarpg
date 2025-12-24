package body RPG.Stats is

   function To_Base (V : Integer) return Base_T is
   begin
      return Base_T(V);
   end To_Base;

   procedure Set_Base (S : in out T; Amount : Base_T) is
   begin
      S.Base := Amount;
   end Set_Base;

   procedure Add_Base (S : in out T; Amount : Base_T) is
      New_Value : constant Integer := Integer(S.Base) + Integer(Amount);
   begin
      S.Base := To_Base(New_Value);
   end Add_Base;

   procedure Subtract_Base (S : in Out T; Amount : Base_T) is
      New_Value : constant Integer := Integer(S.Base) - Integer(Amount);
   begin
      S.Base := To_Base(New_Value);
   end Subtract_Base;

   procedure Modify (S : in out T; Amount : Modifier_T) is
   begin
      S.Modifier := S.Modifier + Amount;
   end Modify;

   function Value (S : T) return Effective_T is
      Total : constant Integer := Integer(S.Base) + Integer(S.Modifier);
   begin
      if Total < Integer(Effective_T'First) then
         return Effective_T'First;
      elsif Total > Integer(Effective_T'Last) then
         return Effective_T'Last;
      else
         return Effective_T(Total);
      end if;
   end Value;

   function Value_To_Integer (S : T) return Integer is
   begin
      return Integer(S.Value);
   end Value_To_Integer;

end RPG.Stats;
