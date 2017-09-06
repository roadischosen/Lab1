with Ada.Numerics.Real_Arrays;  use Ada.Numerics.Real_Arrays;
with Ada.Containers.Generic_Array_Sort;

package body Data is

   function Func1 return Float is
      A, B, C : Real_Vector ( 0 .. Dimension );
      MA, MD : Real_Matrix ( 0 .. Dimension, 0 .. Dimension);
   begin
      Randomize_Matrix ( MA );
      Randomize_Matrix ( MD );
      Randomize_Vector ( A );
      Randomize_Vector ( B );
      Randomize_Vector ( C );

      return (A * B) + (C * (B * (MA * MD)));
   end Func1;

   function Func2 return Real_Matrix is
      MK, MH, MF : Real_Matrix ( 0 .. Dimension, 0 .. Dimension);
   begin
      Randomize_Matrix ( MK );
      Randomize_Matrix ( MH );
      Randomize_Matrix ( MF );
      return Transpose ( MK ) * (MH * MF);
   end Func2;

   function Func3 return Real_Vector is
      O, P: Real_Vector ( 0 .. Dimension );
      MR, MS : Real_Matrix ( 0 .. Dimension, 0 .. Dimension);
   begin
      Randomize_Matrix ( MR );
      Randomize_Matrix ( MS );
      Randomize_Vector ( O );
      Randomize_Vector ( P );
      O := O + P;
      Sort ( O );
      return O * Transpose ( MR * MS );
   end Func3;

   procedure Randomize_Matrix ( Matrix : out Real_Matrix ) is
   begin
      for I in Matrix'Range (1) loop
         for J in Matrix'Range (2) loop
            Matrix (I, J) := Random(Gen);
         end loop;
      end loop;
   end Randomize_Matrix;

   procedure Randomize_Vector ( Vector : out Real_Vector ) is
   begin
      for I in Vector'Range (1) loop
         Vector (I) := Random (Gen);
      end loop;
   end Randomize_Vector;

   procedure Put_Matrix ( Matrix : in Real_Matrix; Max : in Natural ) is
      Count : Natural := 0;
   begin
      Outer:
      for I in Matrix'Range (1) loop
         for J in Matrix'Range (2) loop
            Put (Float'Image (Float (Matrix (I, J))));
            Count := Count + 1;
            exit Outer when Count >= Max;
         end loop;
         New_Line;
      end loop Outer;
      New_Line;
   end Put_Matrix;

   procedure Put_Vector ( Vector : in Real_Vector; Max : in Natural ) is
      Count : Natural := 0;
   begin
      for I in Vector'Range (1) loop
         Put (Float'Image (Float (Vector (I))));
         Count := Count + 1;
         exit when Count >= Max;
      end loop;
     New_Line;
   end Put_Vector;

begin
   Reset ( Gen );
end Data;
