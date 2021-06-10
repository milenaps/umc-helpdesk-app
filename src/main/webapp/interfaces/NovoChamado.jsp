<!-- Tela de Abertura de chamados -->
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.xsr.negocio.*"%>
<%@ page import="com.xsr.controle.*"%>
<%@ page import="com.xsr.config.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="Keywords" content="xtreme service request, umc, pfc, tcc" />
		<meta name="Description" content="This is a page from the Xtreme Service Request system." />
		<meta name="Abstract" content="This is a page from the Xtreme Service Request system." />
		<title>Xtreme Service Request - Abertura de chamados</title>
		
		<%@ include file="styles.css" %>
		<script type="text/javascript">
			function validarEnvio() {
				if (document.form_enviar.titulo.value=="" || document.form_enviar.descricao.value=="") {
					alert('Certifique-se de que todos os campos estão preenchidos para abrir o chamado');
					return false;
				} else if (document.form_enviar.cliente.value=="0") {
					alert('Selecione o cliente');
					return false;
				} else if (document.form_enviar.severidade.value=="0") {
					alert('Selecione a severidade do chamado');
					return false;
				} else if (document.form_enviar.categoria.value=="0") {
					alert('Selecione a categoria do chamado');
					return false;
				} else {
					return true;
				}
			}
		</script>
	</head>

	<body>
         <div align="center">
			<div id="escope">
				<div id="header">&nbsp;</div>
				<div id="mn">
					<table border="0" cellpadding="1" cellspacing="1" class="tbl"width="99%" style="padding:0;">
						<tr>
							<td align="right">
								<%
									Usuario u = (Usuario) session.getAttribute("login");
									if (u != null) { %>
									<%=u.getTipo().getNome()%>: <strong><%=u.getNome()%></strong>
									<input type="button" name="sair" value=" Sair " class="btn" onclick="if(confirm('Tem certeza de que deseja sair?')) { window.location.href='<%=Config.getPageURL()%>Autenticar.jsp'; } else { }" />&nbsp;&nbsp;
								<%	} if (u.getTipo().getTela6()!=1) { %>
								<script type="text/javascript">window.location.href="<%=Config.getPageURL()%>AcessoNaoAutorizado.jsp";</script>
								<% } %>
							</td>
						</tr>                                                 
					</table>
				</div>
				<div id="menu">
					<div id="spc">&nbsp;</div>
					<% if (u.getTipo().getTela1() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterTiposDeAcesso.jsp">&nbsp;N&iacute;veis de acesso</a></div>
					<% } %>
					<% if (u.getTipo().getTela4() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterSeveridades.jsp">&nbsp;Severidades</a></div>
					<% } %>
					<% if (u.getTipo().getTela5() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterStatus.jsp">&nbsp;Status</a></div>
					<% } %>
					<% if (u.getTipo().getTela3() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterCategorias.jsp">&nbsp;Categorias</a></div>
					<% } %>
					<% if (u.getTipo().getTela2() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterUsuarios.jsp">&nbsp;Usuários</a></div>
					<% } %>
					<% if (u.getTipo().getTela6() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>NovoChamado.jsp">&nbsp;Abrir chamado</a></div>
					<% } %>
					<% if (u.getTipo().getTela7() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>FilaDeChamados.jsp">&nbsp;Fila de chamados</a></div>
					<% } %>
					<% if (u.getTipo().getTela7() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>BaseDeSolucoes.jsp">&nbsp;Base de soluções</a></div>
					<% } %>
					<% if (u.getTipo().getTela9() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>RelatorioGeral.jsp">&nbsp;Relatório Geral</a></div>
					<% } %>
					<div id="mn_fim">&nbsp;</div>
					<div style="padding-bottom:220px;">&nbsp;</div>
				</div>
				
				<%
					Ticket ticket = new Ticket();
					Ticket tic = (Ticket) request.getAttribute("ticket");
					Vector vetTicket = ticket.listAll();
					for (int i=0; i < vetTicket.size(); i++) {
						ticket = (Ticket)vetTicket.elementAt(i);
					}
				%>
				<form name="form_enviar" method="post" action="<%=Config.getServletURL()%>ManterTickets" onsubmit="return(validarEnvio())">
				<input type="hidden" name="id" value="<%=ticket.getId()+1%>" />
				<input type="hidden" name="status" value="Aberto" />
				<div id="content">
					<br /><p class="title">Novo chamado</p><br />
					<table border="0" class="tbl" cellpadding="1" align="center">
						<tr style="background-color:#F5F5F5;font-size:1px;"><td colspan="2" align="center">&nbsp;</td></tr>
						<tr>
							<% Calendar cal = Calendar.getInstance(); SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");%>
							<input type="hidden" name="data" value="<%=sdf.format(cal.getTime())%>" />
							<td><strong>Data</strong></td>
							<td><input type="text" name="data" value="<%=sdf.format(cal.getTime())%>" class="fld" size="10" disabled /></td>
						</tr>
						<% if (!(u.getTipo().getNome().equalsIgnoreCase("cliente"))) { %>
						<tr>
							<td><strong>Cliente</strong></td>
							<td>
								<%	Usuario usuario = new Usuario();
									Vector vetorSev = new Vector();
									vetorSev = usuario.listarTodos();
								%>	
								<select class="fld" name="cliente"><option value="0"> -- Selecione -- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
									<% for (int i=1;i < vetorSev.size(); i++) { %><option value="<%=((Usuario)vetorSev.elementAt(i)).getId()%>"<%if (tic!= null) { if (((Usuario)vetorSev.elementAt(i)).getId() == tic.getCliente().getId()) {%> selected="yes" <%}} %>><%=((Usuario)vetorSev.elementAt(i)).getNome()%></option><%}%>
								</select>
							</td>
						</tr>
						<% } else {%>
							<input type="hidden" name="cliente" value="<%=u.getId()%>" />
						<% } %>
						<tr style="background-color:#F5F5F5;font-size:1px;"><td colspan="2" align="center">&nbsp;</td></tr>
						<tr>
							<td><strong>Severidade</strong></td>
							<td>
								<%	Severidade sev = new Severidade();
									Vector vetorSev = new Vector();
									vetorSev = sev.listarTodos();
								%>	
								<select class="fld" name="severidade"><option value="0"> -- Selecione -- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
									<% for (int i=0;i < vetorSev.size(); i++) { %><option value="<%=((Severidade)vetorSev.elementAt(i)).getId()%>"<%if (tic != null) { if (((Severidade)vetorSev.elementAt(i)).getId() == tic.getSeveridade().getId()) {%> selected="yes" <%}} %>><%=((Severidade)vetorSev.elementAt(i)).getNome()%></option><%}%>
								</select>
							</td>
						</tr>
						<tr>
							<td><strong>Categoria</strong></td>
							<td>
								<%	Categoria categ = new Categoria();
									Vector vetorCateg = new Vector();
									vetorCateg = categ.listarTodos();
								%>
								<select class="fld" name="categoria"><option value="0"> -- Selecione -- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
									<% for (int i=0; i < vetorCateg.size(); i++) {%><option value="<%=((Categoria)vetorCateg.elementAt(i)).getId()%>"<%if (tic != null) { if (((Categoria)vetorCateg.elementAt(i)).getId() == tic.getCategoria().getId()) {%> selected="yes" <%}} %>><%=((Categoria)vetorCateg.elementAt(i)).getNome()%></option><%}%>
								</select>
							</td>
						</tr>
						<tr style="font-size:1px;"><td colspan="2" align="center">&nbsp;</td></tr>
						<tr><td><strong>T&iacute;tulo</strong></td><td><input type="text" value="<%if (tic == null) {} else {%><%=tic.getTitulo()%><%}%>" class="fld" size="30" name="titulo" /></td></tr>
						<tr><td colspan="2"><strong>Descri&ccedil;&atilde;o</strong></td></tr>
						<tr><td colspan="2"><% if (tic == null) {%><textarea cols="40" rows="5" name="descricao"></textarea><%} else {%><textarea cols="40" rows="5" name="descricao"><%=tic.getDescricao()%></textarea></td></tr><%}%>
					</table>
					<br />
					<input type="hidden" name="action" value="abrirChamado" />
					<center><input type="submit" value="Enviar" class="btn" />&nbsp;&nbsp;&nbsp;
					<input type="reset" value="Cancelar" class="btn" /></center><br /><br />
				</div>
				</form>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>