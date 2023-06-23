/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {

    UserEntity findByEmailLike(String email);

    UserEntity findByEmailContaining(String email);

    
    @Query("select u From UserEntity u where u.email = ?1 and u.status like 'ACTIVE'")
    public UserEntity findByEmailActive(String email);

    @Query("select u From UserEntity u where u.uuid = ?1")
    public UserEntity findByUuid(String uuid);

    @Query("select u from UserEntity u")
    List<UserEntity> getUsersPage(Pageable pageable);

    @Query("select u from UserEntity u where u.email like %?1% or u.fullName like %?2%")
    public List<UserEntity> findByEmailFullNamee(String ser, String ser2);
}
