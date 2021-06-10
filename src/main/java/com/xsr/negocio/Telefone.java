package com.xsr.negocio;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.xsr.config.Conexao;

public class Telefone {

    private int id;
    private int ddd;
    private int numero;
    private String tipo;

	public Telefone() {
	}
	
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDdd() {
        return ddd;
    }

    public void setDdd(int ddd) {
        this.ddd = ddd;
    }

    public int getNum() {
        return numero;
    }

    public void setNum(int num) {
        this.numero = num;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public void addTel() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "insert into telefone values("+id+","+ddd+","+numero+","+tipo+")";
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
	public void alterTel(int id, int ddd, int numero, String tipo) throws IOException, SQLException, Exception {
	    Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "update status set telefone set id="+id+", ddd="+ddd+", numero="+numero+", tipo="+tipo+" where id="+id;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
	public void excTel(int id) throws IOException, SQLException, Exception {
	    Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "delete from endereco where id="+id;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
    
	public void findTel(int usuario) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "select * from telefone where usuario = " +usuario;
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			this.setId(rs.getInt("id"));
			this.setDdd(rs.getInt("ddd"));
			this.setNum(rs.getInt("numero"));
			this.setTipo(rs.getString("tipo"));
		}
		cb.fecharConexao(con, stmt, rs);
	}
}