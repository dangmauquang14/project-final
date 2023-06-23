/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.UserRoleEntity;
import com.mycompany.spring_mvc_project_final.repository.UserRoleRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserRoleService {

    @Autowired
    private UserRoleRepository userRoleRepository;

    public List<UserRoleEntity> getUserRole() {
        return userRoleRepository.findAll();
    }

    public UserRoleEntity getUserRoleById(int id) {
        Optional<UserRoleEntity> userRole = userRoleRepository.findById(id);
        if (userRole.isPresent()) {
            UserRoleEntity userRoleEntity = userRole.get();
            return userRoleEntity;
        } else {
            return new UserRoleEntity();
        }
    }

    public void save(UserRoleEntity userRole) {
        userRoleRepository.save(userRole);
    }
}
