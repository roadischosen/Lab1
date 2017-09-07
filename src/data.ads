with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Real_Arrays;  use Ada.Numerics.Real_Arrays;
with Ada.Containers.Generic_Array_Sort;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
generic
   Dimension  : in Integer;
   Max_Output : in Natural := 5;
   Input_Mode : in Mode := Generate;

package Data is
   
   type Mode is (Manual, Generate);
   
   function Func1 return Float;
   function Func2 return Real_Matrix;
   function Func3 return Real_Vector;

   procedure Put_Matrix ( Matrix : in Real_Matrix; Max : in Natural );
   procedure Put_Vector ( Vector : in Real_Vector; Max : in Natural );

end Data;

