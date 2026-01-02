package body RPG.Experience is

   -- XP required to advance from level N to level N+1
   -- Index 0 = XP to go from level 0 to level 1 (10 XP)
   -- Index 20 = max level, no advancement
   XP_Table : constant array (Creature_Level range 0 .. 20) of Experience_Points :=
     (0  => 5,    -- Level 0 -> 1
      1  => 5,    -- Level 1 -> 2
      2  => 25,    -- Level 2 -> 3
      3  => 25,    -- Level 3 -> 4
      4  => 50,    -- Level 4 -> 5
      5  => 50,    -- Level 5 -> 6
      6  => 100,   -- Level 6 -> 7
      7  => 100,   -- Level 7 -> 8
      8  => 150,   -- Level 8 -> 9
      9  => 150,   -- Level 9 -> 10
      10 => 200,   -- Level 10 -> 11
      11 => 200,   -- Level 11 -> 12
      12 => 275,   -- Level 12 -> 13
      13 => 275,   -- Level 13 -> 14
      14 => 350,   -- Level 14 -> 15
      15 => 350,   -- Level 15 -> 16
      16 => 450,   -- Level 16 -> 17
      17 => 450,   -- Level 17 -> 18
      18 => 575,   -- Level 18 -> 19
      19 => 575,   -- Level 19 -> 20
      20 => 0);    -- Max level

   function XP_To_Next_Level(Level : Creature_Level) return Experience_Points is
   begin
      return XP_Table(Level);
   end XP_To_Next_Level;

   function XP_For_Level(Level : Creature_Level) return Experience_Points is
      Total : Experience_Points := 0;
   begin
      if Level = 0 then
         return 0;
      end if;

      for L in Creature_Level range 0 .. Level - 1 loop
         Total := Total + XP_Table(L);
      end loop;

      return Total;
   end XP_For_Level;

   function Level_For_XP(XP : Experience_Points) return Creature_Level is
      Cumulative : Experience_Points := 0;
   begin
      for L in Creature_Level range 0 .. 20 loop
         if XP_Table(L) = 0 then
            -- Max level reached
            return L;
         end if;

         Cumulative := Cumulative + XP_Table(L);
         if XP < Cumulative then
            return L;
         end if;
      end loop;

      return 20;
   end Level_For_XP;

   -- XP awards by difficulty: 0, 1, 2, 3, 4
   XP_Award_Table : constant array (XP_Award_Level) of Experience_Points :=
     (Very_Easy => 0,
      Easy      => 1,
      Average   => 2,
      Difficult => 3,
      Extreme   => 4);

   function XP_Award(Difficulty : XP_Award_Level) return Experience_Points is
   begin
      return XP_Award_Table(Difficulty);
   end XP_Award;

end RPG.Experience;
