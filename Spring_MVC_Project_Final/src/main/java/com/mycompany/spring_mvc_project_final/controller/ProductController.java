/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.enums.ProductStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryService;
import com.mycompany.spring_mvc_project_final.service.ImageService;
import com.mycompany.spring_mvc_project_final.service.ProductService;
import com.mycompany.spring_mvc_project_final.service.PromotionService;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author NhatHuu
 */
@Controller
@RequestMapping("/admin")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ImageService imageService;

    @Autowired
    private PromotionService promotionService;

    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {
        StringTrimmerEditor stringTrinEditor = new StringTrimmerEditor(true);
        dataBinder.registerCustomEditor(String.class, stringTrinEditor);
    }

//Show list products    
    @RequestMapping(value = "/product-list", method = RequestMethod.GET)
    public String viewProducts(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message,
            @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
            @RequestParam(name = "size", required = false, defaultValue = "5") Integer size,
            @RequestParam(name = "start", required = false, defaultValue = "0") Integer start,
            @RequestParam(name = "sortBy", required = false, defaultValue = "id") String sortBy) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(sortBy).descending());
        int n = productService.getProductsActivee().size();
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
        model.addAttribute("products", productService.getProductsPage(pageable));
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("page", page);
        model.addAttribute("start", start);
        model.addAttribute("size", 5);
        model.addAttribute("n", n);
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "admin/product-list";
    }
//update product

    @RequestMapping(value = "/update-product/{id}")
    public String updateProduct(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message,
            @PathVariable("id") int id) {
        ProductEntity product = productService.findById(id);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);

        if (product.getId() > 0) {
            model.addAttribute("product", product);
            model.addAttribute("categories", categoryService.getCategories());
            model.addAttribute("promotions", promotionService.getPromotions());
            model.addAttribute("action", "update");
            model.addAttribute("type", type);
            model.addAttribute("message", message);
            return "admin/product";
        } else {
            return "redirect:/admin/product-list?type=error&message=Not found product id: " + id;
        }
    }
//add product

    @RequestMapping("/add-product")
    public String showProductForm(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        model.addAttribute("product", new ProductEntity());
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("promotions", promotionService.getPromotions());
        model.addAttribute("action", "add");
        return "admin/product";
    }

    @RequestMapping("/result")
    public String product(Model model,
            HttpServletRequest request,
            @Valid @ModelAttribute("product") ProductEntity product, BindingResult result,
            @RequestParam("file") MultipartFile[] files,
            @RequestParam("action") String action) {
        if (result.hasErrors()) {
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username = principal.toString();
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            }
            model.addAttribute("username", username);
            model.addAttribute("product", product);
            model.addAttribute("categories", categoryService.getCategories());
            model.addAttribute("promotions", promotionService.getPromotions());
            model.addAttribute("action", action);

            return "admin/product";
        } else {
            productService.save(product);
            List<String> fileList = uploadFiles(request, files);
            if (fileList != null) {
                for (String fileName : fileList) {
                    if (!fileName.equalsIgnoreCase("")) {
                        ImageEntity image = new ImageEntity();
                        image.setImageName(fileName);
                        image.setProduct(product);
                        imageService.save(image);
                    }
                }
            }
            return "redirect:/admin/product-list";
        }
    }

//Remove img of product
    @RequestMapping(value = "/remove-img/{id}", method = RequestMethod.POST)
    public String deleteImage(Model model,
            HttpServletRequest request,
            @PathVariable("id") int id,
            @RequestParam("id") int productId,
            @ModelAttribute("product") ProductEntity product) {
        String url = request.getHeader("referer");
        ImageEntity image = imageService.findImageById(id);
        if (image.getId() > 0) {
            if (!imageService.delete(id)) {
                return "redirect:" + url + "?type=success&message=Remove Image Success!!";
            } else {
                return "redirect:" + url + "?type=error&message=Remove Image fail!!";
            }
        } else {
            return "redirect:" + url + "?type=error&message=Not found Image id: " + id;
        }
    }

//Change status product
    @RequestMapping("/product/change-status/{id}")
    public String changeStatusProduct(Model model,
            HttpServletRequest request,
            @PathVariable("id") int id
    ) {
        String url = request.getHeader("referer");
        ProductEntity product = productService.findById(id);
        if (product.getStatus() == ProductStatus.ACTIVE) {
            product.setStatus(ProductStatus.DISABLED);
        } else if (product.getStatus() == ProductStatus.DISABLED) {
            product.setStatus(ProductStatus.ACTIVE);
        }
        productService.save(product);

        return "redirect:" + url;
    }

//Search product
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String searchProduct(Model model,
            @ModelAttribute("strSearch") String strSearch) {
        if (strSearch.equals("")) {
            return "redirect:/admin/product-list";
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
        model.addAttribute("products", productService.searchProducts(strSearch));
        model.addAttribute("categories", categoryService.getCategories());
        return "admin/product-list";
    }

//Search category
    @RequestMapping(value = "/search-cate/{id}")
    public String searchCate(Model model,
            @PathVariable("id") int id) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        model.addAttribute("products", productService.searchProductsByCate(id));
        model.addAttribute("categories", categoryService.getCategories());
        //setting number page
        model.addAttribute("numberPages", 1);
        return "admin/product-list";

    }

    public List<String> uploadFiles(
            HttpServletRequest request,
            @RequestParam("file") MultipartFile[] files) {

        List<String> fileList = new ArrayList<>();
        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            try {
                byte[] bytes = file.getBytes();

                ServletContext context = request.getServletContext();
                String pathUrl = context.getRealPath("/images");
                int index = pathUrl.indexOf("target");
                String pathFolder = pathUrl.substring(0, index) + "src\\main\\webapp\\resources\\img\\product\\";
                Path path = Paths.get(pathFolder + file.getOriginalFilename());
                Files.write(path, bytes);

                String name = file.getOriginalFilename();
                fileList.add(name);
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return fileList;
    }
}
