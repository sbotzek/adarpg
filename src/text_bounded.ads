with Ada.Strings.Bounded;

generic
   Min: Natural;
   Max : Positive;
package Text_Bounded is
   package Impl is new Ada.Strings.Bounded.Generic_Bounded_Length(Max);

   Max_Length : constant Positive := Impl.Max_Length;
   Min_Length : constant Natural := Min;

   subtype T is Impl.Bounded_String;

   function Create(Source : String) return T;
   function To_String(Source : T) return String renames Impl.To_String;
end Text_Bounded;
