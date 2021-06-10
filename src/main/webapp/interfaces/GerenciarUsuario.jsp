<!-- Manter Usuários - Novo usuário -->
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
		<title>Xtreme Service Request - Gerenciamento de usu&aacute;rios</title>
		
		<%@ include file="styles.css" %>
		
		<script type="text/javascript">
			function validar() {
				
			}

			function chamarCadastrar() {
				
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
									Usuario u = (Usuario)session.getAttribute("login");
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
				<%
					Usuario usu = new Usuario();
						//(Usuario)session.getAttribute("usuario");
				%>
				<form name="form_usuario" method="post" action="<%=Config.getServletURL()%>ManterUsuarios?id=<%=usu.getId()%>">
					<p class="emphasis"><br />
						<strong>Gerenciamento de usu&aacute;rios</strong><br />
						<span class="small">Aten&ccedil;&atilde;o! Os campos com textos escritos em verde s&atilde;o de preenchimento obrigat&oacute;rio.</span>
					</p><br />
					<table border="0" class="tbl" cellpadding="2" cellspacing="1">
						<tr style="background-color:#F5F5F5;font-size:1px;"><td colspan="3" align="center">&nbsp;</td></tr>
						<% if (usu != null) { %>
							<tr><td><strong>ID</strong></td><td colspan="2"><input type="text" align="right" value="<%=usu.getId()%>" class="fld" size="5" disabled /></td></tr>
						<% } %>
						<tr>
							<td><strong><span style="color:#0FB00F;">Tipo</span></strong></td>
							<td colspan="2" valign="center">
								<%	TipoDeAcesso ta = new TipoDeAcesso();
									//ta = (TipoDeAcesso)request.getAttribute("tipo");
									Vector vetorTipo = new Vector();
									vetorTipo = ta.listarTodos();
								%>
								<select class="fld" name="categoria"><option>Selecione</option>
									<% for (int i=0;i < vetorTipo.size(); i++) {%><option value="<%=((TipoDeAcesso)vetorTipo.get(i)).getId()%>"><%=((TipoDeAcesso)vetorTipo.get(i)).getNome()%></option><%}%>
								</select>
							</td>
						</tr>
						<tr style="background-color:#F5F5F5;font-size:1px;"><td colspan="3" align="center">&nbsp;</td></tr>
						<tr><td><strong><span style="color:#0FB00F;">Nome</span></strong></td><td colspan="2"><input type="text" name="nome" value="" class="fld" size="30" /></td></tr>
						<tr><td><strong>CNPJ</strong></td><td colspan="2"><input type="text" onkeypress="if (!isNaN(String.fromCharCode(window.event.keyCode))) return true; else return false;" value="" class="fld" size="12" name="cnpj" />&nbsp;<span class="small">(Somente n&uacute;meros)</span></td></tr>
						<tr><td><strong>Contato</strong></td><td colspan="2"><input type="text" value="" class="fld" size="30" name="contato" /></td></tr>
						<tr><td><strong><span style="color:#0FB00F;">CPF</span></strong></td><td colspan="2"><input type="text" value="" onkeypress="if (!isNaN(String.fromCharCode(window.event.keyCode))) {return true;} else {return false;}" class="fld" size="12" name="cpf" />&nbsp;<span class="small">(Somente n&uacute;meros)</span></td></tr>
						<tr>
							<td rowspan="2" valign="top"><strong>Telefone</strong></td>
							<td align="left" colspan="3">DDD&nbsp;&nbsp;&nbsp;N&uacute;mero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tipo</td>
						</tr>
						<tr>
							<td><input type="text" onkeypress="if (!isNaN(String.fromCharCode(window.event.keyCode))) {return true;} else {return false;}" value="" class="fld" name="ddd" size="2" />&nbsp;<input type="text" onkeypress="if (!isNaN(String.fromCharCode(window.event.keyCode))) {return true;} else {return false;}" value="" class="fld" name="num_tel" size="8" /></td>
							<td valign="center">
								<select class="fld" name="tipo_tel">
									<option>Selecione</option>
									<option>Residencial</option>
									<option>Comercial</option>
									<option>Celular</option>
								</select>&nbsp;&nbsp;<a href="#"><img src="<%=Config.getImagesURL()%>add.gif" border="0" /></a>
							</td>
						</tr>
						<tr>
							<td><strong><span style="color:#0FB00F;">CEP</span></strong></td>
							<td><input type="text" value="" onkeypress="if (!isNaN(String.fromCharCode(window.event.keyCode))) {return true;} else {return false;}" class="fld" size="5" name="ddd" />&nbsp;<input type="text" value="" class="fld" size="3" /></td>
							<td align="right"><strong><span style="color:#0FB00F;">N&#176;</span></strong>&nbsp;&nbsp;<input type="text" size="5" class="fld" value="" />&nbsp;&nbsp;<a href="#"><img src="<%=Config.getImagesURL()%>add.gif" border="0" /></a></td>
						</tr>
						<tr><td><strong>Endere&ccedil;o</strong></td><td colspan="2"><input type="text" value="" class="fld" size="30" /></td></tr>
						<tr><td><strong>Complemento</strong></td><td colspan="2"><input type="text" value="" class="fld" size="30" name="complemento" /></td></tr>
						<tr style="background-color:#F5F5F5;font-size:1px;"><td colspan="3" align="center">&nbsp;</td></tr>
						<tr><td><strong><span style="color:#0FB00F;">Login</span></strong></td><td colspan="2"><input type="text" value="" class="fld" size="15" name="login" /></td></tr>
						<tr><td><strong><span style="color:#0FB00F;">Senha</span></strong></td><td colspan="2"><input type="password" value="" class="fld" size="10" name="senha" /></td></tr>
						<tr><td><strong><span style="color:#0FB00F;">Confirma senha</span></strong></td><td colspan="2"><input type="password" value="" class="fld" size="10" name="confirma_senha" /></td></tr>
						<tr style="background-color:#F5F5F5;font-size:1px;"><td colspan="3" align="center">&nbsp;</td></tr>
					</table><br />
					
					<table border="0" align="center">
						<tr><td width="130">&nbsp;</td><td><table border="0" class="btn" cellpadding="2">
						<tr align="center">
							<td><input type="button" name="acao" value="Cadastrar" class="btn" onclick="if (validar()) {chamarCadastrar()}" /></td>
							<td><input type="submit" name="acao" value="Alterar" class="btn" disabled /></td>
							<td><input type="submit" name="acao" value="Excluir" class="btn" disabled /></td>
							<td><input type="reset" name="acao" value="Cancelar" class="btn" /></td>
						</tr>
						<tr><td colspan="4"><p align="center"<strong><a href="javascript:history.back()"><img src="<%=Config.getImagesURL()%>mark.gif" border="0" />&nbsp;Voltar</a></strong></p></td></tr>
					</table></td></tr></table>
				</form><br />
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>