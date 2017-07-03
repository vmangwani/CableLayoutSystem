<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script>
	function cnfrm() 
	{
    	if(confirm("Disconnect???"))
    	{
    		return true;
    	}
    	else
    	{
			return false;    
    	}
	}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Disconnecting</title>
<link rel="Stylesheet" type="text/css" href="css/style.css ">
</head>
<body bgcolor="#D1D0CE">
	<table class="temppage" width=100% height=20%>
			<tr>
				<th align="left"><h1><font color='white' face="cooper black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Welcome To Cable Layout Assistance</font></h1></th>
				<th align="right">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<a href="profile.jsp"><input type="button" value="Profile" name="prof" class="s1"></a><a href="create.jsp"><input type="button" value="Create a sector" name="crt" class="s1"></a><a href="userfrontend.jsp"><input type="submit" value="Establishing new connection" class="s1"></a><a href="disconnection.jsp"><input type="button" value="Disconnection" class="s1"></a><a href="signout.jsp"><input type="button" value="Signout" class="s1"></a></th>
			</tr>
	</table>
<div style="float:left;">
	<%
	try
	{
		String sec2= (String)session.getAttribute("sect");
		String sec1= (String)session.getAttribute("s");
		String lo1= (String)session.getAttribute("l1");
		String lo2= (String)session.getAttribute("l2");
    	String driver="com.ibm.db2.jcc.DB2Driver";
		String url="jdbc:db2://localhost:50000/opdb1";
		String username="AbhishekAbi";
		String password="microsoft";
		Class.forName(driver);
		Connection con=DriverManager.getConnection(url, username, password);
		PreparedStatement ps1=con.prepareStatement("select * from bhargav.connections where sector=?");
		ps1.setString(1, sec2);
		ResultSet rs1=ps1.executeQuery();
		PreparedStatement ps2=con.prepareStatement("select * from bhargav.connections where sector=? and location1=?");
		ps2.setString(1, sec1);
		ps2.setString(2, lo1);
		ResultSet rs2=ps2.executeQuery();
		PreparedStatement ps9=con.prepareStatement("select * from bhargav.connections where sector=? and location2=?");
		ps9.setString(1, sec1);
		ps9.setString(2, lo1);
		ResultSet rs9=ps9.executeQuery();
		PreparedStatement ps3=con.prepareStatement("select * from bhargav.connections where sector=? and location1=?");
		ps3.setString(1, sec1);
		ps3.setString(2, lo2);
		ResultSet rs3=ps3.executeQuery();
		PreparedStatement ps8=con.prepareStatement("select * from bhargav.connections where sector=? and location2=?");
		ps8.setString(1, sec1);
		ps8.setString(2, lo2);
		ResultSet rs8=ps8.executeQuery();
		if(rs2.next()||rs9.next())
		{
			
		}
		else
		{
			PreparedStatement ps4=con.prepareStatement("delete from bhargav.sector_db where sector=? and db=?");
			ps4.setString(1, sec1);
			ps4.setString(2, lo1);
			int s4=ps4.executeUpdate();	
			if(s4!=0)
			{
				PreparedStatement ps5=con.prepareStatement("update bhargav.sector_no_db set no_db=no_db-"+1+" where sector=?");
				ps5.setString(1,sec1);
				int s5=ps5.executeUpdate();		
			}
		}
		if(rs3.next()||rs8.next())
		{
			
		}
		else
		{
			PreparedStatement ps6=con.prepareStatement("delete from bhargav.sector_db where sector=? and db=?");
			ps6.setString(1, sec1);
			ps6.setString(2, lo2);
			int s6=ps6.executeUpdate();	
			if(s6!=0)
			{
				PreparedStatement ps7=con.prepareStatement("update bhargav.sector_no_db set no_db=no_db-"+1+" where sector=?" );
				ps7.setString(1,sec1);
				int s7=ps7.executeUpdate();		
			}
		}
%>
<% 
		if(rs1.next())
		{
%>
		<table border="2">
		<tr>
		<th colspan="2"><h3><strong>Sector</strong></h3></th>
		<th colspan="2"><h3><strong>Location1</strong></h3></th>
		<th colspan="2"><h3><strong>Location2</strong></h3></th>
		<th colspan="2"><h3><strong>Cost</strong></h3></th>
		</tr>
		<tr>
					<td colspan="2"><%=rs1.getString(1) %></td>
					<td colspan="2"><%=rs1.getString(2) %></td>
					<td colspan="2"><%=rs1.getString(3) %></td>
					<td colspan="2"><%=rs1.getString(4) %></td>
		</tr>
<%	
		while(rs1.next())
		{
%>
		
				<tr>
					<td colspan="2"><%=rs1.getString(1) %></td>
					<td colspan="2"><%=rs1.getString(2) %></td>
					<td colspan="2"><%=rs1.getString(3) %></td>
					<td colspan="2"><%=rs1.getString(4) %></td>
				</tr>
<%
		}
		}
		else
		{
%>
			<tr><td><font color=#151B54><strong>No connections are found...</strong></font></td></tr>
<%
		}
		
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>	
		</table>
	
		<form name="f1" action="disconnection" method="POST">
		<table>
			<tr>
				<th><h1><font color=#151B54 face="cursive, sans-serif" size=2><strong>Enter the sector number, details of which is required:</strong></font><input type="text" name=sec></h1></th>
			</tr>
			<tr>
				<td><input type="submit" value="details" ></td>
			</tr>
		</table>
		</form>
		</div>
	<div style="float:left;">
	<form action=disconnection1 method=post name=f2 onSubmit="return cnfrm()">
		<table>
			<tr>
				<th><font color=#151B54 face="cursive, sans-serif" size=2><strong><br><br>Enter the sector and connection details of which you wanted to disconnect:</strong></font></th>
			</tr>
			<tr>
				<td>Sector:<input type="text" name=se>Location1:<input type="text" name=loc1>Location2:<input type="text" name=loc2></td>
			</tr>
			<tr>
				<td><input type="submit" value="disconnect" ></td>
			</tr>
		</table>
	</form>
	</div>	
</body>
</html>