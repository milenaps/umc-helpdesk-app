<!-- Manter Usuários - Tela de Consulta -->
<%@ page import="java.util.*"%>
<%@ page import="com.xsr.negocio.*"%>
<%@ page import="com.xsr.controle.*"%>
<%@ page import="com.xsr.config.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="Keywords" content="doc, documentation, xtreme service request, umc, pfc, tcc" />
		<meta name="Description" content="This is the documentation of Xtreme Service Request system." />
		<meta name="Abstract" content="This is the documentation of Xtreme Service Request system." />
		<title>Xtreme Service Request - Gerenciamento de usu&aacute;rios</title>
		
		<%@ include file="styles.css" %>
		<script type="text/javascript">
			function buscar() {
				if (document.form_buscar.fld_busca.value=="") {
					alert("Digite algum valor para efetuar a busca");
					return false;
				} else { return true; }
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
								<%	} if (u.getTipo().getTela2()!=1) { %>
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
				
				<div width="90%">
					<p class="emphasis"><br />
						<strong>Gerenciamento de usu&aacute;rios</strong>
					</p><br />
					<table border="0" class="tbl" cellpadding="1">
						<form name="form_buscar" method="post" action="<%=Config.getServletURL()%>ManterUsuarios">
							<tr><td colspan="5"><strong>Pesquisa por login ou nome do usuário</strong></td></tr>
							<tr>
								<td><input type="text" name="login" size="10" /></td>
								<td><input type="text" name="nome" size="20" /></td>
								<td><input type="submit" class="btn" name="action" value="Buscar" /></td><td>&nbsp;</td>
								<td><a href="<%=Config.getPageURL()%>GerenciarUsuario.jsp"><input name="adicionar" disabled type="button" value="Adicionar" class="btn" /></a></td>
							</tr>
						</form>
					</table>
					<br />
					
					<table border="0" class="tbl" width="60%" cellpadding="2">
					<%	Vector vetorUsu = new Vector();
						Usuario usu;
						vetorUsu = (Vector)request.getAttribute("vetorUsu");
						int rep = 0;
						
						if (vetorUsu != null) {
							for (int i=0; i < vetorUsu.size(); i++) {
								usu = new Usuario();
								
								if (rep == 0) {
							%>
							<tr style="background-color:#C7CA99;" align="center">
								<td width="50"><strong>ID</strong></td>
								<td><strong>Login</strong></td>
								<td><strong>Nome</strong></td>
								<td><strong>Tipo de acesso</strong></td>
								<td width="30"><strong>Visualizar</strong></td>
							</tr>
							<%	} rep = 1;
								usu = (Usuario) vetorUsu.elementAt(i);
							%>
							<tr style="background-color:#F5F5F5;" align="center" valign="center">
								<td><%=usu.getId() %></td>
								<td><%=usu.getNome() %></td>
								<td><%=usu.getLogin() %></td>
								<td><%=usu.getTipo().getNome() %></td>
								<td><a href="<%=Config.getPageURL()%>GerenciarUsuarios.jsp?id=<%=usu.getId()%>"><input type="image" src="<%=Config.getImagesURL()%>view.gif" border="0" /></a></td>
							</tr>
					<%		}
						}
					%>
					</table>
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>