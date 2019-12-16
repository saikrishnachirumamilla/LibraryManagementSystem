package com.library.management.system.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class FinesDaoImpl implements FinesDao{
	@Autowired
	  private DataSource datasource;
	  
	@Autowired
	  private JdbcTemplate jdbcTemplate;

	@Override
	public String refreshFines() throws Exception {
		try {
			String insertQuery = "insert into fines (loan_id, fine_amount) "
					+ "select T.loan_id,T.fine*0.25 from (select loan_id, if(date_in IS NULL,datediff(curdate(),due_date),IF(date_in>due_date,datediff(date_in,due_date),0)) as fine from book_loans having fine>0) as T "
					+ "where T.loan_id NOT IN (select f.loan_id from fines as f);";
			String updateQuery = "update fines join (select loan_id, if(date_in IS NULL,datediff(curdate(),due_date),IF(date_in>due_date,datediff(date_in,due_date),0)) as fine from book_loans having fine>0) as T on fines.loan_id = T.loan_id set fines.fine_amount = T.fine*0.25 where fines.paid = 0;";
			
			System.out.println(insertQuery);
			System.out.println(updateQuery);
			
			this.jdbcTemplate.execute(insertQuery);
			this.jdbcTemplate.execute(updateQuery);
			
			return "Refresh Successful.";
		} catch (Exception e) {
			System.out.println("Refresh fines failed.");
			System.out.println(e.getMessage());
			throw e;
		}
	}

	@Override
	public List<List<Map<String, Object>>> fetchFines(String cardno) throws Exception {
		try {
			
			List<List<Map<String, Object>>> finesList = new ArrayList<List<Map<String,Object>>>();
			String query = "select b.fname,b.lname,bl.card_id,SUM(f.fine_amount) as amount,f.paid, 'YES' as payable "
					+ "from fines as f join book_loans bl on f.loan_id = bl.loan_id join borrower as b on b.card_id = bl.card_id where ";
			
			if(!cardno.equals("null")){
				query = query + " bl.card_id = '"+cardno+"'";
			}
			query = query +" and bl.date_in is not null and f.paid <> '1' ";
			query = query + " group by bl.card_id,f.paid;";
			
			String query1 = "select b.fname,b.lname,bl.card_id,SUM(f.fine_amount) as amount,f.paid, 'NO' as payable "
					+ "from fines as f join book_loans bl on f.loan_id = bl.loan_id join borrower as b on b.card_id = bl.card_id where ";
			
			if(!cardno.equals("null")){
				query1 = query1 + " bl.card_id = '"+cardno+"'";
			}
			query1 = query1 +" and bl.date_in is null and f.paid <> '1' ";
			query1 = query1 + " group by bl.card_id,f.paid;";
			
			System.out.println(query);
			System.out.println(query1);
			List<Map<String, Object>> payableFines = this.jdbcTemplate.queryForList(query);
			List<Map<String, Object>> nonPayableFines = this.jdbcTemplate.queryForList(query1);
			finesList.add(payableFines);
			finesList.add(nonPayableFines);
			return finesList;
		} catch (Exception e) {
			System.out.println("Fetch fines failed.");
			System.out.println(e.getMessage());
			throw e;
		}
	}

	@Override
	public String payFines(String cardno, String fine) throws Exception {
		try {
			String query = "update fines join book_loans on fines.loan_id = book_loans.loan_id set fines.paid = 1 where fines.paid = 0 and book_loans.date_in is not null and book_loans.card_id = '"+cardno+"';";
			System.out.println(query);
			this.jdbcTemplate.execute(query);
			return "Payment of $ " + fine + " was successfully recorded.";
		} catch (Exception e) {
			System.out.println("Pay fines failed.");
			System.out.println(e.getMessage());
			throw e;
		}
	}

}
