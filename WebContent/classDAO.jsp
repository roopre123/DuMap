<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="duMap.DBUtil"%>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Du-Map</title>
</head>
<body>
<%
	String gyeongdo = null;
	String wedo = null;
	request.setCharacterEncoding("UTF-8");
	String classroom = request.getParameter("classroom");
	if(classroom != null){
		classroom = classroom.replaceAll(" ","");
		//classroom = classroom.replaceAll("\\p{Z}","");
	}
	
	Connection conn = DBUtil.getMYSQLConnection();
	
	String sql = "select wedo, gyeongdo from class where classname = ?";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, classroom);
	//System.out.println(pstmt);
	

	ResultSet rs = pstmt.executeQuery();
	
		//System.out.println(rs);
		while (rs.next()) {
			  wedo = rs.getString("wedo");
			  gyeongdo = rs.getString("gyeongdo");
			}
		response.sendRedirect("https://map.kakao.com/link/to/DU," + wedo + "," + gyeongdo);

	DBUtil.close(pstmt);
	DBUtil.close(conn);
%>
</body>
</html>