/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.enums.ProductStatus;
import com.mycompany.spring_mvc_project_final.repository.ProductRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Transactional
    public List<ProductEntity> getProducts() {
        List<ProductEntity> products = (List<ProductEntity>) productRepository.findAll();
        for (ProductEntity product : products) {
            Hibernate.initialize(product.getImages());
            Hibernate.initialize(product.getFavorites());
            Hibernate.initialize(product.getOrderDetails());
            Hibernate.initialize(product.getPromotions());
        }
        return (List<ProductEntity>) products;
    }

    @Transactional
    public List<ProductEntity> getProductsPage(Pageable pageable) {
        List<ProductEntity> products = (List<ProductEntity>) productRepository.findProducts(pageable);
        for (ProductEntity product : products) {
            Hibernate.initialize(product.getImages());
            Hibernate.initialize(product.getFavorites());
            Hibernate.initialize(product.getOrderDetails());
            Hibernate.initialize(product.getPromotions());
        }
        return (List<ProductEntity>) products;
    }

    @Transactional
    public ProductEntity findById(int id) {
        Optional<ProductEntity> product = productRepository.findById(id);
        if (product.isPresent()) {
            ProductEntity productEntity = product.get();
            Hibernate.initialize(productEntity.getImages());
            Hibernate.initialize(productEntity.getFavorites());
            Hibernate.initialize(productEntity.getOrderDetails());
            Hibernate.initialize(productEntity.getPromotions());
            return productEntity;
        } else {
            return new ProductEntity();
        }
    }

    public void save(ProductEntity product) {
        productRepository.save(product);
    }

    @Transactional
    public List<ProductEntity> searchProducts(String strSearch) {
        List<ProductEntity> products = (List<ProductEntity>) productRepository.findByProductNameContaining(strSearch);
        for (ProductEntity product : products) {
            Hibernate.initialize(product.getImages());
            Hibernate.initialize(product.getFavorites());
            Hibernate.initialize(product.getOrderDetails());
            Hibernate.initialize(product.getPromotions());
        }
        return (List<ProductEntity>) products;
    }

    @Transactional
    public List<ProductEntity> searchProductsByCate(int idCate) {
        List<ProductEntity> products = (List<ProductEntity>) productRepository.findProductByCategory(idCate);
        for (ProductEntity product : products) {
            Hibernate.initialize(product.getImages());
            Hibernate.initialize(product.getFavorites());
            Hibernate.initialize(product.getOrderDetails());
            Hibernate.initialize(product.getPromotions());
        }
        return (List<ProductEntity>) products;
    }

    public List<Integer> countProductByCategor() {
        return productRepository.countProductByCategory();
    }

    @Transactional
    public List<ProductEntity> searchProductsByCateAcitve(int idCategory, Pageable pageable) {
        List<ProductEntity> products = (List<ProductEntity>) productRepository.findProductByCategoryActive(idCategory, pageable);
        for (ProductEntity product : products) {
            Hibernate.initialize(product.getImages());
            Hibernate.initialize(product.getFavorites());
            Hibernate.initialize(product.getOrderDetails());
            Hibernate.initialize(product.getPromotions());
        }
        return (List<ProductEntity>) products;
    }

    @Transactional
    public List<ProductEntity> searchProductsByCateAcitveNo(int idCategory) {
        List<ProductEntity> products = (List<ProductEntity>) productRepository.findProductByCategoryActiveNo(idCategory);
        for (ProductEntity product : products) {
            Hibernate.initialize(product.getImages());
            Hibernate.initialize(product.getFavorites());
            Hibernate.initialize(product.getOrderDetails());
            Hibernate.initialize(product.getPromotions());
        }
        return (List<ProductEntity>) products;
    }

    @Transactional
    public List<ProductEntity> getProductsActiveSort(Pageable pageable) {
        List<ProductEntity> products = (List<ProductEntity>) productRepository.findProductActiveSort(pageable);
        for (ProductEntity product : products) {
            Hibernate.initialize(product.getImages());
            Hibernate.initialize(product.getFavorites());
            Hibernate.initialize(product.getOrderDetails());
            Hibernate.initialize(product.getPromotions());
        }
        return (List<ProductEntity>) products;
    }

    @Transactional
    public List<ProductEntity> getProductsActive(Pageable pageable) {
        List<ProductEntity> products = (List<ProductEntity>) productRepository.findProductActive(pageable);
        for (ProductEntity product : products) {
            Hibernate.initialize(product.getImages());
            Hibernate.initialize(product.getFavorites());
            Hibernate.initialize(product.getOrderDetails());
            Hibernate.initialize(product.getPromotions());
        }
        return (List<ProductEntity>) products;
    }
//Get all product active

    @Transactional
    public List<ProductEntity> getProductsActivee() {
        List<ProductEntity> products = (List<ProductEntity>) productRepository.findProductsActivee();
        for (ProductEntity product : products) {
            Hibernate.initialize(product.getImages());
            Hibernate.initialize(product.getFavorites());
            Hibernate.initialize(product.getOrderDetails());
            Hibernate.initialize(product.getPromotions());
        }
        return (List<ProductEntity>) products;
    }

    public boolean checkPromotion2(PromotionEntity promotion, List<ProductEntity> products) {
        for (ProductEntity product : products) {
            for (PromotionEntity promo : product.getPromotions()) {
                for (ProductEntity proPromotion : promotion.getProducts()) {
                    if (product.getId() == proPromotion.getId() && (promo.getStartDate().compareTo(promotion.getStartDate()) * promotion.getStartDate().compareTo(promo.getEndDate()) > 0) == true) {
                        return false;
                    }
                }
            }
        }
        return true;
    }

    public static int getSizeProduct(List<ProductEntity> products) {
        int n = 0;
        for (ProductEntity product : products) {
            if (product.getCategory().getStatus() == ProductStatus.ACTIVE || product.getCategory().getStatus() == ProductStatus.DISABLED) {
                n++;
            }
        }
        return n;
    }

    public List<ProductEntity> getProductsS(List<ProductEntity> products, PromotionEntity promotion) {
        List<ProductEntity> products1 = new ArrayList<>();
        for (ProductEntity product : products) {
            if (product.getPromotions().isEmpty()) {
                products1.add(product);
            } else {
                boolean temp = true;
                for (PromotionEntity promo : product.getPromotions()) {
                    if (promo.getStartDate().compareTo(promotion.getStartDate()) * promotion.getStartDate().compareTo(promo.getEndDate()) > 0) {
                        temp = false;
                    }
                }
                if (temp) {
                    products1.add(product);
                }
            }
        }
        return (List<ProductEntity>) products1;
    }

    public int sumProductsInStock() {
        return productRepository.sumProductsInStock();
    }
}
