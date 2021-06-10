<!-- Registrar Report -->
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
		<title>Xtreme Service Request - Registrar Report</title>

		<script type="text/javascript">
			function validarEnvio() {
				if (document.report.descricao.value == "" || document.report.status.value == "") {
					alert("Você deve digitar uma descrição ao report e selecionar o status do chamado");
					return false;
				} else {
					return true; }
			}
		</script>
	</head>
	<body>
         <div align="center">
		 <% Status status = new Status();
		 	int ticket = Integer.parseInt(request.getParameter("ticket"));
		  	Vector vetorStatus = new Vector();
		 	vetorStatus = status.listarTodos();%>
			<p style="font-family:Verdana;font-size:12px;"><b>Registrar Report</b></p>
			<table border="0" class="tbl" cellpadding="2">
				<form name="report" method="post" action="<%=Config.getServletURL()%>ManterTickets" onsubmit="return(validarEnvio())">
					<tr align="center">
						<input type="hidden" name="ticket" value="<%=ticket %>" />
						<td colspan="2"><textarea type="text" name="descricao" class="fld" cols="15" rows="5" value=""></textarea></td>
					</tr>
					<tr><td colspan="2"><strong>Status</strong>&nbsp;<select class="fld" name="status" style="width:150px"><option value="" />Selecione&nbsp;</option>
						<%for(int i=0; i < vetorStatus.size();i++) { %>
							<option value="<%=((Status)vetorStatus.elementAt(i)).getId() %>" ><%=((Status)vetorStatus.elementAt(i)).getNome()%></option>
						<%} %>
					</select></td></tr>
					<tr>
						<td align="right"><input type="submit" name="action" value="Registrar" class="btn" onclick="window.close();window.opener.location.reload();" /></td>
						<td align="left"><input type="button" name="cancelar" value="Cancelar" class="btn" onclick="window.close()" /></td>
					</tr>
				</form>
			</table>
		</div>
	</body>
</html>