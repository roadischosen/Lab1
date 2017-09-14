--------------------------------------------------
-- Лабораторна робота N1
-- Процеси в мові Ada. Задачі.
-- Виконав: Земін В.М. 
-- Група: ІО-53
--------------------------------------------------
with Data;
with Ada.Text_IO; use Ada.Text_IO;

--------------------------------------------------
-- Точка входу
--------------------------------------------------
procedure Lab1 is
   N : Integer := 2;
   Generate : Boolean := False;
   package Lab1Data is new Data (Dimension => N,
                                 Max_Output => 0);
   use Lab1Data;

   task T1 is
      pragma Priority(1);
      pragma Storage_Size(30_000_000);
      pragma CPU(1);
   end;
   task body T1 is
      A, B, C : Vector (0 .. N-1);
      MA, MD : Matrix;
      File : File_Type;
   begin
      Put_Line("T2 started");
      if Generate then
         Randomize (MA);
         Randomize (MD);
         Randomize (A);
         Randomize (B);
         Randomize (C);
      else
         Open (File, In_File, "Lab1/IO/T1.in");

         Get (File, A);
         Get (File, B);
         Get (File, C);
         Get (File, MA);
         Get (File, MD);

         Close (File);
      end if;

      Put_line ("Task T1 results: " & 
                Integer'Image (Func1 (A, B, C, MA, MD)));
      Put_Line("T1 finished");
   end T1;

   ------------------------------------------------
   task T2 is
      pragma Priority(2);
      pragma Storage_Size(30_000_000);
      pragma CPU(2);
   end;
   task body T2 is
      MK, MH, MF : Matrix;
      File : File_Type;
   begin
      Put_Line("T2 started");
      if Generate then
         Randomize (MK);
         Randomize (MH);
         Randomize (MF);
      else
         Open (File, In_File, "Lab1/IO/T2.in");

         Get (File, MK);
         Get (File, MH);
         Get (File, MF);

         Close (File);
      end if;

      Put_line ("Task T2 results:" & Character'Val(10) &
                To_String (Func2 (MK, MH, MF)));
      Put_Line("T2 finished");
   end T2;

   ------------------------------------------------
   task T3 is
      pragma Priority(3);
      pragma Storage_Size(30_000_000);
      pragma CPU(3);
   end;
   task body T3 is
      O, P: Vector (0 .. N-1);
      MR, MS : Matrix;
      File : File_Type;
   begin
      Put_Line("T3 started");
   if Generate then
         Randomize (MR);
         Randomize (MS);
         Randomize (O);
         Randomize (P);
      else
         Open (File, In_File, "Lab1/IO/T3.in");

         Get (File, O);
         Get (File, P);
         Get (File, MR);
         Get (File, MS);

         Close (File);
      end if;

      Put_line ("Task T3 results:" & Character'Val(10) & 
                To_String (Func3 (O, P, MR, MS)));

      Put_Line("T3 finished");
   end T3;

begin
   null;
end Lab1;
