package com.niit.entity;

public class UsersInfo {
    private String uphone;

    private String uname;

    private String uzipcode;

    private String uemail;

    private String ucardnumber;

    public String getUphone() {
        return uphone;
    }

    public void setUphone(String uphone) {
        this.uphone = uphone == null ? null : uphone.trim();
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname == null ? null : uname.trim();
    }

    public String getUzipcode() {
        return uzipcode;
    }

    public void setUzipcode(String uzipcode) {
        this.uzipcode = uzipcode == null ? null : uzipcode.trim();
    }

    public String getUemail() {
        return uemail;
    }

    public void setUemail(String uemail) {
        this.uemail = uemail == null ? null : uemail.trim();
    }

    public String getUcardnumber() {
        return ucardnumber;
    }

    public void setUcardnumber(String ucardnumber) {
        this.ucardnumber = ucardnumber == null ? null : ucardnumber.trim();
    }
}