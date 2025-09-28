package model;

import java.util.Date;
import java.util.Calendar;

public class Loan {
    private int id;
    private Member member;
    private Book book;
    private Date loanDate;
    private Date dueDate;
    private Date returnDate;
    private String status; // "ACTIVE", "RETURNED", "OVERDUE"
    private String notes;
    
    public Loan() {
        this.loanDate = new Date();
        this.status = "ACTIVE";
        
        // Set due date to 14 days from loan date
        Calendar cal = Calendar.getInstance();
        cal.setTime(this.loanDate);
        cal.add(Calendar.DAY_OF_MONTH, 14);
        this.dueDate = cal.getTime();
    }
    
    public Loan(Member member, Book book) {
        this();
        this.member = member;
        this.book = book;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public Member getMember() { return member; }
    public void setMember(Member member) { this.member = member; }
    
    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
    
    public Date getLoanDate() { return loanDate; }
    public void setLoanDate(Date loanDate) { this.loanDate = loanDate; }
    
    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }
    
    public Date getReturnDate() { return returnDate; }
    public void setReturnDate(Date returnDate) { this.returnDate = returnDate; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    
    public boolean isOverdue() {
        return "ACTIVE".equals(status) && new Date().after(dueDate);
    }
}