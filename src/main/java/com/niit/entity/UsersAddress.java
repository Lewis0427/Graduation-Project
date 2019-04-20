package com.niit.entity;

public class UsersAddress {
    private Integer aid;

    private String address;

    private String auphone;

    public Integer getAid() {
        return aid;
    }

    public void setAid(Integer aid) {
        this.aid = aid;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getAuphone() {
        return auphone;
    }

    public void setAuphone(String auphone) {
        this.auphone = auphone == null ? null : auphone.trim();
    }
}