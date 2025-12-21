package body RPG.Stat is
   function Value (S : T) return Effective_Value is
      Total : constant Integer := Integer(S.Natural) + Integer(S.Modified);
   begin
      if Total < Integer(Effective_Value'First) then
         return Effective_Value'First;
      elsif Total > Integer(Effective_Value'Last) then
         return Effective_Value'Last;
      else
         return Effective_Value(Total);
      end if;
   end Value;
end RPG.Stat;
