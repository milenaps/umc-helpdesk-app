<!-- P&aacute;gina de erro -->
<%@ page import="com.xsr.config.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="Keywords" content="xtreme service request, umc, pfc, tcc" />
		<meta name="Description" content="This is a page from the Xtreme Service Request system." />
		<meta name="Abstract" content="This is a page from the Xtreme Service Request system." />
		<title>Xtreme Service Request - Erro na opera&ccedil;&atilde;o</title>
		
		<%@ include file="styles.css" %>
	</head>

	<body>
         <div align="center">
			<div id="escope">
				<div id="header">&nbsp;</div>
				<div width="90%" style="margin-top:120px;margin-bottom:190px;">
					<p class="emphasis">
						<strong>Erro durante execu&ccedil;&atilde;o da opera&ccedil;&atilde;o</strong><br />
						<span class="small"><%=request.getAttribute("Erro")%></span>
					</p>
					<p class="normal"><img src="<%=Config.getImagesURL()%>mark.gif" border="0" /><a href="javascript:history.back();"><strong>&nbsp;Voltar</a></strong></p>
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>