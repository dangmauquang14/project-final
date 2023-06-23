/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import java.util.Date;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Integer> {

    @Query("SELECT o FROM OrderEntity o")
    List<OrderEntity> findProducts(Pageable pageable);

    public List<OrderEntity> findByOrderNumberContaining(String ser);

    @Query("Select o From OrderEntity o where o.account like ?1")
    public List<OrderEntity> findByAccountId(Integer id);

    @Query("Select o From OrderEntity o where o.email like ?1")
    public List<OrderEntity> findByEmailAccount(String email);

    @Query("Select o From OrderEntity o where o.orderDate between ?1 and ?2")
    public List<OrderEntity> findOrderByDate(Date date1, Date date2);
    
    @Query("select count(o.id) from OrderEntity o where month(o.orderDate) = ?1 and year(o.orderDate) = ?2")
    public int countOrderInMonth(int month, int year);
    
    @Query("select count(o.id) from OrderEntity o where o.status = 'PENDING'")
    public int countOrderPending();
    
    @Query("select sum(o.totalPrice) from OrderEntity o where month(o.orderDate) = ?1 and year(o.orderDate) = ?2 and o.status = 'COMPLETED'")
    public double sumRevenueInMonth(int month, int year);
    
    @Query("select sum(o.quantity) from OrderEntity o where month(o.orderDate) = ?1 and year(o.orderDate) = ?2 and o.status = 'COMPLETED'")
    public int sumProductSoldInMonth(int month, int year);
}
