--------------------------------------------------
-- Лабораторна робота N1
-- Процеси в мові Ada. Задачі.
-- Виконав: Земін В.М. 
-- Група: ІО-53
--------------------------------------------------
with Ada.Containers.Generic_Array_Sort;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded; use Ada.Strings.unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.IO_Exceptions;

package body Data is

   subtype Rand_Range is Integer range -100 .. 100;

   Dim : constant String := Dimension'Img (2 .. Dimension'Img'Length);
   New_Line : Character := Character'Val(10);

   procedure Sort is new Ada.Containers.Generic_Array_Sort
     (Index_Type   => Integer,
      Element_Type => Integer,
      Array_Type   => Vector);

   package Int_IO is new Integer_IO (Integer);

   --------------------------------------------------
   -- Пакет для генерації випадкових цілих чисел
   --------------------------------------------------
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

   --------------------------------------------------
   -- Процедури заповнення матриць і векторів
   -- випадковими значеннями
   --------------------------------------------------
   procedure Randomize (Matr : out Matrix) is
   begin
      for I in Matr'Range (1) loop
         for J in Matr'Range (2) loop
            Matr (I, J) := RandGen.Random;
         end loop;
      end loop;
   end Randomize;

   --------------------------------------------------
   procedure Randomize (Vect : out Vector) is
   begin
      for I in Vect'Range (1) loop
         Vect (I) := RandGen.Random;
      end loop;
   end Randomize;

   --------------------------------------------------
   -- Рядкові представлення векторів і матриць
   --------------------------------------------------
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

   --------------------------------------------------
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

   --------------------------------------------------
   -- Процедури введення даних із файлу
   -- в матриці й вектори
   --------------------------------------------------
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

   --------------------------------------------------
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

   --------------------------------------------------
   -- Матричні та векторні операції
   --------------------------------------------------
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

   --------------------------------------------------
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

   --------------------------------------------------
   function "+" (Left, Right : in Vector) return Vector is
      Res : Vector (Left'Range);
   begin
      for I in Left'Range loop
         Res (I) := Left (I) + Right (I);
      end loop;
      return Res;
   end "+";

   --------------------------------------------------
   function "*" (Left, Right : in Vector) return Integer is
      Res : Integer := 0;
   begin
      for I in Left'Range loop
         Res := Res + Left (I) * Right (I);
      end loop;
      return Res;
   end "*";

   --------------------------------------------------
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

   --------------------------------------------------
   -- Основні процедури задач
   --------------------------------------------------
   function Func1 (A, B, C : in Vector; MA, MD : in Matrix) return Integer is
      (A * B) + C * (B * (MA * MD));
   --------------------------------------------------
   function Func2 (MK, MH, MF : in Matrix) return Matrix is
      (Transpose ( MK ) * (MH * MF));
   --------------------------------------------------
   function Func3 (O, P : in Vector; MR, MS : in Matrix) return Vector is
      Temp : Vector (0..Dimension-1);
   begin
      Temp := O + P;
      Sort (Temp);
      return Temp * Transpose ( MR * MS );
   end Func3;

end Data;
