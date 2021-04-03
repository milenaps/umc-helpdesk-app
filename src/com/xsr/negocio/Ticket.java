package com.xsr.negocio;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.xsr.config.Conexao;

public class Ticket {

    private int id;
    private String titulo;
    private String descricao;
    private String dataAbertura;
	private Categoria categoria = new Categoria();
	private Usuario cliente = new Usuario();
	private Severidade severidade = new Severidade();
	private String status;
	private Usuario responsavel = new Usuario();
	private Vector<Report> vetorReports = new Vector<Report>();

	public Vector<Report> getVetorReports() {
		return vetorReports;
	}

	public void setVetorReports(Vector<Report> vetorReports) {
		this.vetorReports = vetorReports;
	}

	public Ticket() {
	}
		
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getTitulo() {
		return titulo;
	}


	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}


	public String getDescricao() {
		return descricao;
	}


	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Categoria getCategoria() {
		return categoria;
	}


	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}


	public Usuario getCliente() {
		return cliente;
	}


	public void setCliente(Usuario cliente) {
		this.cliente = cliente;
	}


	public Severidade getSeveridade() {
		return severidade;
	}


	public void setSeveridade(Severidade severidade) {
		this.severidade = severidade;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Usuario getResponsavel() {
		return responsavel;
	}

	public void setResponsavel(Usuario responsavel) {
		this.responsavel = responsavel;
	}
	
	public String getDataAbertura() {
		return dataAbertura;
	}

	public void setDataAbertura(String data_abertura) {
		this.dataAbertura = data_abertura;
	}
	
	public void openTicket() throws IOException, SQLException, Exception {
		Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
			
		String sql = "insert into ticket (id,titulo,descricao,categoria,severidade,status,responsavel,cliente,data_abertura)";
		sql += "values("+id+",'"+titulo+"','"+descricao+"',"+getCategoria().getId()+","+getSeveridade().getId()+",";
		sql += "'"+status+"',"+getResponsavel().getId()+","+getCliente().getId()+",'"+dataAbertura+"')";
		stmt.executeUpdate(sql);
		
		con.close();
	}
	
	public void alterTicket() throws IOException, SQLException, Exception {
        Conexao cb = new Conexao();
		Connection con = cb.getConexao();
		Statement stmt = con.createStatement();
		
		String sql = "update ticket set titulo='"+this.getTitulo()+"', descricao='";
		sql += this.getDescricao()+"',  severidade = " + this.getSeveridade().getId();
		sql += ", status = '" + this.getStatus() + "', responsavel = " + this.getResponsavel().getId();
		sql += " where id="+this.getId();
		stmt.executeUpdate(sql);
		con.close();
	}
	public Vector<Ticket> listAll()  {
		Conexao cb = new Conexao();
		Vector<Ticket> vetorTickets = new Vector<Ticket>();
		Ticket tic;
		Connection con = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		try {
			con = cb.getConexao();
			stmt = con.createStatement();
			
			String sql = "select * from ticket order by id";
			rset = stmt.executeQuery(sql);
			
			while (rset.next()) {
				tic = new Ticket();
				tic.setId(rset.getInt("id"));
				tic.setTitulo(rset.getString("titulo"));
				tic.setDescricao(rset.getString("descricao"));
				tic.setDataAbertura(rset.getString("data_abertura"));
				tic.setStatus(rset.getString("status"));
				
				tic.categoria.setId(rset.getInt("categoria"));
				tic.categoria.findCateg();
				
				tic.severidade.setId(rset.getInt("severidade"));
				tic.severidade.findSev();
				
				tic.cliente.setId(rset.getInt("cliente"));
				tic.cliente.findUsuario();
				
				vetorTickets.add(tic);
			}
			con.close();
			stmt.close();
		}
		catch (Exception e) {
			System.out.println("Erro: " + e.getMessage());
		}
		
		return(vetorTickets);
	}
	public Vector<Ticket> listarTodos()  {
		//Declarando atributos para conexão com o BD
		Conexao conector1 = new Conexao();
		Vector<Ticket> vetorTickets = new Vector<Ticket>();
		Report report1;
		Ticket ticket1;
		Connection conexao1;
		Statement transacao1;
		ResultSet resultados;
		String instrucao1;
		try {
			//Conectando-se ao BD e alocando uma transação
			conexao1 = conector1.getConexao();
			transacao1 = conexao1.createStatement();
			
			//Declarando instrução de manipulação do BD
			instrucao1 = "SELECT * FROM ticket, usuario WHERE ticket.responsavel = usuario.id order by ticket.severidade";
			
			//Executando transação
			resultados = transacao1.executeQuery(instrucao1);
			//Adicionando cada um dos resultados encontrados ao Vetor de Tickets
			while (resultados.next()) {
				ticket1 = new Ticket();
				report1 = new Report();
				ticket1.setId(resultados.getInt("id"));
				ticket1.setTitulo(resultados.getString("titulo"));
				ticket1.setDescricao(resultados.getString("descricao"));
				ticket1.setDataAbertura(resultados.getString("data_abertura"));
				ticket1.setStatus(resultados.getString("status"));
				
				//Preenchendo objetos de relacionamento		
				ticket1.categoria.setId(resultados.getInt("categoria"));
				ticket1.categoria.findCateg();
				
				ticket1.severidade.setId(resultados.getInt("severidade"));
				ticket1.severidade.findSev();
				
				ticket1.cliente.setId(resultados.getInt("cliente"));
				ticket1.cliente.findUsuario();
				
				ticket1.responsavel.setId(resultados.getInt(10));
				ticket1.responsavel.findUsuario();
				
				ticket1.setVetorReports((report1.localizarPorTicket(resultados.getInt("id"))));
				
				vetorTickets.add(ticket1);
			}
			}
			catch (Exception erro1) {
				System.out.println("Erro: " + erro1.getMessage());
			}
			return(vetorTickets);
	}
	
	public Vector<Ticket> listarPorTexto() throws SQLException, IOException, Exception {
		Conexao conector1 = new Conexao();
		Connection conexao1;
		Statement transacao1;
		ResultSet resultados;
		Ticket ticket1;
		Vector<Ticket> vetorTicket = new Vector<Ticket>();
		Vector<String> vetorColuna = new Vector<String>();
		Vector<String> vetorValor = new Vector<String>();
		String instrucao1;
		
		vetorColuna.addElement("ticket.descricao"); vetorValor.addElement(this.descricao);
		vetorColuna.addElement("categoria.nome"); vetorValor.addElement(this.categoria.getNome());
		vetorColuna.addElement("resp.nome"); vetorValor.addElement(this.responsavel.getNome());
		vetorColuna.addElement("cli.nome"); vetorValor.addElement(this.cliente.getNome());
		vetorColuna.addElement("severidade.nome"); vetorValor.addElement(this.severidade.getNome());
		vetorColuna.addElement("ticket.status"); vetorValor.addElement(this.getStatus());
		
		conexao1 = conector1.getConexao();
		transacao1 = conexao1.createStatement();
		
		for(int i = 0; i < vetorColuna.size(); i++) {
			instrucao1 = "SELECT * FROM ticket, categoria, severidade, usuario as resp, usuario as ";
			instrucao1 += "cli WHERE ticket.categoria = categoria.id  AND ticket.severidade = ";
			instrucao1 += "severidade.id AND ticket.cliente = cli.id AND ticket.responsavel = ";
			instrucao1 += "resp.id AND upper(" + vetorColuna.elementAt(i) + ") like '%" + vetorValor.elementAt(i).toUpperCase() + "%' order by ticket.severidade";

			resultados = transacao1.executeQuery(instrucao1);

			while (resultados.next()) {
				ticket1 = new Ticket();
				ticket1.setId(resultados.getInt("id"));
				ticket1.setTitulo(resultados.getString("titulo"));
				ticket1.setDescricao(resultados.getString("descricao"));
				ticket1.setStatus(resultados.getString("status"));

				//Preenchendo objetos de relacionamento		
				ticket1.categoria.setId(resultados.getInt("categoria"));
				ticket1.categoria.findCateg();

				ticket1.severidade.setId(resultados.getInt("severidade"));
				ticket1.severidade.findSev();

				ticket1.cliente.setId(resultados.getInt("cliente"));
				ticket1.cliente.findUsuario();

				ticket1.responsavel.setId(resultados.getInt(16));
				ticket1.responsavel.findUsuario();

				if (!vetorTicket.contains(ticket1)) {
					vetorTicket.add(ticket1);
				}
			}
			resultados.close();
		}
		transacao1.close();
		conexao1.close();
		return(vetorTicket);
	}

	public Vector<Ticket> listarPorResponsavel() throws SQLException, IOException, Exception {
		Conexao conector1 = new Conexao();
		Connection conexao1;
		Statement transacao1;
		ResultSet resultados;
		Ticket ticket1;
		Vector<Ticket> vetorTicket = new Vector<Ticket>();
		Vector<String> vetorColuna = new Vector<String>();
		Vector<String> vetorValor = new Vector<String>();
		String instrucao1;
		
		vetorColuna.addElement("ticket.descricao"); vetorValor.addElement(this.descricao);
		
		if (!this.categoria.getNome().equals("")) {
		vetorColuna.addElement("categoria.nome"); vetorValor.addElement(this.categoria.getNome());
		}
		if (!this.descricao.equals("")) {
		vetorColuna.addElement("cli.nome"); vetorValor.addElement(this.cliente.getNome());
		}
		if (!this.descricao.equals("")) {
		vetorColuna.addElement("severidade.nome"); vetorValor.addElement(this.severidade.getNome());
		}
		
		conexao1 = conector1.getConexao();
		transacao1 = conexao1.createStatement();
		
		for(int i = 0; i < vetorColuna.size(); i++) {
			instrucao1 = "SELECT * FROM ticket, categoria, severidade, usuario as resp, usuario as ";
			instrucao1 += "cli WHERE ticket.categoria = categoria.id  AND ticket.severidade = ";
			instrucao1 += "severidade.id AND ticket.cliente = cli.id AND ticket.responsavel = ";
			instrucao1 += "resp.id AND upper(" + vetorColuna.elementAt(i) + ") like '%" + vetorValor.elementAt(i).toUpperCase() + "%' ";
			instrucao1 += " AND resp.nome = '" + this.responsavel.getNome() + "' order by ticket.severidade;";

			resultados = transacao1.executeQuery(instrucao1);

			while (resultados.next()) {
				ticket1 = new Ticket();
				ticket1.setId(resultados.getInt("id"));
				ticket1.setTitulo(resultados.getString("titulo"));
				ticket1.setDescricao(resultados.getString("descricao"));
				ticket1.setStatus(resultados.getString("status"));

				//Preenchendo objetos de relacionamento		
				ticket1.categoria.setId(resultados.getInt("categoria"));
				ticket1.categoria.findCateg();

				ticket1.severidade.setId(resultados.getInt("severidade"));
				ticket1.severidade.findSev();

				ticket1.cliente.setId(resultados.getInt("cliente"));
				ticket1.cliente.findUsuario();

				ticket1.responsavel.setId(resultados.getInt(16));
				ticket1.responsavel.findUsuario();
				vetorTicket.add(ticket1);
				System.out.println("Valor: " + ticket1.getTitulo());
			}
		resultados.close();
		}
		transacao1.close();
		conexao1.close();
		return(vetorTicket);
	}
	
	public void findTicket() throws SQLException, IOException, Exception {
		Conexao conector1 = new Conexao();
		Connection conexao1;
		Statement transacao1;
		ResultSet resultados;
		Report report1;
		String instrucao1;

		conexao1 = conector1.getConexao();
		transacao1 = conexao1.createStatement();
		
		instrucao1 = "SELECT * FROM ticket, categoria, severidade, usuario as resp, usuario as ";
		instrucao1 += "cli WHERE ticket.categoria = categoria.id  AND ticket.severidade = ";
		instrucao1 += "severidade.id AND ticket.cliente = cli.id AND ticket.responsavel = ";
		instrucao1 += "resp.id AND ticket.id = " + this.id;

		resultados = transacao1.executeQuery(instrucao1);

		if (resultados.next()) {
			report1 = new Report();
			this.setId(resultados.getInt("id"));
			this.setTitulo(resultados.getString("titulo"));
			this.setDescricao(resultados.getString("descricao"));
			this.setStatus(resultados.getString("status"));
			this.setDataAbertura(resultados.getString("data_abertura"));

			//Preenchendo objetos de relacionamento		
			this.categoria.setId(resultados.getInt("categoria"));
			this.categoria.findCateg();
	
			this.severidade.setId(resultados.getInt("severidade"));
			this.severidade.findSev();

			this.cliente.setId(resultados.getInt("cliente"));
			this.cliente.findUsuario();

			this.responsavel.setId(resultados.getInt(16));
			this.responsavel.findUsuario();
			
			this.setVetorReports((report1.localizarPorTicket(resultados.getInt("id"))));
		}
		resultados.close();
		transacao1.close();
		conexao1.close();
	}
}