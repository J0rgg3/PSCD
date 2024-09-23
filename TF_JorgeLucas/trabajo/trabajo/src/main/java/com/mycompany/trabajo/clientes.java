/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.trabajo;
import java.util.Random;
/**
 *
 * @author jorge
 */
public class clientes extends Thread {
    
    private recorrido r;
    private int nombre;
    private boolean aparcar,ducha,alta;
    private Random azar;
    private boolean banca,sentadilla,laterales,remo,fondos;
    
    public clientes(recorrido rec,int n){
       
       this.azar = new Random();
       this.aparcar = azar.nextBoolean();
       this.ducha = azar.nextBoolean();
       this.alta = azar.nextBoolean();
       this.nombre = n;
       this.r = rec;
       this.banca = true;
       this.sentadilla = true;
       this.laterales = true;
       this.remo = true;
       this.fondos = true;
       
    }

    
    public void run(){
        if(aparcar){
            
            this.r.aparcamiento(nombre);
            
        }
        
         System.out.println("el cliente " + nombre + " esta entrando al gimnasio");
        
        
        if(alta){
        
            this.r.Alta(nombre);
           
            
        }else{
        
            System.out.println("el cliente " + nombre + " es socio y pasa a la sala de maquinas");
          
        }
        
        this.r.rutina(nombre,banca,sentadilla,laterales,remo,fondos);
        
        if(ducha){
            
            this.r.ducharse(nombre);
        
        }
        
       if(aparcar){
           System.out.println("el cliente " + nombre + " ha cogido el coche");
           this.r.parkin.release();
       }
        
       System.out.println("El cliente " + nombre + " ha acabado por hoy");
    }
    
}
