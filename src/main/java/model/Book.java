package model;

import java.util.Date;
import java.util.List;
import java.util.ArrayList;

public class Book {
    private int id;
    private String title;
    private String description;
    private int quantity;
    private int availableQuantity;
    private Date createdDate;
    private List<Author> authors;
    
    public Book() {
        this.authors = new ArrayList<>();
        this.createdDate = new Date();
    }
    
    public Book(String title, String description, int quantity) {
        this();
        this.title = title;
        this.description = description;
        this.quantity = quantity;
        this.availableQuantity = quantity;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public int getAvailableQuantity() { return availableQuantity; }
    public void setAvailableQuantity(int availableQuantity) { this.availableQuantity = availableQuantity; }
    
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    
    public List<Author> getAuthors() { return authors; }
    public void setAuthors(List<Author> authors) { this.authors = authors; }
    
    public boolean isAvailableForLoan() {
        return availableQuantity > 0;
    }
}