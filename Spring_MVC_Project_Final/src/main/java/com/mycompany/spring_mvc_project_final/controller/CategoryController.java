/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.enums.ProductStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryService;
import com.mycompany.spring_mvc_project_final.service.ProductService;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {
        StringTrimmerEditor stringTrinEditor = new StringTrimmerEditor(true);
        dataBinder.registerCustomEditor(String.class, stringTrinEditor);
    }

//Show list categories
    @RequestMapping(value = "/categories", method = RequestMethod.GET)
    public String viewCategories(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("products", productService.getProducts());
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("countProducts", productService.countProductByCategor());
        model.addAttribute("username", username);
        return "admin/categories";
    }

//Update Category
    @RequestMapping(value = "/update-category/{id}")
    public String updateCategory(Model model,
            @PathVariable("id") int id) {
        CategoryEntity category = categoryService.findById(id);

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);

        if (category.getId() > 0) {
            model.addAttribute("category", category);
            model.addAttribute("action", "update");
            return "admin/category";
        } else {
            return "redirect:/admin/categories?type=error&message=Not found category id: " + id;
        }
    }

//Add category
    @RequestMapping("/add-category")
    public String showCategoryForm(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        model.addAttribute("category", new CategoryEntity());
        model.addAttribute("action", "add");
        return "admin/category";
    }

    @RequestMapping("/result-category")
    public String category(Model model,
            @Valid @ModelAttribute("category") CategoryEntity category,
            BindingResult result,
            HttpServletRequest request) {
        if (result.hasErrors()) {
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username = principal.toString();
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            }
            model.addAttribute("username", username);
            model.addAttribute("category", category);
            model.addAttribute("action", "add");
            return "admin/category";
        } else {
            categoryService.save(category);
            return "redirect:/admin/categories";
        }
    }

//Change status cate
    @RequestMapping("/category/change-status/{id}")
    public String changeStatusCate(Model model,
            @PathVariable("id") int id) {
        CategoryEntity category = categoryService.findById(id);
        if (category.getStatus() == ProductStatus.ACTIVE) {
            category.setStatus(ProductStatus.DISABLED);
        } else if (category.getStatus() == ProductStatus.DISABLED) {
            category.setStatus(ProductStatus.ACTIVE);
        }

        categoryService.save(category);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        model.addAttribute("username", username);
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("countProducts", productService.countProductByCategor());
        return "admin/categories";
    }
}
