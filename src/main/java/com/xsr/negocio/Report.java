package com.xsr.negocio;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.xsr.config.Conexao;

public class Report {

    private int id;
    private String descricao;
    private String solucaoFinal;
	private Status status = new Status();
    private String dataHora;
    private Usuario responsavel = new Usuario();

	public Usuario getResponsavel() {
		return responsavel;
	}

	public void setResponsavel(Usuario responsavel) {
		this.responsavel = responsavel;
	}

	public Report() {
	}
	
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getSolucaoFinal() {
        return solucaoFinal;
    }

    public void setSolucaoFinal(String solucaoFinal) {
        this.solucaoFinal = solucaoFinal;
    }
	
	public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

	public String getDataHora() {
		return dataHora;
	}

	public void setDataHora(String dataHora) {
		this.dataHora = dataHora;
	}
    
	public Vector<Report> localizarPorTicket(int ticket) throws SQLException, IOException, Exception {
		Conexao conector1 = new Conexao();
		Vector<Report> vetorReport = new Vector<Report>();
		Report rep;
		Connection conexao1;
		Statement stmt;
		ResultSet rset;
		String sql;
		
		conexao1 = conector1.getConexao();
		stmt = conexao1.createStatement();
		sql = "SELECT * FROM report WHERE ticket = " + ticket;
		rset = stmt.executeQuery(sql);
		
		while (rset.next()) {
			rep = new Report();
			rep.setId(rset.getInt("id"));
			rep.setDescricao(rset.getString("descricao"));
			rep.setSolucaoFinal(rset.getString("solucao_final"));
			rep.getStatus().setId(rset.getInt("status"));
			rep.setDataHora(rset.getString("data_hora"));
			rep.getStatus().findStatus();
			rep.getResponsavel().setId(rset.getInt("responsavel"));
			rep.getResponsavel().findUsuario();
			vetorReport.addElement(rep);
		}
		return(vetorReport);
	}
	
	public void regReport(int id, int ticket, int status, int resp) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "insert into report (id, ticket, descricao, data_hora, status, responsavel) values ("+id+","+ticket+",'"+this.descricao+"','"+this.dataHora+"',"+status+","+resp+")";
		ResultSet rs = stmt.executeQuery(sql);
		rs.close();
		con.close();
	}
	
	public Vector<Report> listAll() throws IOException, Exception {
		Report rep;
		Vector<Report> vetRep = new Vector<Report>();
		
		try {
			Conexao cb = new Conexao();
			Connection con = cb.getConexao();
			Statement stmt = con.createStatement();
			String sql = "select * from report order by id";
			
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				rep = new Report();
				rep.setId(rs.getInt("id"));
				rep.setDescricao(rs.getString("descricao"));
				rep.setSolucaoFinal(rs.getString("solucao_final"));
				rep.setDataHora(rs.getString("data_hora"));
				rep.getStatus().setId(rs.getInt("status"));
				rep.getResponsavel().setId(rs.getInt("responsavel"));
				vetRep.add(rep);
			}
			
			rs.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Erro: " + e.getMessage());
		}
		return vetRep;
	}
}