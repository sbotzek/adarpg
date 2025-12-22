generic
   type Base_Value is range <>;
   type Modifier_Value is range <>;
   type Effective_Value is range <>;
package RPG.Stat is
   type T is record
      Base     : Base_Value;
      Modifier : Modifier_Value;
   end record;

   function Value (S : T) return Effective_Value;
end RPG.Stat;
