package ch10;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

public class RegisterMgrPool {
	
	private DBConnectionMgr pool = null;
	
	public RegisterMgrPool() {
 	 try{
 	   pool = DBConnectionMgr.getInstance();
 	   }catch(Exception e){
 	      System.out.println("Error : 커넥션 얻어오기 실패");
 	   }
     }//MemberMgrPool()
 
    public Vector getMemberList() {
	   Connection conn = null;
	   Statement stmt = null;
	   ResultSet rs = null;
	   Vector vecList = new Vector();	   
	   
       try {
          conn = pool.getConnection();
          String strQuery = "select * from tblRegister";
          stmt = conn.createStatement();
          rs = stmt.executeQuery(strQuery);
		  while (rs.next()) {
             RegisterBean regBean = new RegisterBean();
             regBean.setId (rs.getString("id"));
			 regBean.setPasswd (rs.getString("passwd"));
 			 regBean.setName (rs.getString("name"));
 			 regBean.setNum1 (rs.getString("num1"));
 			 regBean.setNum2 (rs.getString("num2"));
 			 regBean.setEmail (rs.getString("email"));
 			 regBean.setPhone (rs.getString("phone"));
 			 regBean.setZipcode (rs.getString("zipcode"));
 			 regBean.setAddress (rs.getString("address"));
 			 regBean.setJob (rs.getString("job"));
             vecList.add(regBean);
          }
       } catch (Exception ex) {
          System.out.println("Exception" + ex);
       } finally {
	      pool.freeConnection(conn);
       }
       return vecList;
    }
 }//class