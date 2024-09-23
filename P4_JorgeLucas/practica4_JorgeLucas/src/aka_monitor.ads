package aka_monitor is

   pesoCaja : integer := 0;
   
   protected type monitor is 
      
      entry movilMostrador(x : in Character);
      function sumaPeso(x : in Character) return Boolean;
      procedure empaquetarMovil(x : in Character);
     
   
   private
      
      nMostrador : Integer := 0;
      mostradorMax : Integer := 2;
      nMoviles : Integer := 0;
      pesoMax : Integer := 1000;
      
      
      
      
      
      
   end monitor;
   

end aka_monitor;
