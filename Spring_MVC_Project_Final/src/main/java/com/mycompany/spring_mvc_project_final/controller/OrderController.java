/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.lowagie.text.DocumentException;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.enums.OrderStatus;
import com.mycompany.spring_mvc_project_final.service.OrderService;
import com.mycompany.spring_mvc_project_final.service.ProductService;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private ProductService productService;

    @Autowired
    public JavaMailSender emailSender;

    Date fromDatee = new Date();
    Date toDatee = new Date();
//Show list orders    

    @RequestMapping(value = "/orders", method = RequestMethod.GET)
    public String viewProducts(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message,
            @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
            @RequestParam(name = "size", required = false, defaultValue = "5") Integer size,
            @RequestParam(name = "start", required = false, defaultValue = "0") Integer start,
            @RequestParam(name = "sortBy", required = false, defaultValue = "id") String sortBy) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(sortBy).descending());
        int n = orderService.getOrders().size();
        //setting number page
        if (n % size != 0) {
            model.addAttribute("numberPages", (n / size) + 1);
        } else {
            model.addAttribute("numberPages", (n / size));
        }

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        model.addAttribute("orders", orderService.getOrdersPage(pageable));
        model.addAttribute("orderStatus", getOrderStatus());
        model.addAttribute("page", page);
        model.addAttribute("start", start);
        model.addAttribute("size", 5);
        model.addAttribute("n", n);
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "admin/orders";
    }

    @RequestMapping(value = "/order-detail/{id}")
    public String orderDetail(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message,
            @PathVariable("id") int id) {
        OrderEntity order = orderService.findOrderById(id);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        if (order.getId() > 0) {
            model.addAttribute("order", order);
            model.addAttribute("products", productService.getProducts());
            model.addAttribute("orderStatus", getOrderStatus());
            model.addAttribute("type", type);
            model.addAttribute("message", message);
            return "admin/order-detail";
        } else {
            return "redirect:/admin/orders?type=error&message=Not found order id: " + id;
        }
    }

//Change status order
    @RequestMapping("/order/change-status")
    public String changeStatusProduct(Model model,
            HttpServletRequest request,
            @RequestParam("id") int id,
            @RequestParam("status") OrderStatus status
    ) throws MessagingException {
        String url = request.getHeader("referer");
        OrderEntity order = orderService.findOrderById(id);
        order.setStatus(status);
        orderService.save(order);
        if (status == OrderStatus.CANCEL) {
            //send mail when checkout success
            MimeMessage messagee = emailSender.createMimeMessage();
            boolean multipart = true;
            MimeMessageHelper helper = new MimeMessageHelper(messagee, multipart, "utf-8");
            String htmlMsg = "Your order: " + "<a href=\"http://localhost:8080/Spring_MVC_Project_Final/search-orderid?strSearch=" + order.getOrderNumber() + "\">" + order.getOrderNumber() + "</a>"
                    + " has been successfully canceled!!!";
            messagee.setContent(htmlMsg, "text/html");
            helper.setTo(order.getEmail());
            helper.setSubject("Cancel order success!!!");
            this.emailSender.send(messagee);
        }
        model.addAttribute("type", "success");
        model.addAttribute("message", "Change status success!!");
        return "redirect:" + url;
    }

//Search order
    @RequestMapping(value = "/search-order", method = RequestMethod.GET)
    public String searchOrder(Model model,
            @ModelAttribute("strSearch") String strSearch) {
        if (strSearch.equals("")) {
            model.addAttribute("orderStatus", getOrderStatus());
            return "redirect:/admin/orders";
        }
        //setting number page
        model.addAttribute("numberPages", 1);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("orders", orderService.searchOrdersByOrderNumber(strSearch));
        model.addAttribute("username", username);
        model.addAttribute("strSearch", strSearch);
        model.addAttribute("orderStatus", getOrderStatus());
        return "admin/orders";
    }

    //Search order by date
    @RequestMapping(value = "/search-order-date", method = RequestMethod.GET)
    public String searchOrderByDate(Model model,
            HttpServletRequest request,
            @RequestParam("fromDate") String fromDate,
            @RequestParam("toDate") String toDate) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String url = request.getHeader("referer");

        fromDatee = simpleDateFormat.parse(fromDate);
        toDatee = simpleDateFormat.parse(toDate);
        if (fromDatee.compareTo(toDatee) > 0) {
            model.addAttribute("type", "error");
            model.addAttribute("message", "Fail!! toDate before fromDate!! ");
            return "redirect:" + url;
        } else {
            //setting number page
            model.addAttribute("numberPages", 1);
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username = principal.toString();
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            }
            model.addAttribute("orders", orderService.searchOrdersByDate(fromDatee, toDatee));
            model.addAttribute("username", username);
            model.addAttribute("fromDate", fromDate);
            model.addAttribute("toDate", toDate);
            model.addAttribute("orderStatus", getOrderStatus());
            return "admin/orders";
        }
    }

    @RequestMapping(value = "/export-file")
    public void exportToPDF(HttpServletResponse response) throws DocumentException, IOException, ParseException {

        response.setContentType("application/pdf");
        DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());

        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=order_" + currentDateTime + ".pdf";
        response.setHeader(headerKey, headerValue);

        List<OrderEntity> orders = orderService.searchOrdersByDate(fromDatee, toDatee);

        OrderPDFExporter exporter = new OrderPDFExporter(orders);
        exporter.export(response);
    }
    //get order status

    public List<String> getOrderStatus() {
        List<String> orderStatus = new ArrayList<>();
        orderStatus.add(OrderStatus.PENDING.toString());
        orderStatus.add(OrderStatus.COMFIRM.toString());
        orderStatus.add(OrderStatus.SHIPPING.toString());
        orderStatus.add(OrderStatus.COMPLETED.toString());
        orderStatus.add(OrderStatus.CANCEL.toString());

        return orderStatus;
    }

}
