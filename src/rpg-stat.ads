generic
   Base_Min : Integer;
   Base_Max : Integer;
   Base_Default : Integer;
   Effective_Min : Integer;
   Effective_Max : Integer;
package RPG.Stat is
   type Base_T is new Integer range Base_Min .. Base_Max;
   type Modifier_T is new Integer;
   type Effective_T is new Integer range Effective_Min .. Effective_Max;

   type T is tagged record
      Base     : Base_T := Base_T(Base_Default);
      Modifier : Modifier_T := 0;
   end record;

   function Value (S : T) return Effective_T;
end RPG.Stat;
