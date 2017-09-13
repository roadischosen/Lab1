
generic
   Dimension  : in Integer;
   Max_Output : in Natural := 5;
   Generate   : in Boolean := True;

package Data is
   
   procedure Func1 (File_Name : in String);
   procedure Func2 (File_Name : in String);
   procedure Func3 (File_Name : in String);

end Data;

