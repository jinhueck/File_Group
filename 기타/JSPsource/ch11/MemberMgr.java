package ch11;

import java.sql.*;


public class MemberMgr
{
	private DBConnectionMgr pool;

	public MemberMgr(){
		try{
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e){
			System.out.println("Error : 커넥션 연결 실패");			
		}
	}

	public boolean passCheck(String cust_id, String cust_pass){
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginCon = false;
        try {
            con = pool.getConnection();
			String query = "select count(*) from tblMember where id = ? and pass = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1,cust_id);
            pstmt.setString(2,cust_pass);
            rs = pstmt.executeQuery();
			rs.next();
            if(rs.getInt(1)>0) loginCon =true;
        }catch(Exception ex) {
            System.out.println("Exception" + ex);
        }finally{
             pool.freeConnection(con,pstmt,rs);
        }
        return loginCon;
    }
}
