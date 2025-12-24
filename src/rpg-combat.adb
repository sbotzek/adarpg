with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with RPG.Dice;
with RPG.Stats; use RPG.Stats;
with RPG.Classes;
with RPG.Types; use RPG.Types;
with RPG.Creatures; use RPG.Creatures;

package body RPG.Combat is
   package Random_Natural is new Ada.Numerics.Discrete_Random(Natural);
   Gen : Random_Natural.Generator;

   function Random_Fight(Fighter1 : in RPG.Creatures.Creature) return Fight is
      F : Fight;
      Enemy_Level : Creatures.Creature_Level;
   begin
      F.Fighter1 := Fighter1;

      -- Create a random enemy at similar level
      Enemy_Level := Fighter1.Level;
      if Enemy_Level = 0 then
         Enemy_Level := 1;
      end if;

      F.Fighter2.Name := Creatures.Creature_Name.Create("Goblin");
      RPG.Stats.Roll_Primary_Stats(F.Fighter2.Stats);
      RPG.Classes.Initialize_Creature(F.Fighter2, RPG.Types.Fighter, Enemy_Level);
      RPG.Stats.Full_Heal(F.Fighter2.Stats.HP);

      return F;
   end Random_Fight;

   function Make_Attack_Roll(Attacker : RPG.Creatures.Creature) return Natural is
      Attack_Roll : Integer;
   begin
      -- Base attack: 1d20 + vigor bonus
      Attack_Roll := RPG.Dice.Roll((Number => 1, Size => 20, Bonus => 0));
      Attack_Roll := Attack_Roll + Attacker.Stats.Vigor.Value_To_Integer / 2;
      if Attack_Roll < 0 then
         return 0;
      end if;
      return Natural(Attack_Roll);
   end Make_Attack_Roll;

   function Calculate_Damage(Attacker : RPG.Creatures.Creature) return Creature_Current_HP is
      Damage_Roll : Integer;
   begin
      -- Base damage: 1d6 + vigor bonus
      Damage_Roll := RPG.Dice.Roll((Number => 1, Size => 6, Bonus => 0));
      Damage_Roll := Damage_Roll + Attacker.Stats.Vigor.Value_To_Integer / 4;
      if Damage_Roll < 1 then
         Damage_Roll := 1;
      end if;
      return Creature_Current_HP(Damage_Roll);
   end Calculate_Damage;

   procedure Attack(Attacker : in Creature; Defender : in out Creature) is
      Attack_Roll : Natural;
      Defense_Value : Natural;
      Damage_Amount : Creature_Current_HP;
   begin
      Attack_Roll := Make_Attack_Roll(Attacker);
      Defense_Value := Defense(Defender.Stats);

      Put(Creatures.Creature_Name.To_String(Attacker.Name));
      Put(" attacks ");
      Put(Creatures.Creature_Name.To_String(Defender.Name));
      Put(" (");
      Put(Natural'Image(Attack_Roll));
      Put(" vs");
      Put(Natural'Image(Defense_Value));
      Put("): ");

      if Attack_Roll >= Defense_Value then
         Damage_Amount := Calculate_Damage(Attacker);
         RPG.Stats.Damage(Defender.Stats.HP, Damage_Amount);
         Put_Line("Hit for" & Creature_Current_HP'Image(Damage_Amount) & " damage!");
      else
         Put_Line("Miss!");
      end if;
   end Attack;

   procedure Run_Round(F : in Out Fight) is
   begin
      if not Is_Dead(F.Fighter1.Stats.HP) and not Is_Dead(F.Fighter2.Stats.HP) then
         Attack(F.Fighter1, F.Fighter2);
      end if;

      if not Is_Dead(F.Fighter1.Stats.HP) and not Is_Dead(F.Fighter2.Stats.HP) then
         Attack(F.Fighter2, F.Fighter1);
      end if;
   end Run_Round;

   procedure Run_Fight(F : in Out Fight) is
      Round_Num : Natural := 0;
   begin
      Put_Line("=== COMBAT BEGINS ===");
      Put(Creatures.Creature_Name.To_String(F.Fighter1.Name));
      Put(" (HP:" & Creature_Current_HP'Image(F.Fighter1.Stats.HP.Current) & ")");
      Put(" vs ");
      Put(Creatures.Creature_Name.To_String(F.Fighter2.Name));
      Put_Line(" (HP:" & Creature_Current_HP'Image(F.Fighter2.Stats.HP.Current) & ")");
      Put_Line("");

      while not Is_Dead(F.Fighter1.Stats.HP) and not Is_Dead(F.Fighter2.Stats.HP) loop
         Round_Num := Round_Num + 1;
         Put_Line("--- Round" & Natural'Image(Round_Num) & " ---");
         Run_Round(F);

         Put(Creatures.Creature_Name.To_String(F.Fighter1.Name));
         Put(" HP:" & Creature_Current_HP'Image(F.Fighter1.Stats.HP.Current));
         Put(" | ");
         Put(Creatures.Creature_Name.To_String(F.Fighter2.Name));
         Put_Line(" HP:" & Creature_Current_HP'Image(F.Fighter2.Stats.HP.Current));
         Put_Line("");
      end loop;

      Put_Line("=== COMBAT ENDS ===");
      if Is_Dead(F.Fighter2.Stats.HP) then
         Put(Creatures.Creature_Name.To_String(F.Fighter1.Name));
         Put_Line(" is victorious!");
      else
         Put(Creatures.Creature_Name.To_String(F.Fighter2.Name));
         Put_Line(" is victorious!");
      end if;
   end Run_Fight;

begin
   Random_Natural.Reset(Gen);
end RPG.Combat;
