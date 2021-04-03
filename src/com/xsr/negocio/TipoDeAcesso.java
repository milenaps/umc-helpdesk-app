package com.xsr.negocio;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.xsr.config.Conexao;

public class TipoDeAcesso {

    private int id;
    private String nome;
	private int tela1;
	private int tela2;
	private int tela3;
	private int tela4;
	private int tela5;
	private int tela6;
	private int tela7;
	private int tela8;
	private int tela9;

	public TipoDeAcesso() {
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
	
	public int getTela1() {
		return tela1;
	}

	public void setTela1(int tela1) {
		this.tela1 = tela1;
	}

	public int getTela2() {
		return tela2;
	}

	public void setTela2(int tela2) {
		this.tela2 = tela2;
	}

	public int getTela3() {
		return tela3;
	}

	public void setTela3(int tela3) {
		this.tela3 = tela3;
	}

	public int getTela4() {
		return tela4;
	}

	public void setTela4(int tela4) {
		this.tela4 = tela4;
	}

	public int getTela5() {
		return tela5;
	}

	public void setTela5(int tela5) {
		this.tela5 = tela5;
	}

	public int getTela6() {
		return tela6;
	}

	public void setTela6(int tela6) {
		this.tela6 = tela6;
	}

	public int getTela7() {
		return tela7;
	}

	public void setTela7(int tela7) {
		this.tela7 = tela7;
	}

	public int getTela8() {
		return tela8;
	}

	public void setTela8(int tela8) {
		this.tela8 = tela8;
	}

	public int getTela9() {
		return tela9;
	}

	public void setTela9(int tela9) {
		this.tela9 = tela9;
	}

	public void addTipo() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "insert into tipodeacesso values("+id+",'"+nome+"',"+tela1+","+tela2+","+tela3+","+tela4+","+tela5+","+tela6+","+tela7+","+tela8+","+tela9+")";
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
    
    public void alterTipo(int id, String nome, int tela1, int tela2, int tela3, int tela4, int tela5, int tela6, int tela7, int tela8, int tela9) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "update tipodeacesso set nome='"+nome+"',tela1="+tela1+",tela2="+tela2+",tela3="+tela3+",tela4="+tela4+",tela5="+tela5+",tela6="+tela6+",tela7="+tela7+",tela8="+tela8+",tela9="+tela9+" where id="+this.getId();
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
    
    public void excTipo(int id) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "delete from tipodeacesso where id="+id;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
    
    public void findTipo() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "select * from tipodeacesso where id="+this.getId();
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
            this.setId(rs.getInt("id"));
            this.setNome(rs.getString("nome"));
			this.setTela1(rs.getInt("tela1"));
			this.setTela2(rs.getInt("tela2"));
			this.setTela3(rs.getInt("tela3"));
			this.setTela4(rs.getInt("tela4"));
			this.setTela5(rs.getInt("tela5"));
			this.setTela6(rs.getInt("tela6"));
			this.setTela7(rs.getInt("tela7"));
			this.setTela8(rs.getInt("tela8"));
			this.setTela9(rs.getInt("tela9"));
		}
		cb.fecharConexao(con, stmt, rs);
	}
    
	public Vector<TipoDeAcesso> listarTodos() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("select * from tipodeacesso order by id");
		Vector<TipoDeAcesso> vetTipo = new Vector<TipoDeAcesso>();
        TipoDeAcesso ta;
        
        while(rs.next()) {
            ta = new TipoDeAcesso();
            ta.setId(rs.getInt("id"));
            ta.setNome(rs.getString("nome"));
			ta.setTela1(rs.getInt("tela1"));
			ta.setTela2(rs.getInt("tela2"));
			ta.setTela3(rs.getInt("tela3"));
			ta.setTela4(rs.getInt("tela4"));
			ta.setTela5(rs.getInt("tela5"));
			ta.setTela6(rs.getInt("tela6"));
			ta.setTela7(rs.getInt("tela7"));
			ta.setTela8(rs.getInt("tela8"));
			ta.setTela9(rs.getInt("tela9"));
			vetTipo.add(ta);
		}
        cb.fecharConexao(con, stmt, rs);
		
		return vetTipo;
    }
}