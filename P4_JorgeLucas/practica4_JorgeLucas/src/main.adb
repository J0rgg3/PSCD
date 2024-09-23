
with Ada.Text_IO,Ada.Integer_Text_IO,aka_monitor,Ada.Numerics.Discrete_Random;
use Ada.Text_IO,Ada.Integer_Text_IO,aka_monitor;

procedure Main is




   -- los tipos de móviles
   task A;
   task B;
   task C;
   d : monitor;

   task body A is

      a : Character := 'A';

   begin
      loop

         d.movilMostrador(a);

         d.empaquetarMovil(a);
         delay duration(1);

      end loop;
   end A;

   task body B is

      b : Character:= 'B';

   begin
      loop


         d.movilMostrador(b);

         d.empaquetarMovil(b);
         delay Duration(1.1);

      end loop;
   end B;

   task body C is

      c : Character:= 'C';

   begin
      loop


         d.movilMostrador(c);

         d.empaquetarMovil(c);
         delay Duration(0.9);

      end loop;
   end C;

begin



   null;
end Main;
