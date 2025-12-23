package body RPG.Stat is
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
end RPG.Stat;
