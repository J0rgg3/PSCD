with Ada.Text_IO,Ada.Numerics.Discrete_Random, Ada.Calendar;
use Ada.Text_IO,Ada.Calendar;

procedure Main is

   --VARIABLES GLOBALES

   unico, abierto : Boolean := True;
   capTaller : Integer := 3;
   A,B,C : Boolean := True;
   prioridad : Boolean := False;


   --TASK TYPES
   task type cliente (nombre : Integer);

   task type coches is

      entry usar(nombre :in Integer; modelo : in Character) ;

   end coches;

   --TASK
   task crear;
   task reloj;
   task  mecanicos is

      entry reparar( nombre : in Integer);
      entry repararUrgente( nombre : in Integer);

   end mecanicos;


   task  encargado is

      entry cobrarTaller(nombre : in Integer);
      entry cobrarVenta(nombre : in Integer);

   end encargado;

   task espera is
      entry esperar (nombre : in Integer);
   end espera;


   --FUNCIONES/PROCEDIMIENTOS
   function aleatorios return Boolean is

      subtype s is integer range 1..10;
      package Azar is new Ada.Numerics.Discrete_Random(s);

      generarAzar: Azar.Generator;
      x : Integer;

   begin

      Azar.Reset (generarAzar);
      x := Azar.Random(generarAzar);


      return x < 6;

   end aleatorios;




   function valoracion (nombre : in Integer) return Boolean is


   begin

      Put_Line("Se está llevando a cabo la valoración del coche del cliente " & Integer'Image(nombre));
      delay Duration(2);



      if aleatorios then

         Put_Line("La reparación del cliente " & Integer'Image(nombre) & " es difícil") ;
         return true;

      else

         Put_Line("La reparación del cliente " & Integer'Image(nombre) & " es fácil") ;
         return false;

      end if;

   end valoracion;

   procedure darVuelta(nombre :in Integer; modelo : in Character) is
   begin

      Put_Line("El cliente " & Integer'Image(nombre) & " se ha ido a dar una vuelta en el coche " & modelo);
      delay Duration(4);
      Put_Line("El cliente " & Integer'Image(nombre) & " ha vuelto en el coche " & modelo);

   end darVuelta;

   -- variables2

   type coche is access coches;
   c1 : coche;
   c2 : coche;
   c3 : coche;


   --TASK BODIES

   task body crear is

      type w is access  cliente;
      a1 : w;
      i : Integer:=1;

   begin
      loop
         if(abierto) then

            a1 := new cliente(i);
            i := i+1;
            delay Duration(1);

         end if;



      end loop;
   end crear;


   task body reloj is
   contador : integer :=0;
   begin

      loop

         contador := contador + 1;
         delay Duration(1);
         if( contador = 15) then

            abierto := False;
            Put_Line("El concesionario ha cerrado");
            contador := 0;
            delay Duration(10);
            abierto := True;
            Put_Line("El concesionario ha abierto");

         end if;

      end loop;
   end reloj;


   task body espera is
   begin
      loop
         if( A or  B or  C) then
            accept esperar (nombre : in Integer) do

               null;
            end esperar;
         end if;
      end loop;
   end espera;

   task body coches is
   begin
      loop

         accept usar(nombre :in Integer;modelo : in Character) do

            darVuelta(nombre, modelo);

         end usar;

      end loop;

   end coches;



   task body mecanicos is

   begin

      loop
         select

            when prioridad =>
            accept repararUrgente( nombre : in Integer)  do

               delay Duration(2);
               Put_Line("El coche del cliente " & Integer'Image(nombre) & " ha sido reparado urgentemente ");
               prioridad := False;
            end repararUrgente;
         or

            accept reparar( nombre : in Integer)  do

               delay Duration(2);
               Put_Line("el coche del cliente " & Integer'Image(nombre) & " ha sido reparado");

            end reparar;


         end select;

      end loop;

   end mecanicos;


   task body cliente is

      reparacion,dejarCoche : Boolean := True;--true necesita reparación
      revision,dificil,siGusta : Boolean;
      vueltas : Integer := 0; --Maximo 3


   begin

      revision := aleatorios;

      if revision then

         dificil := valoracion(nombre);

         if dificil and capTaller > 0   then

            Put_Line("El cliente " & Integer'Image(nombre) & " ha dejado el coche reparando");
            capTaller := capTaller - 1;

            while reparacion loop

               if vueltas = 2 then

                  prioridad := true;

                  mecanicos.repararUrgente(nombre);
                  reparacion := false;

               end if;

               if unico then

                  unico:= false;
                  mecanicos.reparar(nombre);

                  reparacion := false;
                  unico := True;

               else

                  Put_Line("El cliente " & Integer'Image(nombre) & " esta dando una vuelta ");
                  vueltas:= vueltas + 1;
                  delay Duration(4);

               end if;

            end loop;

            capTaller := capTaller + 1;
            encargado.cobrarTaller(nombre);


         else

            Put_Line("El cliente " & Integer'Image(nombre) & " está esperando en el taller" );
            mecanicos.reparar(nombre);

         end if;

      else

      Put_Line("El cliente " & Integer'Image(nombre) & " está mirando coches");
      delay Duration(2);
      siGusta := aleatorios;

         if siGusta then

            espera.esperar(nombre);


            if A then

               A := False;
               c1.usar(nombre,'A');
               A := True;

            elsif B then

               B := False;
               c2.usar(nombre,'B');
               B := True;

            elsif C then

               C := False;
               c3.usar(nombre,'C');
               C := True;

            end if;

            if(aleatorios) then-- Quizad para ser más estrictos con el enunciado se podría sacar si lo quiere o no en los ifs de arriba, pero esto me parece mejor

               Put_Line("Al cliente " & Integer'Image(nombre) & " le ha gustado el coche y se lo quiere comprar");
               encargado.cobrarVenta(nombre);

            else

               Put_Line("Al cliente " & Integer'Image(nombre) & " no le ha gustado el coche y se marcha");

            end if;

         else

            Put_Line("Al cliente " & Integer'Image(nombre) & " no le gusta ningun coche y se marcha");

         end if;
      end if;

   end cliente;


   task body encargado is

   begin

      loop

         while abierto loop

            select

               accept cobrarTaller(nombre : in Integer) do

                  delay Duration(2.5);
                  Put_Line("El encargado le está cobrado la reparación al cliente " & Integer'Image(nombre));

               end;

            or
               accept cobrarVenta(nombre : in Integer) do

                  Put_Line("El encargado está organizando el papeleo con el cliente " & Integer'Image(nombre) );
                  delay Duration(4.5);
                  Put_Line("El cliente " & Integer'Image(nombre) & " ha pagado el coche");

               end;
            or
               when not abierto=>
                  terminate;

            end select;


         end loop;
      end loop;

   end encargado;


begin

   c1 := new coches;
   c2 := new coches;
   c3 := new coches;


end Main;
