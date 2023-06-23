/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.enums.PaymentMethod;
import com.mycompany.spring_mvc_project_final.service.OrderDetailService;
import com.mycompany.spring_mvc_project_final.service.OrderService;
import com.mycompany.spring_mvc_project_final.service.PaymentService;
import com.mycompany.spring_mvc_project_final.service.ProductService;
import com.mycompany.spring_mvc_project_final.service.PromotionService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import java.util.ArrayList;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author nguye
 */
@Controller
public class CheckoutController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    public JavaMailSender emailSender;

    @Autowired
    public ProductService productService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    public PromotionService promotionService;

    @Autowired
    public UserService userService;

    @RequestMapping(value = "/checkout", method = RequestMethod.GET)
    public String checkout(Model model, HttpSession session) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        HashMap<Integer, OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        for (Map.Entry<Integer, OrderDetailEntity> entry : cartItems.entrySet()) {
            entry.getValue().setProduct(productService.findById(entry.getValue().getProduct().getId()));
        }

        UserEntity userEntity = userService.findByEmail(username);
        model.addAttribute("userEntity", userEntity);

        session.setAttribute("cartItems", cartItems);
        model.addAttribute("username", username);
        model.addAttribute("promotions", promotionService.getPromotionsToDay());
        return "user/checkout";
    }

    @RequestMapping(value = "/checkout", method = RequestMethod.POST)
    public String viewCheckout(Model model,
            HttpSession session,
            HttpServletRequest request,
            @RequestParam("paymentMethod") PaymentMethod paymentMethod,
            @ModelAttribute("checkout") OrderEntity orderEntity) throws MessagingException {

        HashMap<Integer, OrderDetailEntity> orderItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        for (Map.Entry<Integer, OrderDetailEntity> entry : orderItems.entrySet()) {
            entry.getValue().setProduct(productService.findById(entry.getValue().getProduct().getId()));
        }
        
        HashMap<Integer, OrderEntity> orderHash = (HashMap<Integer, OrderEntity>) session.getAttribute("checkout");
        session.setAttribute("orderHash", orderHash);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);

        if (paymentMethod.equals(paymentMethod.CASH_ON_DELIVERY)) {
            UUID uuid = UUID.randomUUID();

            //set quatityOrdet and totalPriceOrder
            orderEntity.setOrderNumber(uuid.toString());
            orderEntity.setQuantity(getQuantityOrder(orderItems));
            orderEntity.setTotalPrice(orderService.totalPrice(orderItems));
            orderEntity.setOrderDate(new Date());
            if (username != null) {
                orderEntity.setAccount(userService.findByEmail(username));
            }
            orderService.save(orderEntity);

//  
            //PAYMENT_ORDER
            if (orderItems == null) {
                orderItems = new HashMap<>();
            }
            List<PromotionEntity> promotions = promotionService.getPromotionsToDay();
            for (Map.Entry<Integer, OrderDetailEntity> entry : orderItems.entrySet()) {
                OrderDetailEntity orderItem = new OrderDetailEntity();
                for (ProductEntity product : productService.getProducts()) {
                    if (product.getId() == entry.getValue().getProduct().getId()) {
                        product.setQuantity(product.getQuantity() - entry.getValue().getQuantity());
                    }
                    productService.save(product);
                }
                orderItem.setOrder(orderEntity);
                orderItem.setProduct(productService.findById(entry.getValue().getProduct().getId()));
                orderItem.setPrice(entry.getValue().getProduct().getPrice());
                for (PromotionEntity promotion : promotions) {
                    if (!entry.getValue().getProduct().getPromotions().isEmpty()) {
                        for (PromotionEntity promotionProduct : entry.getValue().getProduct().getPromotions()) {
                            if (promotionProduct.getId() == promotion.getId()) {
                                orderItem.setDiscount(promotion.getPercent());
                                entry.getValue().setDiscount(promotion.getPercent());
                            }
                        }
                    }
                }

                orderItem.setQuantity(entry.getValue().getQuantity());
                orderDetailService.save(orderItem);
            }

            List<PaymentEntity> payments = new ArrayList<>();
            PaymentEntity pay = new PaymentEntity();
            pay.setMethod(paymentMethod);
            pay.setOrder(orderEntity);
            pay.setPaymentDate(new Date());
            payments.add(pay);
            paymentService.save(pay);

            //send mail when checkout success
            MimeMessage messagee = emailSender.createMimeMessage();
            boolean multipart = true;
            MimeMessageHelper helper = new MimeMessageHelper(messagee, multipart, "utf-8");
            String htmlMsg = "";
            htmlMsg = "<h3>Order Success</h3>" + "<br><br>" + "Hello " + orderEntity.getFullName() + "<br><br>" + "You successfully ordered your order with your order code: <b>" + orderEntity.getOrderNumber() + "</b><br><br>"
                    + "Click to view order: <b>" + "<a href=\"http://localhost:8080/Spring_MVC_Project_Final/search-orderid?strSearch=" + orderEntity.getOrderNumber() + "\">" + orderEntity.getOrderNumber() + "</a>" + "</b><br><br>" + "Day order:" + orderEntity.getOrderDate() + "<br><br>"
                    + "Payment status: " + showPaymentMethod(paymentMethod) + "<br><br>"
                    + "Total price for your order: $" + orderService.totalPrice(orderItems) + "<br><br>" + "<table style=\"font-family: arial, sans-serif; width: 100%;\n"
                    + "  border-collapse: collapse; \"><tr style=\"border: 1px solid #dddddd; text-align: left; padding: 8px; \">"
                    + "<th style=\"border: 1px solid #dddddd; text-align: left; padding: 8px; \">Name</th>"
                    + "<th style=\"border: 1px solid #dddddd; text-align: left; padding: 8px; \">Price</th>"
                    + "<th style=\"border: 1px solid #dddddd; text-align: left; padding: 8px; \">Discount</th>"
                    + "<th style=\"border: 1px solid #dddddd; text-align: left; padding: 8px; \">Quantity</th>"
                    + "<th style=\"border: 1px solid #dddddd; text-align: left; padding: 8px; \">Sub Total</th></tr>";
            for (Map.Entry<Integer, OrderDetailEntity> entry : orderItems.entrySet()) {
                String temp = "<tr style=\"border: 1px solid #dddddd; text-align: left; padding: 8px; \">"
                        + "<td>" + entry.getValue().getProduct().getProductName() + "</td>"
                        + "<td>$" + entry.getValue().getProduct().getPrice() + "</td>"
                        + "<td>" + entry.getValue().getDiscount() * 100 + "%</td>"
                        + "<td>" + entry.getValue().getQuantity() + "</td>"
                        + "<td>$" + entry.getValue().getQuantity() * entry.getValue().getProduct().getPrice() * (1 - entry.getValue().getDiscount()) + "</td>"
                        + "</tr>";
                htmlMsg = htmlMsg.concat(temp);
            }

            String temp1 = "</table>";
            htmlMsg.concat(temp1);
            messagee.setContent(htmlMsg, "text/html");
            helper.setTo(orderEntity.getEmail());
            helper.setSubject("Order Success!!!");
            this.emailSender.send(messagee);

            //reset session orderItems
            orderItems = new HashMap<>();
            session.setAttribute("cartItems", orderItems);
            session.setAttribute("orderEntityss", orderEntity);
            model.addAttribute("orderEntity", orderEntity);

            model.addAttribute("message", "Checkout successfully");
            model.addAttribute("type", "success");
            return "user/buySs";

        } else {

            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            }
            UserEntity userEntity = userService.findByEmail(username);
            model.addAttribute("userEntity", userEntity);
            model.addAttribute("username", username);
            HashMap<Integer, OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
            model.addAttribute("promotions", promotionService.getPromotionsToDay());
            model.addAttribute("orderEntity", orderEntity);

            OrderEntity orderSession = (OrderEntity) session.getAttribute("orderEntityss");
            session.setAttribute("orderEntityss", orderSession);
            session.setAttribute("cartItems", cartItems);
            session.setAttribute("orderEntityss", orderEntity);

            return "user/payment";
        }

    }

    public int getQuantityOrder(HashMap<Integer, OrderDetailEntity> orderItems) {
        int quantity = 0;
        for (Map.Entry<Integer, OrderDetailEntity> orderDetail : orderItems.entrySet()) {
            quantity += orderDetail.getValue().getQuantity();
        }
        return quantity;
    }

    public String showPaymentMethod(PaymentMethod paymentMethod) {
        if (paymentMethod == PaymentMethod.CASH_ON_DELIVERY) {
            return "Unpaid";
        } else {
            return "Paid";
        }
    }

//       if (paymentMethod == PaymentMethod.CREDIT_CARD) {
//            CreditCartEntity credit = creditCartService.findByCode(code.getCode());
//            if (credit.getBalance() > orderEntity.getTotalPrice()) {
//                credit.setBalance(credit.getBalance() - orderEntity.getTotalPrice());
//                creditCartService.save(credit);
//            } else {
//                model.addAttribute("type", "error");
//                model.addAttribute("message", "lack of money in the account!!");
//                return "redirect:/checkout";
//            }
//        } else {
//
//        }
}
