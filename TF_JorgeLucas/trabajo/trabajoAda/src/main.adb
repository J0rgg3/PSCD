with Ada.Text_IO,Ada.Numerics.Discrete_Random;
use Ada.Text_IO;


procedure Main is

   --VARIABLES GLOBALES
   duchas : integer := 3;
   pchL,espL,trpL,bcpL,legL : Boolean := True;
   parkin : Integer := 5;

   --TASK

   task crear;

   task app is

      entry usar(nombre : in Integer);

   end app;

   task monitor is

      entry mostrador(nombre : in Integer);
      entry duda(nombre : in Integer);

   end monitor;

   task espera is

      entry esperar;
      entry ducha;

   end espera;

   --TASK TYPE

   task type clientes(nombre : Integer);


   --FUNCIONES AUXILIARES

   function aleatorios(y : in Integer) return Boolean is

      subtype s is integer range 1..10;
      package Azar is new Ada.Numerics.Discrete_Random(s);

      generarAzar: Azar.Generator;
      x : Integer;

   begin

      Azar.Reset (generarAzar);
      x := Azar.Random(generarAzar);
      return x < y;

   end aleatorios;

   procedure ejercicio(tipo : in String; nombre : in Integer; hecho: in out Boolean) is

   begin

      Put_Line("El cliente " & Integer'Image(nombre) & " esta haciendo " & tipo);

      if aleatorios(3) then

         Put_Line("El cliente " & Integer'Image(nombre) & " tiene una duda");
         monitor.duda(nombre);
         Delay Duration(1);

      else

         Delay Duration(2);

      end if;

      Put_Line("El cliente " & Integer'Image(nombre) & " ha acabado con " & tipo);
      hecho := False;

   end ejercicio;

   procedure rutina(nombre : in Integer; pch: in out Boolean;esp : in out Boolean; trp: in out Boolean; bcp : in out Boolean; leg: in out Boolean) is



   begin

      while pch or esp or trp or bcp or leg loop

         espera.esperar;

         if(pch and pchL) then

            pchL := False;
            ejercicio("BANCA",nombre,pch);
            pchL := True;



         end if;

         if(esp and espL) then

            espL := False;
            ejercicio("REMO",nombre,esp);
            espL:= True;

         end if;

         if(trp and trpL) then

            trpL := False;
            ejercicio("FONDOS",nombre,trp);
            trpL:= True;

         end if;

         if(bcp and bcpL) then

            bcpL := False;
            ejercicio("CURL DE BICEPS",nombre,bcp);
            bcpL:= True;

         end if;

         if(leg and legL) then

            legL := False;
            ejercicio("SENTADILLA",nombre,leg);
            legL:= True;

         end if;

      end loop;


   end rutina;


   --TASK BODIES
   task body crear is

      type w is access  clientes;
      a1 : w;
      i : Integer:=1;
      r : Float:= 1.00;
   begin
      loop

         a1 := new clientes(i);
         i := i+1;
         r := r + 0.5;
         delay Duration(r);

      end loop;
   end crear;


   task body app is

   begin
      loop
         if parkin > 0 then
            accept usar(nombre : in Integer) do

               Put_line("El cliente " & Integer'Image(nombre) & " está aparcando");
               parkin := parkin - 1;
               Delay Duration(2);

            end usar;

         end if;

      end loop;

   end app;


   task body monitor is

   begin

      loop
         select

            accept mostrador (nombre : in Integer) do

               Put_Line("El monitor esta dando de alta al cliente " & Integer'Image(nombre));
               delay Duration(2);
               Put_Line("El cliente " &  Integer'Image(nombre) & " ha sido dado de alta y ha entrado a la sala de maquinas ");
            end mostrador;

         or

            accept duda (nombre : in Integer) do

               Put_Line("El monitor esta atendiendo una duda del cliente " & Integer'Image(nombre));
               delay Duration(1);
               Put_Line("El monitor ha resuelto la duda del cliente " & Integer'Image(nombre));

            end duda;

         end select;

      end loop;

   end monitor;


   task body espera is

   begin
      loop
         select

            when pchL or espL or trpL or bcpL or legL =>

            accept esperar do
               null;
            end esperar;

         or
            when duchas > 0 =>

               accept ducha  do
                  duchas := duchas - 1;
               end ducha;

         end select;

      end loop;

   end espera;


   task body clientes is

      coche, needAlta, ducha : Boolean; -- se podrian omitir y poner la funcion directamente en el if pero me parece que asi queda mas claro
      pch,esp,trp,bcp,leg : Boolean := True;

   begin

      coche := aleatorios(6);
      needAlta:= aleatorios(4);

      if coche then

            app.usar(nombre);

      end if;

      Put_Line("El cliente " &  Integer'Image(nombre) & " ha entrado al gimnasio");

      if needAlta then

         monitor.mostrador(nombre);

      else

         Put_Line("El cliente " &  Integer'Image(nombre) & " es socio y ha entrado a la sala de maquinas ");

      end if;

      rutina(nombre,pch,esp,trp,bcp,leg);

      ducha := aleatorios(6);

      if ducha then

         espera.ducha;
         Put_Line("El cliente " & Integer'Image(nombre) & " se esta duchando");

         delay Duration(1.5);
         duchas := duchas + 1;

      end if;


      if coche then

         Put_Line("El cliente " & Integer'Image(nombre)  & " ha acabado, coge el coche y se marcha");
         parkin := parkin + 1;

      else

         Put_Line("El cliente " & Integer'Image(nombre)  & " ha acabado y se marcha");

      end if;

   end clientes;


begin




         null;
end Main;
