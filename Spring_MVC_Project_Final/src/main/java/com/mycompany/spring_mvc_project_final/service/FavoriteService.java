/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.FavoriteEntity;
import com.mycompany.spring_mvc_project_final.repository.FavoriteRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FavoriteService {

    @Autowired
    private FavoriteRepository favoriteRepository;

    public void save(FavoriteEntity favoriteEntity) {
        favoriteRepository.save(favoriteEntity);

    }

    public void findById(int id) {
        favoriteRepository.findById(id);
    }

    public List<FavoriteEntity> findByAccountId(int accountId) {
        return favoriteRepository.findByAccountId(accountId);
    }

    public void delete(int id) {
        favoriteRepository.deleteById(id);
    }

    public List<FavoriteEntity> findAll() {
        return (List<FavoriteEntity>) favoriteRepository.findAll();
    }
}
