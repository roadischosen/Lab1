with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Real_Arrays;  use Ada.Numerics.Real_Arrays;
with Ada.Containers.Generic_Array_Sort;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
generic
   Dimension: in Integer;

package Data is

   function Func1 return Float;
   function Func2 return Real_Matrix;
   function Func3 return Real_Vector;

   procedure Put_Matrix ( Matrix : in Real_Matrix; Max : in Natural );
   procedure Put_Vector ( Vector : in Real_Vector; Max : in Natural );

private
   Gen : Generator;

   procedure Randomize_Matrix ( Matrix : out Real_Matrix );
   procedure Randomize_Vector ( Vector : out Real_Vector );

   procedure Sort is new Ada.Containers.Generic_Array_Sort
     (Index_Type   => Integer,
      Element_Type => Float,
      Array_Type   => Real_Vector);

end Data;

