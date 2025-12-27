with RPG.Stats;

package RPG.Primary_Stats is
   type Primary_Stat_Id is (Vigor_Id, Agility_Id, Intelligence_Id, Spirit_Id);

   package Vigor is new RPG.Stats
     (Base_Min      => 0,
      Base_Max      => 25,
      Base_Default  => 0,
      Effective_Min => 0,
      Effective_Max => 30);

   package Agility is new RPG.Stats
     (Base_Min      => 0,
      Base_Max      => 25,
      Base_Default  => 0,
      Effective_Min => 0,
      Effective_Max => 30);

   package Intelligence is new RPG.Stats
     (Base_Min      => 0,
      Base_Max      => 25,
      Base_Default  => 0,
      Effective_Min => 0,
      Effective_Max => 30);

   package Spirit is new RPG.Stats
     (Base_Min      => 0,
      Base_Max      => 25,
      Base_Default  => 0,
      Effective_Min => 0,
      Effective_Max => 30);

   type Primary_Stat_Values is record
      Vigor        : Primary_Stats.Vigor.T;
      Agility      : Primary_Stats.Agility.T;
      Intelligence : Primary_Stats.Intelligence.T;
      Spirit       : Primary_Stats.Spirit.T;
   end record;

   procedure Roll(S : in out Primary_Stat_Values);
end RPG.Primary_Stats;
