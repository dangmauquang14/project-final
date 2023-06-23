/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.enums.OrderStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryService;
import com.mycompany.spring_mvc_project_final.service.FavoriteService;
import com.mycompany.spring_mvc_project_final.service.OrderService;
import com.mycompany.spring_mvc_project_final.service.ProductService;
import com.mycompany.spring_mvc_project_final.service.PromotionService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import com.mycompany.spring_mvc_project_final.utils.SecurityUtils;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private OrderService orderService;

    @Autowired
    public JavaMailSender emailSender;

    @Autowired
    public FavoriteService favoriteService;

    @Autowired
    public UserService userService;

    @Autowired
    public PromotionService promotionService;

    @RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
    public String welcomePage(Model model,
            HttpSession session,
            @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
            @RequestParam(name = "size", required = false, defaultValue = "8") Integer size
    ) {
//        model.addAttribute("title", "Welcome");
        List<String> roles = SecurityUtils.getRolesOfUser();
        if (!CollectionUtils.isEmpty(roles) && (roles.contains("ROLE_ADMIN")
                || roles.contains("ROLE_SELLER") || roles.contains("ROLE_MANAGER"))) {
            return "redirect:/admin/home";
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username);
            model.addAttribute("favorites", favoriteService.findByAccountId(userEntity.getId()));
        }

        HashMap<Integer, OrderDetailEntity> cartItems
                = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new HashMap<>();
        } else {
            for (Map.Entry<Integer, OrderDetailEntity> entry : cartItems.entrySet()) {
                entry.getValue().setProduct(productService.findById(entry.getValue().getProduct().getId()));
            }
        }
        Pageable pageable = PageRequest.of(page, size);

        model.addAttribute("username", username);
        model.addAttribute("products", productService.getProductsActiveSort(pageable));
        model.addAttribute("page", page);
        model.addAttribute("size", 8);
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("countProducts", productService.countProductByCategor());
        model.addAttribute("promotions", promotionService.getPromotionsToDay());
        session.setAttribute("cartItems", cartItems);
        return "home";
    }

    @RequestMapping("/login")
    public String loginPage(Model model, @RequestParam(value = "error", required = false) boolean error) {

        if (error) {
            model.addAttribute("message", "Email or Password is incorrect!!!");
        }
        return "login";
    }

    @RequestMapping("/productdetail/{id}/{idCate}")
    public String productDetail(Model model,
            HttpSession session,
            @PathVariable("id") int id,
            @PathVariable("idCate") int idCate) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();

        HashMap<Integer, OrderDetailEntity> cartItems
                = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new HashMap<>();
        }
        session.setAttribute("cartItems", cartItems);

        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username);
            model.addAttribute("favorites", favoriteService.findByAccountId(userEntity.getId()));
        }
        model.addAttribute("username", username);
        model.addAttribute("products", productService.searchProductsByCateAcitveNo(idCate));

        ProductEntity product = productService.findById(id);
        if (product.getId() > 0) {
            model.addAttribute("product", product);
            model.addAttribute("promotions", promotionService.getPromotionsToDay());
            return "user/detailProduct";
        } else {
            return "redirect:/home?type=error&message=Not found product id: " + id;
        }

    }

    @RequestMapping(value = "/viewproduct/{id}")
    public String searchProductByCategory(Model model,
            @PathVariable("id") int id,
            @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
            @RequestParam(name = "size", required = false, defaultValue = "6") Integer size,
            @RequestParam(name = "start", required = false, defaultValue = "0") Integer start) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username);
            model.addAttribute("favorites", favoriteService.findByAccountId(userEntity.getId()));
        }

        int n = productService.getSizeProduct(productService.searchProductsByCate(id));
        Pageable pageables = PageRequest.of(page, size);
        if (n % size != 0) {
            model.addAttribute("numberPages", (n / size) + 1);
        } else {
            model.addAttribute("numberPages", (n / size));
        }
