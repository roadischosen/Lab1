with Data;
with Ada.Text_IO; use Ada.Text_IO;

-- Entry point
procedure Lab1 is
   package Lab1Data is new Data (Dimension => 2,
                                 Max_Output => 0,
                                 Generate => false);
   use Lab1Data;

   task T1 is
      pragma Priority(1);
      pragma Storage_Size(30_000_000);
      pragma CPU(1);
   end;
   task body T1 is
   begin
      Put_Line("T1 started");
      delay 0.1;
      Func1 ("Lab1/IO/T1.in");
      delay 0.2;
      Put_Line("T1 finished");
   end T1;

   task T2 is
      pragma Priority(2);
      pragma Storage_Size(30_000_000);
      pragma CPU(2);
   end;
   task body T2 is
   begin
      Put_Line("T2 started");
      delay 0.3;
      Func2 ("Lab1/IO/T1.in");
      delay 0.4;
      Put_Line("T2 finished");
   end T2;

   task T3 is
      pragma Priority(3);
      pragma Storage_Size(30_000_000);
      pragma CPU(3);
   end;
   task body T3 is
   begin
      Put_Line("T3 started");
      delay 0.5;
      Func3 ("Lab1/IO/T1.in");
      delay 0.6;
      Put_Line("T3 finished");
   end T3;

begin
   null;
end Lab1;
