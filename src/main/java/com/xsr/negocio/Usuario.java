package com.xsr.negocio;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.xsr.config.Conexao;

public class Usuario {

    private int id;
	public TipoDeAcesso tipo = new TipoDeAcesso();
    private String nome;
    private long cnpj;
    private String contato;
    private long cpf;
	private Endereco endereco = new Endereco();
	private Telefone telefone = new Telefone();
    private String login;
    private String senha;

	public Usuario() {
	}
	
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

	public TipoDeAcesso getTipo() {
		return tipo;
	}
	
	public void setTipo(TipoDeAcesso tipo) {
		this.tipo = tipo;
	}
	
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getContato() {
        return contato;
    }

    public void setContato(String contato) {
        this.contato = contato;
    }
	
    public long getCnpj() {
		return cnpj;
	}

	public void setCnpj(long cnpj) {
		this.cnpj = cnpj;
	}

	public long getCpf() {
		return cpf;
	}

	public void setCpf(long cpf) {
		this.cpf = cpf;
	}

	public Endereco getEndereco() {
		return endereco;
	}

	public void setEndereco(Endereco endereco) {
		this.endereco = endereco;
	}

	public Telefone getTelefone() {
		return telefone;
	}

	public void setTelefone(Telefone telefone) {
		this.telefone = telefone;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
	
	public void addUsuario() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "insert into usuario values("+id+","+getTipo().getId()+",'"+nome+"',"+cnpj+",'"+contato+","+cpf+",'"+login+"','"+senha+"')";
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
    public void alterUsuario() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "update usuario set tipodeacesso="+this.getTipo().getId()+", nome='" + this.getNome()+"', contato=" + this.getCnpj()+", contato='" + this.getContato()+"', cpf="+ this.getCpf()+", login='" + this.getLogin()+"', senha='" + this.getSenha()+"' where id="+this.getId();
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
    
    public void excUsuario(int codigo) throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "delete from usuario where id="+codigo;
		stmt.executeUpdate(sql);
		
		cb.fecharConexao(con, stmt, null);
	}
	
    public Usuario validarLogon() throws IOException, SQLException, Exception {
		Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement st = con.createStatement();
		Usuario usu = new Usuario();
		String sql = "select * from usuario where login = '"+this.getLogin()+"' and senha = '"+this.getSenha()+"'";
		ResultSet rs = st.executeQuery(sql);
		
		if (rs.next()){
			usu.setId(rs.getInt("id"));
			usu.setNome(rs.getString("nome"));
			usu.setCnpj(rs.getInt("cnpj"));
			usu.setContato(rs.getString("contato"));
			usu.setCpf(rs.getLong("cpf"));
			usu.setLogin(rs.getString("login"));
			usu.setSenha(rs.getString("senha"));
			usu.getTipo().setId(rs.getInt("tipodeacesso"));
			usu.getTipo().findTipo();
		}
		else {
			usu = null;
		}
		//cb.fecharConexao(con, st, rs);
		
		return (usu);
	}
	
	public void findUsuario() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "select * from usuario where id = " + this.getId();
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			this.setId(rs.getInt("id"));
			this.setNome(rs.getString("nome"));
			this.setCnpj(rs.getInt("cnpj"));
			this.setContato(rs.getString("contato"));
			this.setCpf(rs.getLong("cpf"));
			this.setLogin(rs.getString("login"));
			this.setSenha(rs.getString("senha"));
			this.getTipo().setId(rs.getInt("tipodeacesso"));
			this.getTipo().findTipo();
			this.getEndereco().findEnd(this.getId());
			this.getTelefone().findTel(this.getId());
		}
		cb.fecharConexao(con, stmt, null);
	}

	public Vector<Usuario> listarPorFiltro() throws SQLException, IOException, Exception {
		Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		PreparedStatement st = null;
		Vector<Usuario> vetUsuario = new Vector<Usuario>();
        Usuario usu;
        
		StringBuffer sql = new StringBuffer();
		sql.append(" select id,login,nome,tipodeacesso from usuario where 1=1 ");
				
		if (getLogin()!=null && !getLogin().trim().equals("")) {
			sql.append(" and upper(login) like % ");
		}
		if (getNome()!=null && !getNome().trim().equals("")) {
			sql.append(" and upper(nome) like % ");
		}
		
		st = con.prepareStatement(sql.toString());
		
		int index = 1;
		if (getLogin()!=null || !getLogin().trim().equals("")) {
			st.setString(index++, getLogin().trim().toUpperCase() + "%");
		}
		if (getLogin()!=null || !getLogin().trim().equals("")) {
			st.setString(index++, getNome().trim().toUpperCase() + "%");
		}
		
		ResultSet rs = st.executeQuery();
		
		while (rs.next()) {
			usu = new Usuario();
			usu.setId(rs.getInt("id"));
			usu.setLogin(rs.getString("login"));
			usu.setNome(rs.getString("nome"));
			usu.getTipo().setId(rs.getInt("tipodeacesso"));
			usu.getTipo().findTipo();
			vetUsuario.add(usu);
		}
		cb.fecharConexao(con, st, rs);
		
		return(vetUsuario);
	}
	
	public Vector<Usuario> listarTodos() throws IOException, SQLException, Exception {
		Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		Vector<Usuario> vetUsuario = new Vector<Usuario>();
        Usuario usu;
		
		String sql = "select * from usuario order by id";
		ResultSet rs = stmt.executeQuery(sql);
		
		while (rs.next()) {
			usu = new Usuario();
			usu.setId(rs.getInt("id"));
			usu.setNome(rs.getString("nome"));
			usu.setCnpj(rs.getInt("cnpj"));
			usu.setContato(rs.getString("contato"));
			usu.setCpf(rs.getLong("cpf"));
			usu.setLogin(rs.getString("login"));
			usu.setSenha(rs.getString("senha"));
			usu.getTipo().setId(rs.getInt("tipodeacesso"));
			usu.getTipo().findTipo();
			
			try {
				usu.getTelefone().findTel(usu.getId());
			}
			catch(Exception e) {
				usu.setTelefone(null);
			}
			vetUsuario.add(usu);			
		}
		cb.fecharConexao(con, stmt, rs);
		
		return(vetUsuario);
	}
}