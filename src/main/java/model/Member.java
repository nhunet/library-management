package model;

import java.util.Date;

public class Member {
    private int id;
    private String memberCode;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private Date registrationDate;
    private boolean isActive;
    private String password;
    
    public Member() {
        this.registrationDate = new Date();
        this.isActive = true;
    }
    
    public Member(String memberCode, String fullName, String email, String password) {
        this();
        this.memberCode = memberCode;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getMemberCode() { return memberCode; }
    public void setMemberCode(String memberCode) { this.memberCode = memberCode; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public Date getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(Date registrationDate) { this.registrationDate = registrationDate; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}