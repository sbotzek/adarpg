generic
   Base_Min : Integer;
   Base_Max : Integer;
   Base_Default : Integer;
   Effective_Min : Integer;
   Effective_Max : Integer;
package RPG.Stat is
   type T is tagged private;

   type Base_T is private;
   type Modifier_T is private;
   type Effective_T is private;

   function To_Base(V : Integer) return Base_T;

   procedure Set_Base(S : in out T; Amount : Base_T);
   procedure Add_Base(S : in out T; Amount : Base_T);
   procedure Subtract_Base(S : in out T; Amount : Base_T);

   procedure Modify(S : in out T; Amount : Modifier_T);

   function Value (S : T) return Effective_T;
   function Value_To_Integer (S : T) return Integer;
private
   type Base_T is new Integer range Base_Min .. Base_Max;
   type Modifier_T is new Integer;
   type Effective_T is new Integer range Effective_Min .. Effective_Max;

   type T is tagged record
      Base     : Base_T := Base_T(Base_Default);
      Modifier : Modifier_T := 0;
   end record;
end RPG.Stat;
