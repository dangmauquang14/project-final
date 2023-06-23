/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.repository.UserRepository;
import java.util.List;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public void save(UserEntity userEntity) {
        userRepository.save(userEntity);
    }

    public UserEntity findById(int id) {
        return (UserEntity) userRepository.findById(id).get();
    }

    @Transactional
    public UserEntity findByUuid(String uuid) {
        UserEntity user = userRepository.findByUuid(uuid);
        Hibernate.initialize(user.getUserRoles());
        Hibernate.initialize(user.getOrders());
        Hibernate.initialize(user.getFavorites());
        return user;
    }

    @Transactional
    public List<UserEntity> getUsers() {
        List<UserEntity> users = (List<UserEntity>) userRepository.findAll();
        for (UserEntity user : users) {
            Hibernate.initialize(user.getUserRoles());
            Hibernate.initialize(user.getOrders());
            Hibernate.initialize(user.getFavorites());
        }
        return (List<UserEntity>) users;
    }

    @Transactional
    public List<UserEntity> getUsersPage(Pageable pageable) {
        List<UserEntity> users = (List<UserEntity>) userRepository.getUsersPage(pageable);
        for (UserEntity user : users) {
            Hibernate.initialize(user.getUserRoles());
            Hibernate.initialize(user.getOrders());
            Hibernate.initialize(user.getFavorites());
        }
        return (List<UserEntity>) users;
    }

    @Transactional
    public List<UserEntity> findByUsersByEmailOrFullName(String email, String fullName) {
        List<UserEntity> users = (List<UserEntity>) userRepository.findByEmailFullNamee(email, fullName);
        for (UserEntity user : users) {
            Hibernate.initialize(user.getUserRoles());
            Hibernate.initialize(user.getOrders());
            Hibernate.initialize(user.getFavorites());
        }
        return (List<UserEntity>) users;
    }

    public UserEntity findByEmail(String email) {
        return (UserEntity) userRepository.findByEmailContaining(email);
    }

}
