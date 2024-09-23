/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.trabajo;

import java.util.Random;
import java.util.concurrent.Semaphore;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author jorge
 */
public class recorrido {
    
    Semaphore parkin;
    Semaphore llamarAntonio;//El monitor no puede hacerse apartir de procesos sincronizados
    Semaphore antonio,acaboA;//es el monitor de mi gym me ayuda a visualizarlo y asi evito confusiones con la clase monitor
    Semaphore maquinas;
    Semaphore duchas;
    
    int aparcados;
    Random azar;
    boolean secretaria,duda;
    boolean bocupada,socupada,locupada,rocupada,focupada;
    
   
    public recorrido(){
        
        this.secretaria = false;
        this.duda = false;
        this.bocupada = false;
        this.socupada = false;
        this.locupada = false;
        this.rocupada = false;
        this.focupada = false;
        this.azar = new Random();
        
        this.aparcados = 0;
        this.llamarAntonio = new Semaphore(0);
        this.parkin = new Semaphore(5,true);
        this.antonio = new Semaphore(1,true);
        this.acaboA = new Semaphore(0);
        this.duchas = new Semaphore(3,true);
        this.maquinas = new Semaphore(5,true);
        

        
    }
    //procesos sincronizados/monitor
    public synchronized void app(int cliente){
    
        System.out.println("el cliente " + cliente + " está usando la app del apacarmineto");//numero cliente
        
        try {
            
            clientes.sleep(2000);
            
        } catch (InterruptedException ex) {
            Logger.getLogger(recorrido.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    public void monitorRequest(int nombre){
    
       if(secretaria){
           
            this.llamarAntonio.release();
            
            try {

                this.acaboA.acquire();//para controlar las llamadas al monitor
                
                System.out.println("el cliente " + nombre + " se ha dado de alta y pasa a la sala de maquinas");
                this.secretaria = false;
            } catch (InterruptedException ex) {
                
            }
            

       }else if (duda){
       
           
           this.llamarAntonio.release();
           
           try {

                this.acaboA.acquire();//para controlar las llamadas al monitor
                this.duda = false;
            } catch (InterruptedException ex) {
                
            }
           System.out.println("Antonio ha resuelto la duda del cliente " + nombre);
       
       }
    
    }

   
    
    public void aparcamiento(int nombre){
           
        System.out.println("el cliente " + nombre + " está esperando para aparcar");
           
        try {

            this.parkin.acquire();
            this.app(nombre);

        } catch (InterruptedException ex) {

        }


       }
       
  
   public void Alta(int nombre){
       
        System.out.println("el cliente " + nombre + " está esperando para darse de alta");
        try {
           
            this.antonio.acquire();
          
            
        } catch (InterruptedException ex) {
            Logger.getLogger(recorrido.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        this.secretaria = true;
        this.monitorRequest(nombre);
        this.antonio.release();


}
   public void resolverDuda(int nombre){

        try {
            System.out.println("El cliente " + nombre + " tiene una duda");
            this.antonio.acquire();
          
            
        } catch (InterruptedException ex) {
            Logger.getLogger(recorrido.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        this.duda = true;
        this.monitorRequest(nombre);
        this.antonio.release();
  
   
   } 
   public boolean ya(boolean banca,boolean sentadilla,boolean laterales,boolean remo,boolean fondos){
   
       return banca || sentadilla || laterales || remo || fondos;
   
   }
   public void ejercicio(){
   
        try {
            clientes.sleep((int)Math.random()*5000+2500);
        } catch (InterruptedException ex) {
            Logger.getLogger(recorrido.class.getName()).log(Level.SEVERE, null, ex);
        }
   
   }

   public void rutina(int nombre,boolean banca,boolean sentadilla,boolean laterales,boolean remo,boolean fondos){//he hecho de un booleano para eviatarme poner un semaforo o una funcion del monitor por cada maquina
   
      while(this.ya(banca,sentadilla,laterales,remo,fondos)){
          
          try { 
              
              this.maquinas.acquire();
              
          } catch (InterruptedException ex) {
              Logger.getLogger(recorrido.class.getName()).log(Level.SEVERE, null, ex);
          }
          
        if(banca && !bocupada){
            
            this.bocupada = true;
            
            System.out.println("el cliente " + nombre + " esta haciendo BANCA");
            if( azar.nextBoolean()){
            
                 this.resolverDuda(nombre);
            }
            
            
            this.ejercicio();
                System.out.println("el cliente " + nombre + " ha acabado con la BANCA");
            
           
            this.bocupada = false;
            banca = false;
            this.maquinas.release();
        
        }
        if(sentadilla && !socupada){
        
            this.socupada = true;
            
            System.out.println("el cliente " + nombre + " esta haciendo SENTADILLA");
            if( azar.nextBoolean()){
            
                 this.resolverDuda(nombre);
            }
            
            this.ejercicio();
            System.out.println("el cliente " + nombre + " ha acabado con la SENTADILLA");
            
            this.socupada = false;
            sentadilla = false;
            this.maquinas.release();
        
        }
        
        if(laterales && !locupada){
            
            this.locupada = true;
            
            System.out.println("el cliente " + nombre + " esta haciendo ELEVACIONES LATERALES");
            
            if( azar.nextBoolean()){
            
                 this.resolverDuda(nombre);
            }
            
            
            this.ejercicio();
            System.out.println("el cliente " + nombre + " ha acabado con las ELEVACIONES LATERALES");
            
           
            this.locupada = false;
            laterales = false;
            this.maquinas.release();
        
        }
      
        if(remo&& !rocupada){
            
            this.rocupada = true;
            
            System.out.println("el cliente " + nombre + " esta haciendo REMO");
            if( azar.nextBoolean()){
            
                 this.resolverDuda(nombre);
            }
            
            
            this.ejercicio();
            System.out.println("el cliente " + nombre + " ha acabado con el REMO");
            
   
            this.rocupada = false;
            remo = false;
            this.maquinas.release();
        
        }
          
        if(fondos&& !focupada){
            
            this.focupada = true;
            
            System.out.println("el cliente " + nombre + " esta haciendo FONDOS");
            if( azar.nextBoolean()){
            
                 this.resolverDuda(nombre);
            }
            
            
            this.ejercicio();
            System.out.println("el cliente " + nombre + " ha acabado con los FONDOS");


            this.focupada = false;
            fondos = false;
            this.maquinas.release();
        
        }
      }
   }
   
    public void ducharse(int nombre){
  
        try {
            
            this.duchas.acquire();
            
            System.out.println("el cliente " + nombre + " se está duchando");
            clientes.sleep(2000);
            System.out.println("el cliente " + nombre + " ya ha acabado y se ha vestido");
            
            this.duchas.release();
        
        } catch (InterruptedException ex) {
            Logger.getLogger(recorrido.class.getName()).log(Level.SEVERE, null, ex);
        }
        
  
  }


}
    

