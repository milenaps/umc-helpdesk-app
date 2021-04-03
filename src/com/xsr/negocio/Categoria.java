package com.xsr.negocio;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.xsr.config.Conexao;

public class Categoria {

    private int id;
    private String nome;
    private int pai;

	public Categoria() {
	}
	
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public int getPai() {
		return pai;
	}

	public void setPai(int pai) {
		this.pai = pai;
	}
	
	public void addCateg() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "insert into categoria values("+id+",'"+nome+"',"+null+")";
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
	public void alterCateg(int id, String nome) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "update categoria set nome='"+nome+"' where id="+id;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
    public void excCateg(int id) throws IOException, SQLException, Exception {
    	Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();

		String sql = "delete from categoria where id="+id;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
	public void findCateg() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "select * from categoria where id="+this.getId();
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			this.setId(rs.getInt("id"));
			this.setNome(rs.getString("nome"));
		}
		cb.fecharConexao(con, stmt, rs);
	}
	    
	public Vector<Categoria> listarTodos() throws IOException, SQLException, Exception {
        Vector<Categoria> vetor = new Vector<Categoria>();
        Categoria c;
		
		Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("select * from categoria order by id");
		
        while(rs.next()) {
            c = new Categoria();
            c.setId(rs.getInt("id"));
            c.setNome(rs.getString("nome"));
            vetor.add(c);
        }
		cb.fecharConexao(con, stmt, rs);
		
		return vetor;
    }
}