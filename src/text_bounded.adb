package body Text_Bounded is
   function Create(Source : String) return T is
   begin
      if Source'Length < Min then
         raise Constraint_Error with "Must be at least" & Min'Image & " characters";
      end if;
      return Impl.To_Bounded_String(Source);
   end Create;

end Text_Bounded;
