/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface PromotionRepository extends JpaRepository<PromotionEntity, Integer>{
    
    @Query("SELECT pro FROM PromotionEntity pro")
    List<PromotionEntity> findPromotions(Pageable pageable);

    @Query("SELECT promo FROM PromotionEntity promo where promo.status like 'ACTIVE'")
    public List<PromotionEntity> findPromotionsActive();
    
    @Query("select count(p.id) from PromotionEntity p where p.status = 'ACTIVE'")
    public int countPromotionActive();
    
    public List<PromotionEntity> findByPromotionNameContaining(String ser);
}
