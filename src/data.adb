with Ada.Containers.Generic_Array_Sort;
with Ada.Numerics.discrete_Random;

package body Data is

   type Vector is array (0 .. Dimension) of Integer;
   type Matrix is array (0 .. Dimension, 0 .. Dimension) of Integer;
   subtype Rand_Range is Integer range -100 .. 100;

   procedure Sort is new Ada.Containers.Generic_Array_Sort
     (Index_Type   => Integer,
      Element_Type => Integer,
      Array_Type   => Vector);
   
   package RandGen is
      function Random return Rand_Range;
   end RandGen;

   package body RandGen is

      package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);

      Gen : Rand_Int.Generator;
   
      function Random return Rand_Range is
      begin
         return Rand_Int.Random (Gen);
      end Random;

   begin
      Rand_Int.Reset(gen);
   end RandGen;

   use RandGen.Random;

   procedure Randomize (Matr : out Matrix) is
   begin
      for I in Matr'Range (1) loop
         for J in Matr'Range (2) loop
            Matr (I, J) := Random;
         end loop;
      end loop;
   end Randomize;

   procedure Randomize (Vect : out Vector) is
   begin
      for I in Vect'Range (1) loop
         Vect (I) := Random;
      end loop;
   end Randomize;

   procedure Put (Matr : in Matrix) is
      Count : Natural := 0;
   begin
      if Max_Output > 0 then
         Outer:
         for I in Matr'Range (1) loop
            for J in Matr'Range (2) loop
               Put (Integer'Image (Matr (I, J)));
               Count := Count + 1;
               exit Outer when Count >= Max_Output;
            end loop;
            New_Line;
         end loop Outer;
         New_Line;
      else
         for I in Matr'Range (1) loop
            for J in Matr'Range (2) loop
               Put (Integer'Image (Matr (I, J)));
            end loop;
            New_Line;
         end loop;
      end if;
   end Put;

   procedure Put (Vect : in Vector) is
      Count : Natural := 0;
   begin
      if Max_Output > 0 then
         for I in Vect'Range (1) loop
            Put (Integer'Image (Vect (I)));
            Count := Count + 1;
            exit when Count >= Max_Output;
         end loop;
      else
         for I in Vect'Range (1) loop
            Put (Integer'Image (Vect (I)));
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

   function "*" (Left : Vector; Right : Matrix)
      return Vector is
      Res : Vector;
      Prod : Integer;
   begin
      for I in Right'Range (2) loop
         Prod := 0;
         for J in Left'Range loop
            Prod := Prod + Left (J) * Right (J, I);
         end loop;
         Res (I) := Prod;
      end loop;
   end "*";

   function "+" (Left, Right : Vector) return Vector is
      Res : Vector;
   begin
      for I in X'Range loop
         Res (I) := Left (I) + Right (I);
      end loop;
      return Res;
   end "+";

   function "*" (Left, Right : Vector) return Integer is
      Res : Integer := 0;
   begin
      for I in X'Range loop
         Res := Res + Left (I) * Right (I);
      end loop;
      return Res;
   end "*";

   function "*" (Left, Right : Matrix) return Matrix is
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

   procedure Func1 is
      A, B, C : Vector;
      MA, MD : Matrix;
   begin
      Randomize ( MA );
      Randomize ( MD );
      Randomize ( A );
      Randomize ( B );
      Randomize ( C );

      return (A * B) + (C * (B * (MA * MD)));
   end Func1;

   function Func2 return Matrix is
      MK, MH, MF : Matrix ( 0 .. Dimension, 0 .. Dimension);
   begin
      Randomize_Matrix ( MK );
      Randomize_Matrix ( MH );
      Randomize_Matrix ( MF );
      return Transpose ( MK ) * (MH * MF);
   end Func2;

   function Func3 return Vector is
      O, P: Vector ( 0 .. Dimension );
      MR, MS : Matrix ( 0 .. Dimension, 0 .. Dimension);
   begin
      Randomize_Matrix ( MR );
      Randomize_Matrix ( MS );
      Randomize_Vector ( O );
      Randomize_Vector ( P );
      O := O + P;
      Sort ( O );
      return O * Transpose ( MR * MS );
   end Func3;

begin
   Reset ( Gen );
end Data;
