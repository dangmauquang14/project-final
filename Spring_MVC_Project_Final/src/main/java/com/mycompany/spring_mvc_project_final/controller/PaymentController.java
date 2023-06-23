/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.CreditCartEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.enums.PaymentMethod;
import com.mycompany.spring_mvc_project_final.enums.PaymentStatus;
import com.mycompany.spring_mvc_project_final.service.CreditCartService;
import com.mycompany.spring_mvc_project_final.service.OrderDetailService;
import com.mycompany.spring_mvc_project_final.service.OrderService;
import com.mycompany.spring_mvc_project_final.service.PaymentService;
import com.mycompany.spring_mvc_project_final.service.ProductService;
import com.mycompany.spring_mvc_project_final.service.PromotionService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PaymentController {

    @Autowired
    private CreditCartService creditCartService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    public JavaMailSender emailSender;

    @Autowired
    public ProductService productService;

    @Autowired
    public PaymentService paymentService;

    @Autowired
    public UserService userService;

    @Autowired
    public PromotionService promotionService;

    @RequestMapping(value = "/payment", method = RequestMethod.GET)
    public String payment(Model model, HttpSession session,
            @ModelAttribute("paymentCart") CreditCartEntity creditCartEntity) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        UserEntity userEntity = userService.findByEmail(username);
        HashMap<Integer, OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");

        model.addAttribute("userEntity", userEntity);
        model.addAttribute("username", username);
        model.addAttribute("promotions", promotionService.getPromotionsToDay());
        OrderEntity orderSession = (OrderEntity) session.getAttribute("orderEntityss");
        session.setAttribute("orderEntityss", orderSession);
        session.setAttribute("cartItems", cartItems);

        return "user/payment";
    }

    @RequestMapping(value = "/payment", method = RequestMethod.POST)
    public String paymentCart(Model model, HttpSession session,
            @ModelAttribute("paymentCart") CreditCartEntity creditCartEntity,
            @RequestParam("paymentMethod") PaymentMethod paymentMethod) throws Exception, ParseException, MessagingException {
        String message = "";
        String type = "";
//        OrderEntity orderSession = (OrderEntity) session.getAttribute("orderEntityss");
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        UserEntity userEntity = userService.findByEmail(username);
        model.addAttribute("userEntity", userEntity);

//      truyen gia voi code vao
        HashMap<Integer, OrderDetailEntity> orderItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        OrderEntity orderEntity = (OrderEntity) session.getAttribute("orderEntityss");

//        ApplicationContext context = new AnnotationConfigApplicationContext(JPAConfig.class);
//        CreditCartService creditCartServices = (CreditCartService) context.getBean("creditCartServices");
        CreditCartEntity cartEntity1 = creditCartService.findByCode(creditCartEntity.getCode());
        if (cartEntity1 == null) {
            orderItems = new HashMap<>();
            type = "fail";
            message = "Not found card.!!";
            model.addAttribute("message", message);
            model.addAttribute("type", type);

            model.addAttribute("userEntity", userEntity);
            HashMap<Integer, OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
            model.addAttribute("promotions", promotionService.getPromotionsToDay());
            model.addAttribute("orderEntity", orderEntity);

            OrderEntity orderSession = (OrderEntity) session.getAttribute("orderEntityss");
            session.setAttribute("orderEntityss", orderSession);
            session.setAttribute("cartItems", cartItems);
            session.setAttribute("orderEntityss", orderEntity);

            return "user/payment";
        }
        try {
            creditCartService.transferMoney(orderService.totalPrice(orderItems), creditCartEntity.getCode());
        } catch (Exception ex) {
            type = "fail";
            message = ex.getMessage();
            model.addAttribute("message", message);
            model.addAttribute("type", type);
            return "user/buyf";
        }
//        boolean cartPrice = creditCartTransaction.transferMoney(getTotalPriceOrder(orderItems), creditCartEntity.getCode());
//        if (cartPrice == true) {
//        set quatityOrdet and totalPriceOrder
        UUID uuid = UUID.randomUUID();
        orderEntity.setOrderNumber(uuid.toString());
        orderEntity.setQuantity(getQuantityOrder(orderItems));
        orderEntity.setTotalPrice(orderService.totalPrice(orderItems));
        orderEntity.setOrderDate(new Date());
        if (userEntity != null) {
            orderEntity.setAccount(userService.findByEmail(username));
            orderEntity.setAddress(userEntity.getAddress());
            orderEntity.setEmail(userEntity.getEmail());
            orderEntity.setFullName(userEntity.getFullName());
            orderEntity.setPhoneNumber(userEntity.getPhoneNumber());
        } else {
            orderEntity.setAddress(orderEntity.getAddress());
            orderEntity.setEmail(orderEntity.getEmail());
            orderEntity.setFullName(orderEntity.getFullName());
            orderEntity.setPhoneNumber(orderEntity.getPhoneNumber());
        }

        orderService.save(orderEntity);

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
            orderItem.setProduct(entry.getValue().getProduct());
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
        CreditCartEntity cartEntity = creditCartService.findByCode(creditCartEntity.getCode());
        creditCartService.save(cartEntity);

        //PAYMENT_ORDER
        List<PaymentEntity> payments = new ArrayList<>();
        PaymentEntity pay = new PaymentEntity();
        pay.setMethod(paymentMethod);
        pay.setOrder(orderEntity);
        pay.setPaymentDate(new Date());
        pay.setStatus(PaymentStatus.PAYMENT_ORDER);
        pay.setCreditCart(cartEntity);
        pay.setAmount(getTotalPriceOrder(orderItems));
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

        model.addAttribute("username", username);
        return "user/buySs";

//        } else {
//            type = "fail";
//            message = "delete fail Not found product";
//            model.addAttribute("message", message);
//            model.addAttribute("type", type);
//            return "redirect:/403";
//        }
    }

    public int getQuantityOrder(HashMap<Integer, OrderDetailEntity> orderItems) {
        int quantity = 0;
        for (Map.Entry<Integer, OrderDetailEntity> orderDetail : orderItems.entrySet()) {
            quantity += orderDetail.getValue().getQuantity();
        }
        return quantity;
    }

    public double getTotalPriceOrder(HashMap<Integer, OrderDetailEntity> orderItems) {
        double totalPrice = 0;
        for (Map.Entry<Integer, OrderDetailEntity> orderDetail : orderItems.entrySet()) {
            totalPrice += (orderDetail.getValue().getProduct().getPrice() * orderDetail.getValue().getQuantity());
        }
        return totalPrice;
    }

    public String showPaymentMethod(PaymentMethod paymentMethod) {
        if (paymentMethod == PaymentMethod.CREDIT_CARD) {
            return "Paid";
        } else {
            return "Unpaid";
        }
    }
}
