<!-- Inserção de nova solução -->
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
		<title>Xtreme Service Request - Nova solução</title>
		
		<%@ include file="styles.css" %>
		<script type="text/javascript">
			function validarEnvio() {
				//Implementar se possivel
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
								<%	} if (u.getTipo().getTela7()!=1) { %>
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
				
				<div id="content">
					<br /><p class="title">Base de conhecimentos</p>
					<p class="emphasis" align="center">Nova solu&ccedil;&atilde;o</p><br />
					<form name="pesquisa" method="post" action="<%=Config.getServletURL()%>ManterTickets" onsubmit="return(validarEnvio())">
					<table border="0" class="tbl" cellpadding="2" cellspacing="1" align="center">
						<% 	Ticket ticket = new Ticket();;
							ticket = (Ticket) request.getAttribute("ticket");
						%>
						<tr style="background-color:#F5F5F5;font-size:1px;"><td colspan="2" align="center">&nbsp;</td></tr>
						<tr>
							<% Calendar cal = Calendar.getInstance(); SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");%>
							<input type="hidden" name="data" value="<%=sdf.format(cal.getTime())%>" />
							<td><strong>Data</strong></td>
							<td><input type="text" name="data" value="<%=sdf.format(cal.getTime())%>" class="fld" size="10" disabled /></td>
						</tr>
						<tr style="background-color:#F5F5F5;font-size:1px;"><td colspan="2" align="center">&nbsp;</td></tr>
						<tr><td><strong>Ticket</strong></td><td valign="center"><input type="text" value="<%if (ticket == null) { } else { %><%=ticket.getId() %><% } %>" class="fld" size="5" id="id_ticket" /></td></tr>
						<tr><td><strong>Incidente</strong></td><td><input type="text" value="<%if (ticket == null) { } else { %><%=ticket.getTitulo() %><% } %>" class="fld" size="30" id="incidente" /></td></tr>
						<tr><td colspan="2"><strong>Solu&ccedil;&atilde;o</strong></td></tr>
						<tr><td colspan="2"><textarea cols="35" rows="5" id="solucao">&nbsp;</textarea></td></tr>
					</table>
					<br />
					
					<center>
						<input type="submit" name="action" value="Salvar" class="btn" />&nbsp;
						<input type="reset" value="Cancelar" class="btn" />
					</center><br />
					</form>
					<table border="0" width="40%" align="center">
						<tr valign="bottom">
							<td align="right"><p class="normal"><strong><!-- JSP para fazer voltar sem perder as informações (usar método post) --><a href="#"><img src="<%=Config.getImagesURL()%>mark.gif" border="0" />&nbsp;Voltar</a></strong></p></td>
						</tr>
					</tr>
					</table><br />
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>