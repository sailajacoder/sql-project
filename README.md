# Library Database Project 📚

## 📌 Overview
This project is a **MySQL-based library management system** that helps manage books, authors, and users.

## 🔧 Database Schema
The database includes the following tables:
- `books` (Book details)
- `authors` (Author details)
- `users` (Library members)
- `transactions` (Borrowing history)

## 🚀 Setup Instructions
1. Install MySQL.
2. Run `schema.sql` to create tables.
3. Run `data.sql` to insert sample data.
4. Use `queries.sql` for predefined queries.

## ⚡ Sample Queries
```sql
SELECT * FROM books WHERE author_id = 1;