//loi chua phan trang theo id category duoc
        model.addAttribute("countProducts", productService.countProductByCategor());
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("username", username);
        model.addAttribute("products", productService.searchProductsByCateAcitve(id, pageables));
        model.addAttribute("promotions", promotionService.getPromotionsToDay());

        model.addAttribute("page", page);
        model.addAttribute("start", start);
        model.addAttribute("size", 6);
        model.addAttribute("n", n);

        return "user/viewProduct";

    }

    @RequestMapping(value = "/viewproduct")
    public String viewAllProduct(Model model,
            HttpSession session,
            @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
            @RequestParam(name = "size", required = false, defaultValue = "6") Integer size,
            @RequestParam(name = "start", required = false, defaultValue = "0") Integer start) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username);
            model.addAttribute("favorites", favoriteService.findByAccountId(userEntity.getId()));
        }

        int n = productService.getSizeProduct(productService.getProducts());
        Pageable pageable = PageRequest.of(page, size);
        if (n % size != 0) {
            model.addAttribute("numberPages", (n / size) + 1);
        } else {
            model.addAttribute("numberPages", (n / size));
        }
        HashMap<Integer, OrderDetailEntity> cartItems
                = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new HashMap<>();
        }
        session.setAttribute("cartItems", cartItems);
        model.addAttribute("promotions", promotionService.getPromotionsToDay());
        model.addAttribute("countProducts", productService.countProductByCategor());
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("username", username);
        model.addAttribute("products", productService.getProductsActive(pageable));
        model.addAttribute("productPromotion", getProductPromotion(productService.getProductsActive(pageable)));
        model.addAttribute("page", page);
        model.addAttribute("start", start);
        model.addAttribute("size", 6);
        model.addAttribute("n", n);

        return "user/viewProduct";

    }

    public List<ProductEntity> getProductPromotion(List<ProductEntity> products) {
        List<ProductEntity> productsn = new ArrayList<>();
        for (ProductEntity product : products) {
            for (PromotionEntity promotion : product.getPromotions()) {
                Date date = new Date();
                if (promotion.getStartDate().compareTo(date) * date.compareTo(promotion.getEndDate()) > 0) {
                    productsn.add(product);
                }
            }
        }
        return productsn;
    }

    //Search product
    @RequestMapping(value = "/search-here", method = RequestMethod.GET)
    public String searchProduct(Model model,
            @ModelAttribute("strSearch") String strSearch) {
        String message = "";
        String type = "";

        if (strSearch.equals("")) {
            type = "fail";
            message = "Not found product..!";
            return "redirect:/viewProduct";

        }
        //setting number page
        model.addAttribute("numberPages", 1);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("strSearch", strSearch);
        model.addAttribute("username", username);
        model.addAttribute("promotions", promotionService.getPromotionsToDay());
        model.addAttribute("products", productService.searchProducts(strSearch));
        model.addAttribute("countProducts", productService.countProductByCategor());
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("message", message);
        model.addAttribute("type", type);
        return "user/viewProduct";
    }

    //get managerOder page
    @RequestMapping(value = "/manager-oder")
    public String getManagerOrder(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();

        }
        model.addAttribute("promotions", promotionService.getPromotionsToDay());
        model.addAttribute("orders", orderService.findOrdersByAccount(username));
        model.addAttribute("username", username);

        return "user/managerOder";
    }

//get search-orderUuid page
    @RequestMapping(value = "/search-orderUuid")
    public String getsearchOrderUuid() {
        return "user/searchOrderUuid";
    }

    //Search order
    @RequestMapping(value = "/search-orderid")
    public String searchOrder(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message,
            @RequestParam("strSearch") String strSearch) {
        if (strSearch.equals("")) {
            model.addAttribute("type", "error");
            model.addAttribute("message", "Not found!!");
            return "redirect:/view-cart";
        }
        //setting number page
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        model.addAttribute("promotions", promotionService.getPromotionsToDay());
        model.addAttribute("orders", orderService.searchOrdersByOrderNumber(strSearch));
        model.addAttribute("username", username);
        model.addAttribute("strSearch", strSearch);
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "user/searchUuid";
    }

//get order
    @RequestMapping(value = "/get-orderid/{strSearch}")
    public String getOrder(Model model,
            @PathVariable("strSearch") String uuid
    ) {
        List<OrderEntity> order = orderService.searchOrdersByOrderNumber(uuid);

        //setting number page
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        model.addAttribute("username", username);
        model.addAttribute("orders", order);
        model.addAttribute("strSearch", uuid);

        return "redirect:/search-orderid";
    }

    @RequestMapping(value = "/about-us")
    public String aboutUs(Model model) {
        return "user/aboutUs";
    }

    //Change status cancel order
    @RequestMapping(value = "/order-cancel/{id}")
    public String changeStatusProduct(Model model,
            @PathVariable("id") int id) throws MessagingException {
        String message = "";
        String type = "";
        OrderEntity order = orderService.findOrderById(id);
        List<OrderEntity> orders = new ArrayList<>();
        orders.add(order);
        order.setStatus(OrderStatus.CANCEL);
        orderService.save(order);

        //send mail when click cancel
        model.addAttribute("promotions", promotionService.getPromotionsToDay());
        MimeMessage messagee = emailSender.createMimeMessage();
        boolean multipart = true;
        MimeMessageHelper helper = new MimeMessageHelper(messagee, multipart, "utf-8");
        String htmlMsg = "";
        htmlMsg = "<h3>You cancel order  Success</h3>" + "<br><br>" + "Click here to view status order: "
                + "<a href=\"http://localhost:8080/Spring_MVC_Project_Final/search-orderid?strSearch=" + order.getOrderNumber() + "\">" + order.getOrderNumber() + "</a>";

        messagee.setContent(htmlMsg, "text/html");
        helper.setTo(order.getEmail());
        helper.setSubject("Cancel order!!!");
        this.emailSender.send(messagee);
        type = "success";
        message = "Cancel success, check mail for details!!";
        model.addAttribute("message", message);
        model.addAttribute("type", type);

        model.addAttribute("orders", orders);
        return "user/searchUuid";
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

    @RequestMapping("/403")
    public String accessDenied(Model model) {
        return "403Page";
    }
}
