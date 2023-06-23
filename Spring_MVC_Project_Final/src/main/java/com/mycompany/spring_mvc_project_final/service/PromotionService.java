/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.repository.PromotionRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PromotionService {

    @Autowired
    private PromotionRepository promotionRepository;

    //Get all product + pageable
    @Transactional
    public List<PromotionEntity> getPromotionsPage(Pageable pageable) {
        List<PromotionEntity> promotions = (List<PromotionEntity>) promotionRepository.findPromotions(pageable);
        for (PromotionEntity promotionEntity : promotions) {
            Hibernate.initialize(promotionEntity.getProducts());
            Hibernate.initialize(promotionEntity.getImages());
        }
        return (List<PromotionEntity>) promotions;
    }

    @Transactional
    public PromotionEntity finById(int id) {
        Optional<PromotionEntity> promotion = promotionRepository.findById(id);
        if (promotion.isPresent()) {
            PromotionEntity promotionEntity = promotion.get();
            Hibernate.initialize(promotionEntity.getProducts());
            Hibernate.initialize(promotionEntity.getImages());
            return promotionEntity;
        } else {
            return new PromotionEntity();
        }
    }

    public void save(PromotionEntity promotionEntity) {
        promotionRepository.save(promotionEntity);
    }

    @Transactional
    public List<PromotionEntity> getPromotions() {
        List<PromotionEntity> promotions = (List<PromotionEntity>) promotionRepository.findAll();
        for (PromotionEntity promotionEntity : promotions) {
            Hibernate.initialize(promotionEntity.getProducts());
            Hibernate.initialize(promotionEntity.getImages());
        }
        return (List<PromotionEntity>) promotions;
    }

    //Search Promotions by name
    @Transactional
    public List<PromotionEntity> searchPromotions(String strSearch) {
        List<PromotionEntity> promotions = (List<PromotionEntity>) promotionRepository.findByPromotionNameContaining(strSearch);
        for (PromotionEntity promotion : promotions) {
            Hibernate.initialize(promotion.getImages());
            Hibernate.initialize(promotion.getProducts());
        }
        return (List<PromotionEntity>) promotions;
    }

    //Get promotions today
    public List<PromotionEntity> getPromotionsToDay() {
        List<PromotionEntity> promotions = (List<PromotionEntity>) promotionRepository.findPromotionsActive();
        List<PromotionEntity> promotions1 = new ArrayList<>();
        Date dateCurrent = new Date();
        for (PromotionEntity promotion : promotions) {
            if (promotion.getStartDate().compareTo(dateCurrent) * dateCurrent.compareTo(promotion.getEndDate()) > 0) {
                promotions1.add(promotion);
            }
        }
        return promotions1;
    }

    public int countPromotionActive() {
        return promotionRepository.countPromotionActive();
    }
}
