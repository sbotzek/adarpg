with RPG.Stats;

package RPG.Primary_Stats is
   -- Primary Stats
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
end RPG.Primary_Stats;
