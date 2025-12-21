package RPG.Dice is
   type Dieroll is record
      Number : Natural;
      Size : Natural;
      Bonus : Integer := 0;
   end record;

   function Roll(D : Dieroll) return Integer;
end RPG.Dice;
