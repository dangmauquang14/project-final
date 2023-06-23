/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.main;

import java.util.Date;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class Main {

    public static void main(String[] args) {
        System.out.println("password===>" + encrytePassword("1"));
        System.out.println("12333");

        Date a = new Date(2020, 2, 1);
        Date b = new Date(2020, 3, 2);
        Date d = new Date(2020, 2, 6);
        System.out.println(a.compareTo(d));
        System.out.println(d.compareTo(b));
        System.out.println(a.compareTo(d) * d.compareTo(b) > 0);
    }

    public static String encrytePassword(String password) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        return encoder.encode(password);
    }

}
