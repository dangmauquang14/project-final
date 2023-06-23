/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.bean.MyItem;
import com.mycompany.spring_mvc_project_final.service.CategoryService;
import com.mycompany.spring_mvc_project_final.service.OrderService;
import com.mycompany.spring_mvc_project_final.service.ProductService;
import com.mycompany.spring_mvc_project_final.service.PromotionService;
import com.mycompany.spring_mvc_project_final.service.ReportService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import java.time.LocalDate;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;
    
    @Autowired 
    private ReportService reportService;
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private PromotionService promoitonService;
    
    @RequestMapping("/home")
    public String viewHome(Model model, ModelMap mm,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        int year = LocalDate.now().getYear();
        model.addAttribute("username", username);
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("sizeProducts", productService.getProducts().size());
        model.addAttribute("sizeProductsActive", productService.getProductsActivee().size());
        model.addAttribute("sizeUsers", userService.getUsers().size());
        model.addAttribute("countOrderPending", orderService.countOrderPending());
        model.addAttribute("countPromotionActive", promoitonService.countPromotionActive());
        model.addAttribute("year", year);
        model.addAttribute("month", LocalDate.now().getMonthValue());
        model.addAttribute("sumRevenue", orderService.sumRevenueInMonth(LocalDate.now().getMonthValue(),year));
        model.addAttribute("sumProductSold", orderService.sumProductSoldInMonth(LocalDate.now().getMonthValue(),year));
        model.addAttribute("sumProductsInStock", productService.sumProductsInStock());
        List<MyItem> listItem = reportService.reportReceipt();
        mm.put("listReceipt", listItem);
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "admin/home";
    }
}
