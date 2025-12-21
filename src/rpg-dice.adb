with Ada.Numerics.Discrete_Random;

package body RPG.Dice is
   package Random_Natural is new Ada.Numerics.Discrete_Random(Natural);
   Gen : Random_Natural.Generator;

   function Roll(D : Dieroll) return Integer is
      Total : Integer := D.Bonus;
   begin
      if D.Number = 0 or else D.Size = 0 then
         return Total;
      end if;

      for I in 1 .. D.Number loop
         Total := Total + Integer(Random_Natural.Random(Gen) mod D.Size) + 1;
      end loop;

      return Total;
   end Roll;

begin
   Random_Natural.Reset(Gen);
end RPG.Dice;
