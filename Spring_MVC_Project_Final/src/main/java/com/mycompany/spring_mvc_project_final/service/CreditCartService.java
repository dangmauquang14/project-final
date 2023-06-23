/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.CreditCartEntity;
import com.mycompany.spring_mvc_project_final.repository.CreditCartRepository;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CreditCartService {

    @Autowired
    private CreditCartRepository creditCartRepository;

    @Transactional(rollbackFor = Exception.class)
    public void transferMoney(double balence, int code) throws Exception {
        CreditCartEntity cartEntity1 = creditCartRepository.findByCode(code);
        CreditCartEntity cartEntity2 = creditCartRepository.findByCode(123);

        cartEntity1.setBalance(cartEntity1.getBalance() - balence);
        cartEntity1.setCartExdate((new Date()));
        creditCartRepository.save(cartEntity1);

        if (cartEntity1.getBalance() < 0) {
            throw new Exception("number greater than balance...!");
        }
        cartEntity2.setBalance(cartEntity2.getBalance() + balence);
        cartEntity2.setCartExdate((new Date()));
        creditCartRepository.save(cartEntity2);
    }

    public void save(CreditCartEntity creditCartEntity) {
        creditCartRepository.save(creditCartEntity);
    }

    public CreditCartEntity findByCode(int code) {
        return (CreditCartEntity) creditCartRepository.findByCode(code);
    }
}