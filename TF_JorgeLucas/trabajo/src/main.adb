with Ada.Numerics.Discrete_Random, Ada.Calendar;
with Ada.Text_IO; use Ada.Text_IO,Ada.Calendar;
procedure Main is


   abierto : Boolean := true;
   task a;

   task body a is
   contador : integer :=0;
   begin

      loop

         contador := contador + 1;
         delay Duration(1);
         if( contador = 10) then

            abierto := False;
            contador := 0;
            delay Duration(10);
            abierto := True;

         end if;

      end loop;
   end a;


begin

         loop
            while(abierto) loop

               Put_Line("abierto");

            end loop;
            Put_Line("cerrado");
         end loop;



end Main;
