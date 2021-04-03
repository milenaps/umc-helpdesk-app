<!-- Manter Categorias -->
<%@ page import="java.util.*"%>
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
		<title>Xtreme Service Request - Categorias</title>
		
		<%@ include file="styles.css" %>
		<script type="text/javascript">
			function validar() {
				if (document.form_adicionar.nome.value=="") {
					alert('Dê um nome à categoria');
					return false;
				} else { return true; }
			}
		</script>
	</head>

	<body >
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
								<%	} if (u.getTipo().getTela3()!=1) { %>
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
					<br /><p class="title">Categorias</p><br />
					<table border="0" class="tbl" cellpadding="2" align="center" width="65%">
						<%
							Categoria c = new Categoria();
							Vector vet = c.listarTodos();
							int rep = 0;
							
							for(int i=0; i<vet.size();i++)
							{ if (rep == 0) {
						%>
						<tr style="background-color:#C7CA99;" align="center">
							<td><strong>ID</strong></td>
							<td><strong>Tipo</strong></td>
							<td><strong>#Pai</strong></td>
							<td><strong>Alterar</strong></td>
							<td><strong>Add sub<br />categoria</strong></td>
							<td><strong>Excluir</strong></td>
						</tr>
						<% } rep=1; c = (Categoria)vet.elementAt(i); %>
                        <tr style="background-color:#F5F5F5;" align="center">
							<td><strong><%=c.getId()%></strong></td>
							<td align="left" width="40%"><%=c.getNome()%></td>
							<td><strong><% if (c.getPai() == 0 ) { %> - <% } else { %> <%=c.getPai()%> <% } %></strong></td>
							<td>
								<a href="<%=Config.getPageURL()%>AlterarCategoria.jsp?id=<%=c.getId()%>" target="_blank" onclick="window.open('<%=Config.getPageURL()%>AlterarCategoria.jsp?id=<%=c.getId()%>','_blank','height=100,width=300,resizable=no,toolbar=no');return false;">
								<input type="image" src="<%=Config.getImagesURL()%>alt.gif" border="0" /></a>
							</td>
							<td>
								<a href="<%=Config.getPageURL()%>AddSubCategoria.jsp?id=<%=c.getId()%>" target="_blank" onclick="window.open('<%=Config.getPageURL()%>AddSubCategoria.jsp?id=<%=c.getId()%>','_blank','height=100,width=300,resizable=no,toolbar=no');return false;">
								<input type="image" src="<%=Config.getImagesURL()%>add.gif" border="0" /></a>
							</td>
							<td>
								<form name="form_excluir" method="post" action="<%=Config.getServletURL()%>ManterCategorias?id=<%=c.getId()%>">
									<input type="hidden" name="nome" value="<%=c.getNome()%>" />
									<input type="hidden" name="pai" value="<%=c.getPai()%>" />
									<input type="hidden" name="action" value="Excluir" />
									<input type="image" src="<%=Config.getImagesURL()%>trash.gif" border="0" />
								</form>
							</td>
						</tr>
						<%}%>
					</table>
					<br />
					
					<table border="0" class="tbl" width="25%" cellpadding="2" align="center">
						<tr align="center">
							<form name="form_adicionar" method="post" action="<%=Config.getServletURL()%>ManterCategorias?id=<%=c.getId()+1%>" onsubmit="return(validar())">
								<td>&nbsp;</td><td align="left"><input type="text" name="nome" class="fld" value="" size="25" /></td>
								<td><input type="submit" name="action" value="Adicionar" class="btn" /></td>
							</form>
						</tr>
					</table>
					<br />
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>