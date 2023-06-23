/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.enums.ProductStatus;
import com.mycompany.spring_mvc_project_final.service.ImageService;
import com.mycompany.spring_mvc_project_final.service.ProductService;
import com.mycompany.spring_mvc_project_final.service.PromotionService;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/admin")
public class PromotionsController {

    @Autowired
    private ProductService productService;

    @Autowired
    private ImageService imageService;

    @Autowired
    private PromotionService promotionService;

    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {
        StringTrimmerEditor stringTrinEditor = new StringTrimmerEditor(true);
        dataBinder.registerCustomEditor(String.class, stringTrinEditor);
    }

//Show list promotions    
    @RequestMapping(value = "/promotions", method = RequestMethod.GET)
    public String viewPromotions(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message,
            @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
            @RequestParam(name = "size", required = false, defaultValue = "5") Integer size,
            @RequestParam(name = "start", required = false, defaultValue = "0") Integer start,
            @RequestParam(name = "sortBy", required = false, defaultValue = "id") String sortBy) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(sortBy).descending());
        int n = promotionService.getPromotions().size();
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
        model.addAttribute("promotions", promotionService.getPromotionsPage(pageable));
        model.addAttribute("page", page);
        model.addAttribute("start", start);
        model.addAttribute("size", 5);
        model.addAttribute("n", n);
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "admin/promotions";
    }

//update promotion
    @RequestMapping(value = "/update-promotion/{id}")
    public String updatePromotion(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message,
            @PathVariable("id") int id) {
        PromotionEntity promotion = promotionService.finById(id);

        if (promotion.getId() > 0) {
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username = principal.toString();
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            }
            model.addAttribute("username", username);
            model.addAttribute("promotion", promotion);
            model.addAttribute("products", productService.getProductsS(productService.getProductsActivee(), promotion));
            model.addAttribute("action", "update");
            model.addAttribute("type", type);
            model.addAttribute("message", message);
            return "admin/promotion";
        } else {
            return "redirect:/admin/promotions?type=error&message=Not found promotion id: " + id;
        }
    }

//add promotion
    @RequestMapping("/add-promotion")
    public String showPromotionForm(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        model.addAttribute("promotion", new PromotionEntity());
        model.addAttribute("products", productService.getProductsActivee());
        model.addAttribute("action", "add");
        return "admin/promotion";
    }

    @RequestMapping("/promotion/result")
    public String promotion(Model model,
            @ModelAttribute("promotion") PromotionEntity promotion,
            HttpServletRequest request,
            @RequestParam("file") MultipartFile[] files) {
        String url = request.getHeader("referer");
        if (promotion.getStartDate().compareTo(promotion.getEndDate()) > 0) {
            model.addAttribute("type", "error");
            model.addAttribute("message", "Fail!! EndDate before StartDate!! ");
            return "redirect:" + url;
        } else {
            String[] productIds = request.getParameterValues("product");
            if (productIds != null) {
                Set<ProductEntity> products = new HashSet<>();
                Set<PromotionEntity> promotions = new HashSet<>();
                promotions.add(promotion);
                for (int i = 0; i < productIds.length; i++) {
                    ProductEntity product
                            = productService.findById(Integer.valueOf(productIds[i]));
                    product.setPromotions(promotions);
                    products.add(product);
                }
                promotion.setProducts(products);
            }
            if (productService.checkPromotion2(promotion, productService.getProductsActivee())) {
                promotionService.save(promotion);
                List<String> fileList = uploadFiles(request, files);
                if (fileList != null) {
                    for (String fileName : fileList) {
                        if (!fileName.equalsIgnoreCase("")) {
                            ImageEntity image = new ImageEntity();
                            image.setImageName(fileName);
                            image.setPromotion(promotion);
                            imageService.save(image);
                        }
                    }
                }
                return "redirect:/admin/promotions";
            } else {
                model.addAttribute("type", "error");
                model.addAttribute("message", "Fail!! The product you choose has a promotion!! ");
                model.addAttribute("products", productService.getProductsS(productService.getProductsActivee(), promotion));
                model.addAttribute("action", "add");
                Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                String username = principal.toString();
                if (principal instanceof UserDetails) {
                    username = ((UserDetails) principal).getUsername();
                }
                model.addAttribute("username", username);
                return "admin/promotion";
            }
        }
    }

//Remove img of promotion
    @RequestMapping(value = "/promotion/remove-imgg/{id}", method = RequestMethod.POST)
    public String deleteImage(Model model,
            @PathVariable("id") int id,
            @RequestParam("id") int promotionId,
            @ModelAttribute("promotion") PromotionEntity promotion) {
        ImageEntity image = imageService.findImageById(id);
        if (image.getId() > 0) {
            if (!imageService.delete(id)) {
                return "redirect:/admin/update-promotion/" + promotionId + "?type=success&message=Remove Image Success!!";
            } else {
                return "redirect:/admin/update-promotion/" + promotionId + "?type=error&message=Remove Image fail!!";
            }
        } else {
            return "redirect:/admin/update-promotion/" + promotionId + "?type=error&message=Not found Image id: " + id;
        }
    }

//Change status promotion
    @RequestMapping("/promotion/change-status/{id}")
    public String changeStatusPromotion(Model model,
            HttpServletRequest request,
            @PathVariable("id") int id
    ) {
        String url = request.getHeader("referer");
        PromotionEntity promotion = promotionService.finById(id);
        if (promotion.getStatus() == ProductStatus.ACTIVE) {
            promotion.setStatus(ProductStatus.DISABLED);
        } else if (promotion.getStatus() == ProductStatus.DISABLED) {
            promotion.setStatus(ProductStatus.ACTIVE);
        }
        promotionService.save(promotion);

        return "redirect:" + url;
    }

//Search promotion
    @RequestMapping(value = "promotion/searchPromotions", method = RequestMethod.GET)
    public String searchPromotion(Model model,
            @ModelAttribute("strSearch") String strSearch) {
        if (strSearch.equals("")) {
            return "redirect:/admin/promotions";
        }
        //setting number page
        model.addAttribute("numberPages", 1);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        model.addAttribute("strSearch", strSearch);
        model.addAttribute("promotions", promotionService.searchPromotions(strSearch));
        return "admin/promotions";
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
                String pathFolder = pathUrl.substring(0, index) + "src\\main\\webapp\\resources\\img\\promotions\\";
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
