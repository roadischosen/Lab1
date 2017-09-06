with Data;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Real_Arrays;  use Ada.Numerics.Real_Arrays;

procedure Lab1 is
   N : Integer := 80;
   package Lab1Data is new Data(N);
   use Lab1Data;
   Result_Vector : Real_Vector (0..N);
   Result_Matrix : Real_Matrix (0..N, 0..N);
   Result_Float  : Float;

   procedure tasks is
      task T1 is
         pragma Priority(1);
         pragma Storage_Size(1_000_000);
         pragma CPU(0);
      end;

      task T2 is
         pragma Priority(2);
         pragma Storage_Size(1_000_000);
         pragma CPU(1);
      end;

      task T3 is
         pragma Priority(3);
         pragma Storage_Size(1_000_000);
         pragma CPU(2);
      end;

      task body T1 is
      begin
         Put_Line("T1 started");
         delay 0.1;
         Result_Float := Func1;
         delay 0.2;
         Put_Line("T1 finished");
      end T1;

      task body T2 is
      begin
         Put_Line("T2 started");
         delay 0.3;
         Result_Matrix := Func2;
         delay 0.4;
         Put_Line("T2 finished");
      end T2;

      task body T3 is
      begin
         Put_Line("T3 started");
         delay 0.5;
         Result_Vector := Func3;
         delay 0.6;
         Put_Line("T3 finished");
      end T3;
   begin
      null;
   end tasks;

begin

   tasks;

   Put_Line("Task 1 result: " & Float'Image (Result_Float));

   Put_Line("Task 2 results are cut:");
   Put_Matrix(Result_Matrix, 5);

   Put_Line("Task 3 results are cut:");
   Put_Vector(Result_Vector, 5);

end Lab1;
