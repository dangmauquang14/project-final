/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.enums;

public enum OrderStatus {
    PENDING // luc khach hang moi dat hang xong và cua hang chua xac nhan
    , COMFIRM // cua hang da xac nhan don hang
    , SHIPPING // cua hang giao hang
    , COMPLETED // khach hang da nhan xong hang
    , CANCEL // khach hang huy don hang. Chi duoc huy khi order dang co status PENDING va COMFIRM, sau khi huy thi se mat 20% so tien.
}
