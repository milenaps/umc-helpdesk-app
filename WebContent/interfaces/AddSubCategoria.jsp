<!-- Adicionar Sub-Categoria -->
<%@ page import="com.xsr.negocio.*"%>
<%@ page import="com.xsr.config.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@page import="java.util.List"%><html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="Keywords" content="xtreme service request, umc, pfc, tcc" />
		<meta name="Description" content="This is a page from the Xtreme Service Request system." />
		<meta name="Abstract" content="This is a page from the Xtreme Service Request system." />
		<title>Xtreme Service Request - Categorias</title>
		<%
			Categoria c = new Categoria();
			Usuario u = (Usuario) session.getAttribute("login");
		   if (u.getTipo().getTela3()!=1) { %>
		<script type="text/javascript">window.close();window.location.href="<%=Config.getPageURL()%>AcessoNaoAutorizado.jsp";</script>
		<% } %>
		<script type="text/javascript">
			function validar() {
				if (document.form_addsub.nome.value=="") {
					alert('Digite o nome da categoria');
					return false;
				} else { return true; }
			}

			function chamarAddSub() {
				<%
					List vet = c.listarTodos();
					for(int i=0; i<vet.size();i++)
					{ c = (Categoria)vet.get(i);}
				%>
				document.form_addsub.action="<%=Config.getServletURL()%>ManterCategorias?id=<%=c.getId()+1%>";
				document.form_addsub.submit();
				window.opener.location.reload();
				window.close();
			}
		</script>
		<%@ include file="styles.css" %>
	</head>
	<body style="background-color:#FFFFFF">
         <div align="center">
			<p style="font-family:Verdana;font-size:12px;"><b>Adicionar Sub-Categoria</b></p>
			<table border="0" class="tbl" cellpadding="2">
				<form name="form_addsub" method="post" action="<%=Config.getPageURL()%>AddSubCategoria.jsp">
					<%
						c.setId(Integer.parseInt(request.getParameter("id")));
						c.findCateg();
					%>
					<input type="hidden" name="pai" value="<%=c.getId()%>" />
					<input type="hidden" name="action" value="AddSub" />					
					<tr align="center">
						<td colspan="2"><input type="text" name="nome" class="fld" value="<%=c.getNome()%>" size="30" /></td>
					</tr>
					<tr><td colspan="10" align="center"><table border="0" class="btn"><tr>
						<td align="right"><input type="button" name="acao" value="Salvar" class="btn" onclick="if (validar()) {chamarAddSub()}" /></td>
						<td align="left"><input type="button" name="acao" value="Cancelar" class="btn" onclick="window.close();" /></td>
					</table></td></tr>
				</form>
			</table>
		</div>
	</body>
</html>