/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import java.util.Date;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<ProductEntity, Integer> {

    @Query("SELECT p FROM ProductEntity p")
    List<ProductEntity> findProducts(Pageable pageable);

    public List<ProductEntity> findByProductNameContaining(String ser);

    @Query("Select p From ProductEntity p where p.category.id = ?1")
    public List<ProductEntity> findProductByCategory(int idCate);

    @Query("select count(p.id) from CategoryEntity c left join ProductEntity p on c.id = p.category.id group by c.id")
    public List<Integer> countProductByCategory();

    @Query("select p From ProductEntity p where p.status like 'ACTIVE'")
    public List<ProductEntity> findProductActive(Pageable pageable);

    @Query("select p From ProductEntity p where p.status like 'ACTIVE' ORDER BY p.createDate DESC")
    public List<ProductEntity> findProductActiveSort(Pageable p);

    @Query("Select p From ProductEntity p where p.category.id = ?1 and p.status like 'ACTIVE'")
    public List<ProductEntity> findProductByCategoryActive(int idCategory, Pageable pageable);

    @Query("Select p From ProductEntity p where p.category.id = ?1 and p.status like 'ACTIVE'")
    public List<ProductEntity> findProductByCategoryActiveNo(int idCategory);

    @Query("SELECT p FROM ProductEntity p where p.status = 'ACTIVE'")
    public List<ProductEntity> findProductsActivee();

    @Query("select sum(p.quantity) from ProductEntity p where p.status = 'ACTIVE'")
    public int sumProductsInStock();
}
