package com.xsr.config;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Conexao {
	private Connection con;
	
	public Connection getConexao() throws IOException, SQLException, Exception {
		Class.forName("org.postgresql.Driver").newInstance();
		con = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/xsr?user=postgres&password=aula");
		return (con);
	}
	
	public void fecharConexao(Connection con, Statement stmt, ResultSet rset) {
		
		try {
			if (rset != null) {
				rset.close();
			}
		} catch (SQLException e){
		}
		
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException e){
		}
		
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException e){
		}
	}
}