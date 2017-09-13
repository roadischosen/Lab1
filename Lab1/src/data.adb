with Ada.Containers.Generic_Array_Sort;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded; use Ada.Strings.unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.IO_Exceptions;
package body Data is

   type Vector is array (Integer range <>) of Integer;
   type Matrix is array (0 .. Dimension-1, 0 .. Dimension-1) of Integer;
   subtype Rand_Range is Integer range -100 .. 100;

   Dim : constant String := Dimension'Img (2 .. Dimension'Img'Length);
   New_Line : Character := Character'Val(10);

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

   function To_String (Matr : in Matrix) return String is
      Repr : Unbounded_String;
      Count : Natural := 0;
   begin
      if Max_Output > 0 then
         Outer:
         for I in Matr'Range (1) loop
            for J in Matr'Range (2) loop
               Append (Repr, Integer'Image (Matr (I, J)) & " ");
               Count := Count + 1;
               exit Outer when Count >= Max_Output;
            end loop;
            Append (Repr, New_Line);
         end loop Outer;
         Append (Repr, New_Line);
      else
         for I in Matr'Range (1) loop
            for J in Matr'Range (2) loop
               Append (Repr, Integer'Image (Matr (I, J)) & " ");
            end loop;
            Append (Repr, New_Line);
         end loop;
      end if;
      return To_String (Repr);
   end To_String;

   function To_String (Vect : in Vector) return String is
      Repr : Unbounded_String;
      Count : Natural := 0;
   begin
      if Max_Output > 0 then
         for I in Vect'Range (1) loop
            Append (Repr, Integer'Image (Vect (I)) & " ");
            Count := Count + 1;
            exit when Count >= Max_Output;
         end loop;
      else
         for I in Vect'Range (1) loop
            Append (Repr, Integer'Image (Vect (I)) & " ");
         end loop;
      end if;
      return To_String (Repr);
   end To_String;

   procedure Get (File : in File_Type; Matr : out Matrix) is
      J : Integer;
   begin
      for I in Matr'Range (1) loop
         J := 0;
         while J <= Matr'Last (2) loop
            begin
               Int_IO.Get (File, Matr (I, J));
               J := J + 1;
            exception
               when Ada.IO_Exceptions.Data_Error =>
                  Skip_Line (File);
            end;
         end loop;
      end loop;
   end Get;

   procedure Get (File : in File_Type; Vect : out Vector) is
      J : Integer;
   begin
      J := 0;
      while J <= Vect'Last loop
         begin
            Int_IO.Get (File, Vect (J));
            J := J + 1;
         exception
            when Ada.IO_Exceptions.Data_Error =>
               Skip_Line (File);
         end;
      end loop;
   end Get;

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

   procedure Func1 (File_Name : in String) is
      A, B, C : Vector (0 .. Dimension-1);
      MA, MD : Matrix;
      File : File_Type;
   begin
      if Generate then
         Randomize (MA);
         Randomize (MD);
         Randomize (A);
         Randomize (B);
         Randomize (C);
      else
         Open (File, In_File, File_Name);

         Get (File, A);
         Get (File, B);
         Get (File, C);
         Get (File, MA);
         Get (File, MD);

         Close (File);
      end if;

      Put_line ("Task T1 results: " & 
                Integer'Image ((A * B) + C * (B * (MA * MD))));
   end Func1;

   procedure Func2 (File_Name : in String)is
      MK, MH, MF : Matrix;
      File : File_Type;
   begin
      if Generate then
         Randomize (MK);
         Randomize (MH);
         Randomize (MF);
      else
         Open (File, In_File, File_Name);

         Get (File, MK);
         Get (File, MH);
         Get (File, MF);

         Close (File);
      end if;

      Put_line ("Task T2 results:" & New_Line &
                To_String (Transpose ( MK ) * (MH * MF)));
   end Func2;

   procedure Func3 (File_Name : in String) is
      O, P: Vector (0 .. Dimension-1);
      MR, MS : Matrix;
      File : File_Type;
   begin
   if Generate then
         Randomize (MR);
         Randomize (MS);
         Randomize (O);
         Randomize (P);
      else
         Open (File, In_File, File_Name);

         Get (File, O);
         Get (File, P);
         Get (File, MR);
         Get (File, MS);

         Close (File);
      end if;

      O := O + P;
      Sort (O);

      Put_line ("Task T3 results:" & New_Line & 
                To_String (O * Transpose ( MR * MS )));
   end Func3;

end Data;
