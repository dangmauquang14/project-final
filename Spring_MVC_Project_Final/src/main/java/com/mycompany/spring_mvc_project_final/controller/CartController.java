/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.service.OrderService;
import com.mycompany.spring_mvc_project_final.service.ProductService;
import com.mycompany.spring_mvc_project_final.service.PromotionService;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author nguye
 */
@Controller
public class CartController {

    @Autowired
    private ProductService productService;

    @Autowired
    public PromotionService promotionService;

    @Autowired
    public OrderService orderService;

    @RequestMapping("/cart/{id}")
    public String orderProduct(Model model,
            HttpSession session,
            HttpServletRequest request,
            @PathVariable("id") int id) {
        HashMap<Integer, OrderDetailEntity> cartItems
                = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        String url = request.getHeader("referer");
        // tao order
        if (cartItems == null) {
            cartItems = new HashMap<>();
        }
        ProductEntity product = productService.findById(id);
        OrderDetailEntity orderDetail = new OrderDetailEntity();

        // neu san pham co trong gio hang thi tang so luong them 1
        if (product.getId() != 0) {
            if (cartItems.containsKey(id)) {
                orderDetail = cartItems.get(id);
                orderDetail.setQuantity(orderDetail.getQuantity() + 1);
                orderDetail.setPrice(product.getPrice());
            } else {
                orderDetail.setProduct(product);
                orderDetail.setQuantity(1);
                orderDetail.setPrice(product.getPrice());
            }
            cartItems.put(id, orderDetail);
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        model.addAttribute("username", username);
        session.setAttribute("cartItems", cartItems);
        session.setAttribute("date", new Date());
        session.setAttribute("totalPrice", orderService.totalPrice(cartItems));
        model.addAttribute("promotions", promotionService.getPromotionsToDay());
        return "redirect:" + url;
    }

    @RequestMapping(value = "/view-cart", method = RequestMethod.GET)
    public String viewCarts(Model model,
            HttpSession session,
            HttpServletRequest request,
            @RequestParam(value = "type", required = false) String type,
            @RequestParam(value = "message", required = false) String message) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);

        HashMap<Integer, OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        for (Map.Entry<Integer, OrderDetailEntity> entry : cartItems.entrySet()) {
            entry.getValue().setProduct(productService.findById(entry.getValue().getProduct().getId()));
        }
        session.setAttribute("date", new Date());
        if (cartItems != null) {
            session.setAttribute("totalPrice", orderService.totalPrice(cartItems));
        }
        session.setAttribute("cartItems", cartItems);
        model.addAttribute("promotions", promotionService.getPromotionsToDay());
        return "cart";
    }

    @RequestMapping("/cart/delete/{id}")
    public String deleteProductCart(HttpSession session,
            HttpServletRequest request,
            Model model,
            @PathVariable("id") int id) {
        String message = "";
        String type = "";
        String url = request.getHeader("referer");

        HashMap<Integer, OrderDetailEntity> cartItems
                = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        if (cartItems != null) {
            if (cartItems.containsKey(id)) {
                cartItems.remove(id);
                type = "success";
                message = "delete success";
            }
        } else {
            type = "fail";
            message = "delete fail Not found product";
        }
        model.addAttribute("message", message);
        model.addAttribute("type", type);
        return "redirect:" + url;
    }

    @RequestMapping("/cart/delete")
    public String deleteCart(HttpSession session,
            Model model) {
        String message = "";
        String type = "";
        HashMap<Integer, OrderDetailEntity> cartItems
                = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        if (cartItems.size() > 0) {
            cartItems.clear();
            type = "success";
            message = "delete all success";
        } else {
            type = "fail";
            message = "delete fail or not found product";
        }

        model.addAttribute("message", message);
        model.addAttribute("type", type);

        return "redirect:/view-cart";
    }

    @RequestMapping(value = "/cart/update", method = RequestMethod.POST)
    public String updateCart(
            HttpServletRequest request,
            Model model,
            HttpSession session) {
        String message = "";
        String type = "";
        HashMap<Integer, OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        if (cartItems.size() > 0) {
            String[] idProduct = request.getParameterValues("id");
            String[] quantities = request.getParameterValues("q");
            for (int i = 0; i < idProduct.length; i++) {
                OrderDetailEntity cartItem = cartItems.get(Integer.valueOf(idProduct[i]));
                cartItem.setQuantity(Integer.valueOf(quantities[i]));
//                cartItem.setTotal(cartItem.getQuantity() * cartItem.getProduct().getPrice());
            }
            type = "success";
            message = "update success";
        } else {
            type = "fail";
            message = "update fail or not found product";
        }

        model.addAttribute("message", message);
        model.addAttribute("type", type);
        return "redirect:/view-cart";
    }

}
