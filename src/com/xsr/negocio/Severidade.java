package com.xsr.negocio;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.xsr.config.Conexao;

public class Severidade {

    private int id;
    private String nome;
    private int tempo;

	public Severidade() {
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

    public int getTempo() {
        return tempo;
    }

    public void setTempo(int tempo) {
        this.tempo = tempo;
    }
	
	public void addSev() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "insert into severidade values("+id+",'"+nome+"', "+tempo+")";
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
    
    public void alterSev(int id, String nome, int tempo) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "update severidade set nome='"+nome+"', tempo="+tempo+" where id="+id;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
    
    public void excSev(int id) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "delete from severidade where id="+id;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
	public void findSev() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "select * from severidade where id="+this.getId();
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			this.setId(rs.getInt("id"));
			this.setNome(rs.getString("nome"));
			this.setTempo(rs.getInt("tempo"));
		}
		cb.fecharConexao(con, stmt, rs);
	}
	    
	public Vector<Severidade> listarTodos() throws IOException, SQLException, Exception {
		Vector<Severidade> vetor = new Vector<Severidade>();
        Severidade s;
		
		Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("select * from severidade order by id");
		
        while(rs.next()) {
            s = new Severidade();
            s.setId(rs.getInt("id"));
            s.setNome(rs.getString("nome"));
			s.setTempo(rs.getInt("tempo"));
            vetor.add(s);
        }
		cb.fecharConexao(con, stmt, rs);
		
		return vetor;
    }
}