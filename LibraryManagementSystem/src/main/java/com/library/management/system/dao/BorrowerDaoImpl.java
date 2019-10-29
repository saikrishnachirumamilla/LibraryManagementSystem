package com.library.management.system.dao;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class BorrowerDaoImpl implements BorrowerDao{
	@Autowired
	  private DataSource datasource;
	  
	@Autowired
	  private JdbcTemplate jdbcTemplate;

	@Override
	public String insertBorrower(String ssn, String fname, String lname, String email, String addr, String city,
			String state, String phn, String date) throws Exception {
		try {
			
			String insertQuery = "INSERT INTO BORROWER( SSN, FNAME, LNAME, BNAME, EMAIL, ADDRESS, CITY, STATE, FULL_ADDRESS, PHONE, CREATED_DATE) "
					+ "VALUES('"+ssn+"','"+fname+"','"+lname+"','"+fname+" "+lname+"','"+email+"','"+addr+"','"+city+"','"+state+"','"+addr+" "+city+" "+state+"','"+phn+"','"+date+"')";
			String ssnQuery = "select CARD_ID from borrower where SSN = '"+ssn+"';";
			System.out.println(insertQuery);
			System.out.println(ssnQuery);
			this.jdbcTemplate.execute(insertQuery);
			Integer cardNo = this.jdbcTemplate.queryForObject(ssnQuery, Integer.class);
			return "New borrower has been added to the database. The card number assigned is: "+ cardNo;
		} catch (Exception e) {
			System.out.println("Insert borrower failed");
			System.out.println(e.getMessage());
			throw e;
		}
	}

	@Override
	public boolean checkBorrower(String ssn) throws Exception {
		try {
			String query = "Select COUNT(*) from borrower where SSN = '"+ssn+"';";
			System.out.println(query);
			Integer result = this.jdbcTemplate.queryForObject(query, Integer.class);
			if (result>0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			System.out.println("Check borrower failed");
			System.out.println(e.getMessage());
			throw e;
		}
	}
}
