 package etc01;
 
 import java.sql.*;
 import java.util.*;
 import etc01.RegisterBean;
 
 public class MemberMgr {
	 
	 private DBConnectionMgr pool;

		public MemberMgr() {
			try {
				pool = DBConnectionMgr.getInstance();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
 
    public Vector getMemberList() {
	   Connection con = null;
	   Statement stmt = null;
       ResultSet rs = null;
       Vector vecList = new Vector();
       try {
          con = pool.getConnection();
          String strQuery = "select * from tblMember";
          stmt = con.createStatement();
          rs = stmt.executeQuery(strQuery);
		  while (rs.next()) {
             RegisterBean regBean = new RegisterBean();
		 	 regBean.setMem_id (rs.getString("id"));
			 regBean.setMem_passwd (rs.getString("passwd"));
 			 regBean.setMem_name (rs.getString("name"));
 			 regBean.setMem_num1 (rs.getString("mem_num1"));
 			 regBean.setMem_num2 (rs.getString("mem_num2"));
 			 regBean.setMem_email (rs.getString("e_mail"));
 			 regBean.setMem_phone (rs.getString("phone"));
 			 regBean.setMem_zipcode (rs.getString("zipcode"));
 			 regBean.setMem_address (rs.getString("address"));
 			 regBean.setMem_job (rs.getString("job"));
             vecList.add(regBean);
          }
       } catch (Exception ex) {
          System.out.println("Exception" + ex);
       } finally {
          if(rs!=null)   try{rs.close();}  catch(SQLException e){}
		  if(stmt!=null) try{stmt.close();}catch(SQLException e){}
	      if(con!=null) try{con.close();}catch(SQLException e){}
       }
       return vecList;
    }

 }//class