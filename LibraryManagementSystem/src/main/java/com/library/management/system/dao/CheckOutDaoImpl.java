package com.library.management.system.dao;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class CheckOutDaoImpl implements CheckOutDao{
	@Autowired
	  private DataSource datasource;
	  
	@Autowired
	  private JdbcTemplate jdbcTemplate;

	@Override
	public String checkBookId(String isbn13) throws Exception {
		try {
			
			String query = "SELECT COUNT(*) from books where isbn13 = "+"'"+isbn13+"';";
			System.out.println(query);
			Integer result = this.jdbcTemplate.queryForObject(query, Integer.class);
			if(result == 0) {
				return "The book id that you have entered does not exist. Please check the id and try again.";
			}else {
				return "success";
			}
		} catch (Exception e) {
			System.out.println("Check book id failed.");
			System.out.println(e.getMessage());
			throw e;
		}
		
	}

	@Override
	public String checkBCardNo(String cardNo) throws Exception {
		try {
			String query = "SELECT COUNT(*) from borrower where card_id = "+"'"+cardNo+"';";
			System.out.println(query);
			Integer result = this.jdbcTemplate.queryForObject(query, Integer.class);
			if(result == 0) {
				return "The card number that you have entered does not exist. Please check the id and try again.";
			}else {
				return "success";
			}
		} catch (Exception e) {
			System.out.println("Check card no failed.");
			System.out.println(e.getMessage());
			throw e;
		}
	}

	@Override
	public String checkAvailability(String isbn13) throws Exception {
		try {
			
			String query = "SELECT ifnull((b.TOTAL_COPIES - b.COPIES_BORROWED),b.TOTAL_COPIES) as available  FROM BOOKS b WHERE ISBN13 = "+"'"+isbn13+"';";
			System.out.println(query);
			Integer result = this.jdbcTemplate.queryForObject(query, Integer.class);
			if(result == 0) {
				return "No more copies of this book are available.";
			}else {
				return "success";
			}
		} catch (Exception e) {
			System.out.println("Check availability failed.");
			System.out.println(e.getMessage());
			throw e;
		}
	}

	@Override
	public String checkSameUser(String isbn13, String cardNo) throws Exception {
		try {
			String query = "SELECT COUNT(*) from book_loans where date_in is null and isbn13 = "+"'"+isbn13+"'"+"  and card_id = "+"'"+cardNo+"';";
			System.out.println(query);
			Integer result = this.jdbcTemplate.queryForObject(query, Integer.class);
			if(result > 0) {
				return "This book has already been given out to the same user. Please check details entered.";
			}else {
				return "success";
			}
		} catch (Exception e) {
			System.out.println("Check same user failed.");
			System.out.println(e.getMessage());
			throw e;
		}
	}

	@Override
	public String checkBookLimit(String cardNo) throws Exception {
		try {
			String query = "SELECT COUNT(*) from book_loans where card_id = "+"'"+cardNo+"'"+" and date_in IS NULL;";
			System.out.println(query);
			Integer result = this.jdbcTemplate.queryForObject(query, Integer.class);
			if(result >= 3) {
				return "3 books have already been assigned to the borrower. Cannot assign this book to the user. Please try later.";
			}else {
				return "success";
			}
		} catch (Exception e) {
			System.out.println("Check book limit failed.");
			System.out.println(e.getMessage());
			throw e;
		}
	}

	@Override
	public String checkOutBook(String isbn13, String cardNo, String checkOutDate, String dueDate) throws Exception {
		try {
			String insertQuery = "insert into book_loans (isbn13,card_id,date_out,due_date) values ("+"'"+isbn13+"','"+cardNo+"','"+checkOutDate+"','"+dueDate+"'"+");";
			String updateQuery = "update books set copies_borrowed = copies_borrowed + 1 where isbn13 = "+"'"+isbn13+"'"+";";
			System.out.println(insertQuery);
			System.out.println(updateQuery);
			this.jdbcTemplate.execute(insertQuery);
			this.jdbcTemplate.execute(updateQuery);
			return "Book has been successfully checked out. Book has been assigned. Book has to be returned in 14 days.";
		} catch (Exception e) {
			System.out.println("Check out book failed.");
			System.out.println(e.getMessage());
			throw e;
		}
	}
}
