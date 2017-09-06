with Data;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Real_Arrays;  use Ada.Numerics.Real_Arrays;
with System.Multiprocessors; use System.Multiprocessors;
procedure Lab1 is
   N : Integer := 80;
   package Lab1Data is new Data(N);
   use Lab1Data;
   Result_Vector : Real_Vector (0..N);
   Result_Matrix : Real_Matrix (0..N, 0..N);
   Result_Float  : Float;
   CPU0: CPU_Range := 0;
   CPU1: CPU_Range := 1;
   CPU2: CPU_Range := 2;

   procedure tasks is
      task T1 is
         pragma Priority(1);
         pragma Storage_Size(100000);
         pragma CPU(CPU0);
      end;

      task T2;

      task T3 is
         pragma Priority(5);
         pragma Storage_Size(100000);
      end;

      task body T1 is
      begin
         Put_Line("T1 started");
         Result_Float := Func1;
         Put_Line("T1 finished");
      end T1;

      task body T2 is
      begin
         Put_Line("T2 started");
         Result_Matrix := Func2;
         Put_Line("T2 finished");
      end T2;

      task body T3 is
      begin
         Put_Line("T3 started");
         Result_Vector := Func3;
         Put_Line("T3 finished");
      end T3;
   begin
      null;
   end tasks;

begin

   tasks;

   Put_Line("Task 1 result: " & Float'Image (Result_Float));

   Put_Line("Task 2 results:");
   --Put_Matrix(Result_Matrix);
   New_Line;

   Put_Line("Task 3 results:");
   --Put_Vector(Result_Vector);

end Lab1;
