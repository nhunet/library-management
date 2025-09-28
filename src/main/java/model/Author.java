package model;

import java.util.Date;

public class Author {
    private int id;
    private String name;
    private String biography;
    private Date birthDate;
    private String nationality;
    private Date createdDate;
    
    public Author() {
        this.createdDate = new Date();
    }
    
    public Author(String name, String biography, String nationality) {
        this();
        this.name = name;
        this.biography = biography;
        this.nationality = nationality;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getBiography() { return biography; }
    public void setBiography(String biography) { this.biography = biography; }
    
    public Date getBirthDate() { return birthDate; }
    public void setBirthDate(Date birthDate) { this.birthDate = birthDate; }
    
    public String getNationality() { return nationality; }
    public void setNationality(String nationality) { this.nationality = nationality; }
    
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
}