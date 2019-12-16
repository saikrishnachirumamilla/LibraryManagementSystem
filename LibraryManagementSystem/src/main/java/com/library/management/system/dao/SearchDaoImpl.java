package com.library.management.system.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.google.gson.Gson;

public class SearchDaoImpl implements SearchDao{
	@Autowired
	  private DataSource datasource;
	  
	@Autowired
	  private JdbcTemplate jdbcTemplate;

	public String getBooks(String name) throws Exception{
		try {
			List<Map<String,Object>> booksList = new ArrayList<>();
			Gson gson = new Gson();
			
//			String query = "SELECT   isbn10,isbn13,title, GROUP_CONCAT(author ORDER BY author ASC SEPARATOR ', ') as author, availability\n" + 
//					"FROM     (\n" + 
//					"Select book_author.isbn10 as isbn10,book_author.isbn13 as isbn13,books.title as title,book_author.name as author,books.total_copies as availability from book_author inner join books "
//					+ "where book_author.isbn10=books.isbn10 and book_author.isbn13=books.isbn13 and "
//					+ "( books.title like concat('%',"+"'"+name+"'"+",'%') or book_author.name like concat ('%',"+"'"+name+"'"+",'%') or book_author.isbn10 like concat ('%',"+"'"+name+"'"+",'%') or book_author.isbn13 like concat ('%',"+"'"+name+"'"+",'%') ) )as foo GROUP BY isbn13;";
//			
			String query = "SELECT isbn10,isbn13,title, GROUP_CONCAT(author ORDER BY author ASC SEPARATOR ', ') as author, availability FROM  "
					+ "(Select book_author.isbn10 as isbn10,book_author.isbn13 as isbn13,books.title as title,GROUP_CONCAT(book_author.name ORDER BY book_author.name  ASC SEPARATOR ', ') as author,(books.total_copies-books.copies_borrowed) as availability from "
					+ "book_author inner join books where book_author.isbn10=books.isbn10 and book_author.isbn13=books.isbn13   group by book_author.isbn13 ) as foo  "
					+ "where  title like concat('%',"+"'"+name+"'"+",'%') or author like concat ('%',"+"'"+name+"'"+",'%') or isbn10 like concat ('%',"+"'"+name+"'"+",'%') or isbn13 like concat ('%',"+"'"+name+"'"+",'%') GROUP BY isbn13;";
			System.out.println(query);
			booksList = this.jdbcTemplate.queryForList(query);
			
			return gson.toJson(booksList);
		} catch (Exception e) {
			throw e;
		}
		
	}

}
