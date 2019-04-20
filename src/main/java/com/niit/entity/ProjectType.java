package com.niit.entity;

public class ProjectType {
    private Integer projecttypeid;

    private String projecttypename;

    public Integer getProjecttypeid() {
        return projecttypeid;
    }

    public void setProjecttypeid(Integer projecttypeid) {
        this.projecttypeid = projecttypeid;
    }

    public String getProjecttypename() {
        return projecttypename;
    }

    public void setProjecttypename(String projecttypename) {
        this.projecttypename = projecttypename == null ? null : projecttypename.trim();
    }
}