/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.FavoriteEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.service.CategoryService;
import com.mycompany.spring_mvc_project_final.service.FavoriteService;
import com.mycompany.spring_mvc_project_final.service.ProductService;
import com.mycompany.spring_mvc_project_final.service.PromotionService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

/**
 *
 * @author nguye
 */
@Controller
public class FavoriteController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private FavoriteService favoriteService;

    @Autowired
    public PromotionService promotionService;

    @Autowired
    private CategoryService categoryService;

    @RequestMapping(value = "/user/add-favorie/{id}", method = RequestMethod.GET)
    public String addFavorite(Model model, @PathVariable("id") int id,
            HttpServletRequest request) {
        String url = request.getHeader("referer");

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        ProductEntity product = productService.findById(id);
        UserEntity userEntity = userService.findByEmail(username);

        List<FavoriteEntity> favorites = new ArrayList<>();
        FavoriteEntity favoriteEntity = new FavoriteEntity();
        favoriteEntity.setAccount(userEntity);
        favoriteEntity.setProduct(product);
        favorites.add(favoriteEntity);

        favoriteService.save(favoriteEntity);

        return "redirect:" + url;
    }

    @RequestMapping(value = "/user/delete-favorie/{id}", method = RequestMethod.GET)
    public String deleteFavorite(Model model, @PathVariable("id") int id,
            HttpServletRequest request) {
        String url = request.getHeader("referer");
        favoriteService.delete(id);
        return "redirect:" + url;
    }

    @RequestMapping(value = "/viewFavorite")
    public String viewAllFavorite(Model model,
            HttpSession session
    ) {
        HashMap<Integer, OrderDetailEntity> cartItems
                = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new HashMap<>();
        }
        session.setAttribute("cartItems", cartItems);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username);
            model.addAttribute("favorites", favoriteService.findByAccountId(userEntity.getId()));
        }
        model.addAttribute("username", username);
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("products", productService.getProductsActivee());
        model.addAttribute("promotions", promotionService.getPromotionsToDay());

        return "user/viewFavorite";

    }
}
