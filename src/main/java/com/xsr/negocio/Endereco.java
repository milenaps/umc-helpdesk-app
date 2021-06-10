package com.xsr.negocio;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.xsr.config.Conexao;

public class Endereco {

    private int id;
    private int cep;
    private int num;
    private String compl;

	public Endereco() {
	}
	
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCep() {
        return cep;
    }

    public void setCep(int cep) {
        this.cep = cep;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getCompl() {
        return compl;
    }

    public void setCompl(String compl) {
        this.compl = compl;
    }
    
    public void addEnd(int id, int cep, int num, String compl, int usuario) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "insert into endereco (id,cep,num,compl,usuario) values("+id+","+cep+","+num+","+compl+","+usuario+")";
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
	public void alterEnd(int usuario) throws IOException, SQLException, Exception {
	    Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "update endereco set id="+this.getId()+", cep="+this.getCep()+", num="+this.getNum()+", compl="+this.getCompl()+" where usuario=" + usuario;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
	public void excEnd(int usuario) throws IOException, SQLException, Exception {
	    Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "delete from endereco where usuario="+usuario;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
    
	public void findEnd(int usuario) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "select * from endereco where usuario="+usuario;
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			this.setId(rs.getInt("id"));
			this.setCep(rs.getInt("cep"));
			this.setNum(rs.getInt("num"));
			this.setCompl(rs.getString("compl"));
		}
		cb.fecharConexao(con, stmt, rs);
	}
}