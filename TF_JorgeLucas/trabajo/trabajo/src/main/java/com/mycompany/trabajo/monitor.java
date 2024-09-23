/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.trabajo;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jorge
 */
public class monitor extends Thread {
    
 
 recorrido r;
    
public monitor(recorrido rec){

    this.r = rec;

}


public void run(){
    
    while(true){
        try {

            this.r.llamarAntonio.acquire();

            if(this.r.secretaria){

               System.out.println("Antonio va la recepcion"); 
              
               monitor.sleep(3000);

               System.out.println("Antonio dio de alta al paciente"); 
               

            }else if(this.r.duda){
            
                System.out.println("Antonio va a resolver la duda"); 
                
                monitor.sleep(2000);

            }
            
            this.r.acaboA.release();
            
        } catch (InterruptedException ex) {
               Logger.getLogger(monitor.class.getName()).log(Level.SEVERE, null, ex);
         }
    }    
         

     
     

}
}
