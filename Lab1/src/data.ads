--------------------------------------------------
-- Лабораторна робота N1
-- Процеси в мові Ada. Задачі.
-- Виконав: Земін В.М. 
-- Група: ІО-53
--------------------------------------------------
with Ada.Text_IO; use Ada.Text_IO;
generic
   Dimension  : in Integer;
   Max_Output : in Natural := 5;

package Data is

   type Vector is array (Integer range <>) of Integer;
   type Matrix is array (0 .. Dimension-1, 0 .. Dimension-1) of Integer;
   
   function Func1 (A, B, C : in Vector; MA, MD : in Matrix) return Integer;
   function Func2 (MK, MH, MF : in Matrix) return Matrix;
   function Func3 (O, P : in Vector; MR, MS : in Matrix) return Vector;

   procedure Randomize (Matr : out Matrix);
   procedure Randomize (Vect : out Vector);

   procedure Get (File : in File_Type; Matr : out Matrix);
   procedure Get (File : in File_Type; Vect : out Vector);


   function To_String (Matr : in Matrix) return String;
   function To_String (Vect : in Vector) return String;



end Data;

