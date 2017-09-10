with Ada.Containers.Generic_Array_Sort;
with Ada.Numerics.Discrete_Random;
with Ada.Text_IO; use Ada.Text_IO;
package body Data is

   type Vector is array (Integer range <>) of Integer;
   type Matrix is array (0 .. Dimension-1, 0 .. Dimension-1) of Integer;
   subtype Rand_Range is Integer range -100 .. 100;

   Dim : constant String := Dimension'Img (2 .. Dimension'Img'Length);

   procedure Sort is new Ada.Containers.Generic_Array_Sort
     (Index_Type   => Integer,
      Element_Type => Integer,
      Array_Type   => Vector);

   package Int_IO is new Integer_IO (Integer);

   package RandGen is
      package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
      Gen : Rand_Int.Generator;
      function Random return Rand_Range;
   end RandGen;

   package body RandGen is
   
      function Random return Rand_Range is
      begin
         return Rand_Int.Random (Gen);
      end Random;

   begin
      Rand_Int.Reset(Gen);
   end RandGen;

   procedure Randomize (Matr : out Matrix) is
   begin
      for I in Matr'Range (1) loop
         for J in Matr'Range (2) loop
            Matr (I, J) := RandGen.Random;
         end loop;
      end loop;
   end Randomize;

   procedure Randomize (Vect : out Vector) is
   begin
      for I in Vect'Range (1) loop
         Vect (I) := RandGen.Random;
      end loop;
   end Randomize;

   procedure Put (Matr : in Matrix) is
      Count : Natural := 0;
   begin
      if Max_Output > 0 then
         Outer:
         for I in Matr'Range (1) loop
            for J in Matr'Range (2) loop
               Put (Integer'Image (Matr (I, J)) & " ");
               Count := Count + 1;
               exit Outer when Count >= Max_Output;
            end loop;
            New_Line;
         end loop Outer;
         New_Line;
      else
         for I in Matr'Range (1) loop
            for J in Matr'Range (2) loop
               Put (Integer'Image (Matr (I, J)) & " ");
            end loop;
            New_Line;
         end loop;
      end if;
   end Put;

   procedure Get (Matr : out Matrix) is
   begin
      for I in Matr'Range (1) loop
         for J in Matr'Range (2) loop
            Int_IO.Get (Matr (I, J));
         end loop;
      end loop;
   end Get;

   procedure Get (Vect : out Vector) is
   begin
      for I in Vect'Range loop
         Int_IO.Get (Vect (I));
      end loop;
   end Get;

   procedure Put (Vect : in Vector) is
      Count : Natural := 0;
   begin
      if Max_Output > 0 then
         for I in Vect'Range (1) loop
            Put (Integer'Image (Vect (I)) & " ");
            Count := Count + 1;
            exit when Count >= Max_Output;
         end loop;
      else
         for I in Vect'Range (1) loop
            Put (Integer'Image (Vect (I)) & " ");
         end loop;
      end if;
      New_Line;
   end Put;

   function Transpose (X : in Matrix) return Matrix is
      Res : Matrix;      
   begin
      for I in X'Range (1) loop
         for J in X'Range (2) loop
            Res (J, I) := X (I, J);
         end loop;
      end loop;
      return Res;
   end Transpose;

   function "*" (Left : in Vector; Right : in Matrix)
      return Vector is
      Res : Vector (Left'Range);
      Prod : Integer;
   begin
      for I in Right'Range (2) loop
         Prod := 0;
         for J in Left'Range loop
            Prod := Prod + Left (J) * Right (J, I);
         end loop;
         Res (I) := Prod;
      end loop;
      return Res;
   end "*";

   function "+" (Left, Right : in Vector) return Vector is
      Res : Vector (Left'Range);
   begin
      for I in Left'Range loop
         Res (I) := Left (I) + Right (I);
      end loop;
      return Res;
   end "+";

   function "*" (Left, Right : in Vector) return Integer is
      Res : Integer := 0;
   begin
      for I in Left'Range loop
         Res := Res + Left (I) * Right (I);
      end loop;
      return Res;
   end "*";

   function "*" (Left, Right : in Matrix) return Matrix is
      Res : Matrix;
      Prod : Integer;
   begin
      for I in Left'Range (1) loop
         for J in Right'Range (2) loop
            Prod := 0;
            for K in Right'Range (1) loop
               Prod := Prod + Left (I, K) * Right (K, J);
            end loop;
            Res (I, J) := Prod;
         end loop;
      end loop;
      return Res;
   end "*";

   function Type_Smth (Struct_Name : in String;
                       Is_Matrix   : in Boolean := False) return String
   is ("Type " &
       (if Is_Matrix then "matrix " else "vector ") & 
       Struct_Name &
       " (" &  Dim & 
       (if Is_Matrix then "x" & Dim else "") & 
       "):");

   procedure Func1 is
      A, B, C : Vector (0 .. Dimension-1);
      MA, MD : Matrix;
   begin
      if Generate then
         Randomize (MA);
         Randomize (MD);
         Randomize (A);
         Randomize (B);
         Randomize (C);
      else
         Put_line (Type_Smth("A"));
         Get (A);

         Put_line (Type_Smth("B"));
         Get (B);

         Put_line (Type_Smth("C"));
         Get (C);

         Put_line (Type_Smth("MA", Is_Matrix => True));
         Get (MA);

         Put_line (Type_Smth("MD", Is_Matrix => True));
         Get (MD);
      end if;
      Put_line ("Task T1 results: " & Integer'Image ((A * B) + C * (B * (MA * MD))));
   end Func1;

   procedure Func2 is
      MK, MH, MF : Matrix;
   begin
      if Generate then
         Randomize (MK);
         Randomize (MH);
         Randomize (MF);
      else
         Put_line (Type_Smth("MK", Is_Matrix => True));
         Get (MK);

         Put_line (Type_Smth("MH", Is_Matrix => True));
         Get (MH);

         Put_line (Type_Smth("MF", Is_Matrix => True));
         Get (MF);
      end if;
      Put_line ("Task T2 results:");
      Put (Transpose ( MK ) * (MH * MF));
   end Func2;

   procedure Func3 is
      O, P: Vector (0 .. Dimension-1);
      MR, MS : Matrix;
   begin
   if Generate then
         Randomize (MR);
         Randomize (MS);
         Randomize (O);
         Randomize (P);
      else
         Put_line (Type_Smth("O"));
         Get (O);

         Put_line (Type_Smth("P"));
         Get (P);

         Put_line (Type_Smth("MR", Is_Matrix => True));
         Get (MR);

         Put_line (Type_Smth("MS", Is_Matrix => True));
         Get (MS);
      end if;

      O := O + P;
      Sort (O);

      Put_line ("Task T3 results:");
      Put (O * Transpose ( MR * MS ));
   end Func3;

begin
   null;
end Data;
