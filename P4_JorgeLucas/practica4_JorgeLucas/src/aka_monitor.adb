with Ada.Text_IO; use Ada.Text_IO;
package body aka_monitor is

 
   protected body monitor is 
      
      entry movilMostrador( x : in Character) when (nMostrador < mostradorMax) is 
      begin 
         
         nMostrador := nMostrador + 1;
         Put_Line("Ha llegado un nuevo movil de tipo " & x & " al mostrador");
         
         
      end movilMostrador;
 

      procedure empaquetarMovil(x: in Character) is
      entra : Boolean;
      begin
         entra := sumaPeso(x);
         if entra then

            Put_Line("Se ha retirado la caja con " & Integer'Image(nMoviles) & " moviles pesando" & Integer'Image(pesoCaja) & "g");
            

            Put_Line("Se ha puesto una nueva caja");
            nMoviles := 0;
            pesoCaja := 0;
            entra := sumaPeso(x);
         end if;
         
           
            nMoviles := nMoviles + 1;
            Put_Line("Se ha añadido un movil a la caja (Numero de moviles:" & Integer'Image(nMoviles) & "). Peso total: " & Integer'Image(pesoCaja) & "/" &Integer'Image(pesoMax));
            nMostrador := nMostrador - 1;

         

            
            
         

      end empaquetarMovil;

       

      function sumaPeso (x : in Character) return boolean is
      
         peso : Integer;

      begin
         
         if x = 'A' then
            peso := 120;
            pesoCaja := pesocaja + peso;
            
         elsif x = 'B' then
               peso := 210;
               pesoCaja := pesoCaja + peso;
               
         else 
              peso := 170;
              pesoCaja := pesoCaja + peso;
           
         end if;
            
         if pesoCaja <= pesoMax then
               
               return False;
            
            else
               pesoCaja := pesoCaja - peso;
               return True;
            
            end if;
            
               
      end sumaPeso;
      
   end monitor;
  end aka_monitor;
