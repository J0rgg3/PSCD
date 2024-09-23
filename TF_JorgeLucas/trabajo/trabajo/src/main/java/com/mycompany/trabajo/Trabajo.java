/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Project/Maven2/JavaApp/src/main/java/${packagePath}/${mainClassName}.java to edit this template
 */

package com.mycompany.trabajo;

/**
 *
 * @author jorge
 */
public class Trabajo {

    public static void main(String[] args) {
        
        
        recorrido rec = new recorrido();
        monitor antonio = new monitor(rec);
        antonio.start();
        clientes c = new clientes(rec,1);
        clientes c2 = new clientes(rec,2);
        clientes c3 = new clientes(rec,3);
        clientes c4 = new clientes(rec,4);
        clientes c5 = new clientes(rec,5);
        clientes c6 = new clientes(rec,6);
        clientes c7 = new clientes(rec,7);
        clientes c8 = new clientes(rec,8);
        clientes c9 = new clientes(rec,9);
        clientes c10 = new clientes(rec,10);
        c.start();
        c2.start();
        c3.start();
        c4.start();
        c5.start();
        c6.start();
            
    }
}
