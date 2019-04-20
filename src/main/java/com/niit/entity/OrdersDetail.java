package com.niit.entity;

public class OrdersDetail extends OrdersDetailKey {
    private String express;

    private Integer ostate;

    private Integer onum;

    public String getExpress() {
        return express;
    }

    public void setExpress(String express) {
        this.express = express == null ? null : express.trim();
    }

    public Integer getOstate() {
        return ostate;
    }

    public void setOstate(Integer ostate) {
        this.ostate = ostate;
    }

    public Integer getOnum() {
        return onum;
    }

    public void setOnum(Integer onum) {
        this.onum = onum;
    }
}