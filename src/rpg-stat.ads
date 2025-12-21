generic
   type Natural_Value is range <>;
   type Modified_Value is range <>;
   type Effective_Value is range <>;
package RPG.Stat is
   type T is record
      Natural  : Natural_Value := 0;
      Modified : Modified_Value := 0;
   end record;

   function Value (S : T) return Effective_Value;
end RPG.Stat;
