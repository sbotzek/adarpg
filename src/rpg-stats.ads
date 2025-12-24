generic
   Base_Min : Integer;
   Base_Max : Integer;
   Base_Default : Integer;
   Effective_Min : Integer;
   Effective_Max : Integer;
package RPG.Stats is
   type T is tagged private;

   type Base is private;
   type Modifier is private;
   type Effective is private;

   function To_Base(V : Integer) return Base;

   procedure Set_Base(S : in out T; Amount : Base);
   procedure Add_Base(S : in Out T; Amount : Base);
   procedure Subtract_Base(S : in Out T; Amount : Base);

   procedure Modify(S : in Out T; Amount : Modifier);

   function Value (S : T) return Effective;
   function Value_To_Integer (S : T) return Integer;
private
   type Base is new Integer range Base_Min .. Base_Max;
   type Modifier is new Integer;
   type Effective is new Integer range Effective_Min .. Effective_Max;

   type T is tagged record
      Base     : Stats.Base := Stats.Base(Base_Default);
      Modifier : Stats.Modifier := 0;
   end record;
end RPG.Stats;
