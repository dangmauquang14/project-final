/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.repository.CategoryRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    public CategoryEntity findById(int id) {
        return (CategoryEntity) categoryRepository.findById(id).get();
    }

    public CategoryEntity findAllById(int id) {
        return (CategoryEntity) categoryRepository.findAllById(id);
    }

    public void save(CategoryEntity categoryEntity) {
        categoryRepository.save(categoryEntity);
    }

    public List<CategoryEntity> getCategories() {
        return (List<CategoryEntity>) categoryRepository.findAll();
    }
}
