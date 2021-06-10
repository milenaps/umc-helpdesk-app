package com.xsr.negocio;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.xsr.config.Conexao;

public class Status {

    private int id;
    private String nome;

    public Status() {
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
    
    public void addStatus() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "insert into status values("+id+",'"+nome+"')";
		stmt.executeUpdate(sql);
		cb.fecharConexao(con, stmt, null);
	}
    
    public void alterStatus(int id, String nome) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "update status set nome='"+nome+"' where id="+id;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
    
    public void excStatus(int id) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "delete from status where id="+id;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
	public void findStatus() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "select * from status where id="+this.getId();
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			this.setId(rs.getInt("id"));
			this.setNome(rs.getString("nome"));
		}
		
		cb.fecharConexao(con, stmt, rs);
	}
	
	public Vector<Status> listarTodos() throws IOException, SQLException, Exception {
        Vector<Status> vetor = new Vector<Status>();
        Status s;
		
		Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("select * from status order by id");
		
        while(rs.next()) {
            s = new Status();
            s.setId(rs.getInt("id"));
            s.setNome(rs.getString("nome"));
            vetor.add(s);
        }
		cb.fecharConexao(con, stmt, rs);
		
		return vetor;
    }
}