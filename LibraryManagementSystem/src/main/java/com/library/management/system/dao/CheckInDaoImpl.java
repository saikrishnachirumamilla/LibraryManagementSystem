package com.library.management.system.dao;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class CheckInDaoImpl implements CheckInDao{
	@Autowired
	  private DataSource datasource;
	  
	@Autowired
	  private JdbcTemplate jdbcTemplate;

	@Override
	public List<Map<String,Object>> getCheckIn(String isbn13, String cardno, String bname) throws Exception {
		try {
			String query = "SELECT borrower.fname, borrower.lname, book_loans.card_id, book_loans.isbn13, book_loans.loan_id, DATE(book_loans.due_date) as due_date FROM "
					+ "borrower join book_loans on borrower.card_id = book_loans.card_id where book_loans.date_in IS NULL";
			
			if(!isbn13.equals("null")){
				
				query = query + " and book_loans.isbn13 = "+"'"+isbn13+"'";
			}
			
			if(!cardno.equals("null")){
				query = query + " and book_loans.card_id = "+"'"+cardno+"'";
			}
			
			if(!bname.equals("null")){
				query = query + " and borrower.fname like '"+bname+"' or borrower.lname like '"+bname+"'";
			}
			
			System.out.println(query);
			
			return this.jdbcTemplate.queryForList(query);
		} catch (Exception e) {
			System.out.println("Get check in list failed.");
			System.out.println(e.getMessage());
			throw e;
		}
	}

	@Override
	public String checkInBook(String isbn13, String cardno, String checkInDate) throws Exception {
		try {
			String updateLoans = "update book_loans set date_in = '"+checkInDate+"' where isbn13 = '"+isbn13+"' and card_id = '"+cardno+"';";
			String updateBooks = "update books set copies_borrowed = copies_borrowed - 1 where isbn13 = '"+isbn13+"';";
			System.out.println(updateLoans);
			System.out.println(updateBooks);
			this.jdbcTemplate.execute(updateLoans);
			this.jdbcTemplate.execute(updateBooks);
			return "Book successfully checked in.";
		} catch (Exception e) {
			System.out.println("Check in book failed.");
			System.out.println(e.getMessage());
			throw e;
		}
	}
}
