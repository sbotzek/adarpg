with RPG.Stat_Values;
with RPG.Primary_Stats;

generic
   Bonus_Stat : Primary_Stats.Primary_Stat_Id;
package RPG.Skill_Values is
   Bonus_Stat_Id : constant Primary_Stats.Primary_Stat_Id := Bonus_Stat;

   package Stats is new RPG.Stat_Values
     (Base_Min      => 0,
      Base_Max      => Natural'Last,
      Base_Default  => 0,
      Effective_Min => 0,
      Effective_Max => Natural'Last);

   type T is tagged private;

   subtype Base is Stats.Base;
   subtype Modifier is Stats.Modifier;
   subtype Effective is Stats.Effective;

   function To_Base (V : Integer) return Base renames Stats.To_Base;

   procedure Set_Base (S : in out T; Amount : Base);
   procedure Add_Base (S : in out T; Amount : Base);
   procedure Subtract_Base (S : in out T; Amount : Base);

   procedure Modify (S : in Out T; Amount : Modifier);

   function Value (S : T; PSV : Primary_Stats.Primary_Stat_Values)
     return Effective;

   function Value_To_Integer (S : T; PSV : Primary_Stats.Primary_Stat_Values)
     return Integer;

private
   type T is tagged record
      Stat : Stats.T;
   end record;

end RPG.Skill_Values;
