with RPG.Creatures; use RPG.Creatures;

package RPG.Experience is

   type Experience_Points is new Natural;

   -- XP award levels based on encounter difficulty
   type XP_Award_Level is (Very_Easy, Easy, Average, Difficult, Extreme);

   function XP_To_Next_Level(Level : Creature_Level) return Experience_Points;
   function XP_For_Level(Level : Creature_Level) return Experience_Points;
   function Level_For_XP(XP : Experience_Points) return Creature_Level;

   -- Get XP award amount for a given difficulty level
   function XP_Award(Difficulty : XP_Award_Level) return Experience_Points;

end RPG.Experience;
