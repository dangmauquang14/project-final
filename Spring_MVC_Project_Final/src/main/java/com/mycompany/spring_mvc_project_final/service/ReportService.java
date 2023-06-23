/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.bean.MyItem;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReportService {

    @Autowired
    private OrderService orderService;
    int year = LocalDate.now().getYear();

    public List<MyItem> reportReceipt() {
        List<MyItem> list = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            MyItem myItem = new MyItem();
            myItem.setTime("Month " + i);
            myItem.setValue(orderService.countOrderInMonth(i, year));
            list.add(myItem);
        }
        return list;
    }
}
