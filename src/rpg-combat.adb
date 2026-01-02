with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random;
with GNAT.Formatted_String; use GNAT.Formatted_String;
with RPG.Dice;
with RPG.Classes; use RPG.Classes;
with RPG.Creatures; use RPG.Creatures;
with RPG.Experience; use RPG.Experience;
with RPG.Players;
with RPG.Primary_Stats;
with RPG.Skills;

package body RPG.Combat is
   package Float_Random renames Ada.Numerics.Float_Random;

   Gen : Float_Random.Generator;

   function Random_Fight(Fighter1 : in Creature) return Fight is
      F : Fight;
      Enemy_Level : Creature_Level;
   begin
      F.Fighter1 := Fighter1;

      -- Create a random enemy at similar level
      Enemy_Level := Fighter1.Level;
      if Enemy_Level = 0 then
         Enemy_Level := 1;
      end if;

      F.Fighter2.Name := Creature_Name.Create("Goblin");
      F.Fighter2.Stats.Primary := RPG.Primary_Stats.Roll;
      RPG.Classes.Initialize_Creature(F.Fighter2, Fighter, Enemy_Level);
      Full_Heal(F.Fighter2.Stats.HP);

      return F;
   end Random_Fight;

   function Random_Hit_Roll return Hit_Roll is
   begin
      return Hit_Roll(Float_Random.Random(Gen));
   end Random_Hit_Roll;

   function Calculate_Damage(Attacker : Creature) return Creature_Current_HP is
      Damage_Roll : Integer;
   begin
      -- Base damage: 1d6 + vigor bonus
      Damage_Roll := RPG.Dice.Roll((Number => 1, Size => 6, Bonus => 0));
      Damage_Roll := Damage_Roll + Primary_Stats.Vigor.To_Integer(Attacker.Stats.Primary.Vigor.Value) / 4;
      if Damage_Roll < 1 then
         Damage_Roll := 1;
      end if;
      return Creature_Current_HP(Damage_Roll);
   end Calculate_Damage;

   procedure Attack(Attacker : in Creature; Defender : in Out Creature) is
      Attacker_Hit_Roll : Hit_Roll := Random_Hit_Roll;
      Defense_Value : Creature_Defense := Defender.Stats.Defense;
      Attack_Value : Integer := Skills.Timing.To_Integer(Attacker.Stats.Timing);
      Hit_Chance : Hit_Roll := Hit_Roll(Float(Attack_Value) / (0.001 + Float(Defense_Value)));
      Damage_Amount : Creature_Current_HP;
   begin
      Put(-(+"%s attacks %s (%d vs %d - chance %.2f, roll %.2f): "
            & Creature_Name.To_String(Attacker.Name)
            & Creature_Name.To_String(Defender.Name)
            & Attack_Value
            & Integer(Defense_Value)
            & Float(Hit_Chance)
            & Float(Attacker_Hit_Roll)));

      if Attacker_Hit_Roll <= Hit_Chance then
         Damage_Amount := Calculate_Damage(Attacker);
         Damage(Defender.Stats.HP, Damage_Amount);
         Put_Line(-(+"Hit for %d damage!" & Integer(Damage_Amount)));
      else
         Put_Line("Miss!");
      end if;
   end Attack;

   procedure Run_Round(F : in out Fight) is
   begin
      if not Is_Dead(F.Fighter1.Stats.HP) and not Is_Dead(F.Fighter2.Stats.HP) then
         Attack(F.Fighter1, F.Fighter2);
      end if;

      if not Is_Dead(F.Fighter1.Stats.HP) and not Is_Dead(F.Fighter2.Stats.HP) then
         Attack(F.Fighter2, F.Fighter1);
      end if;
   end Run_Round;

   procedure Run_Fight(F : in out Fight) is
      Round_Num : Natural := 0;
   begin
      Put_Line("=== COMBAT BEGINS ===");
      Put(Creature_Name.To_String(F.Fighter1.Name));
      Put(" (HP:" & Creature_Current_HP'Image(F.Fighter1.Stats.HP.Current) & ")");
      Put(" vs ");
      Put(Creature_Name.To_String(F.Fighter2.Name));
      Put_Line(" (HP:" & Creature_Current_HP'Image(F.Fighter2.Stats.HP.Current) & ")");
      Put_Line("");

      while not Is_Dead(F.Fighter1.Stats.HP) and not Is_Dead(F.Fighter2.Stats.HP) loop
         Round_Num := Round_Num + 1;
         Put_Line("--- Round" & Natural'Image(Round_Num) & " ---");
         Run_Round(F);

         Put(Creature_Name.To_String(F.Fighter1.Name));
         Put(" HP:" & Creature_Current_HP'Image(F.Fighter1.Stats.HP.Current));
         Put(" | ");
         Put(Creature_Name.To_String(F.Fighter2.Name));
         Put_Line(" HP:" & Creature_Current_HP'Image(F.Fighter2.Stats.HP.Current));
         Put_Line("");
      end loop;

      Put_Line("=== COMBAT ENDS ===");
      if Is_Dead(F.Fighter2.Stats.HP) then
         Put(Creature_Name.To_String(F.Fighter1.Name));
         Put_Line(" is victorious!");
      else
         Put(Creature_Name.To_String(F.Fighter2.Name));
         Put_Line(" is victorious!");
      end if;
   end Run_Fight;

   function Fighter1_Won(F : Fight) return Boolean is
   begin
      return Is_Dead(F.Fighter2.Stats.HP);
   end Fighter1_Won;

   procedure Run(G : in Out Game_State) is
      F : Fight := Random_Fight(G.Player.Creature);
   begin
      Run_Fight(F);
      G.Player.Creature := F.Fighter1;

      if Fighter1_Won(F) then
         RPG.Players.Award_XP(G.Player, XP_Award(Average));
      end if;

      G.Pop_Mode;
   end Run;

begin
   Float_Random.Reset(Gen);
end RPG.Combat;
