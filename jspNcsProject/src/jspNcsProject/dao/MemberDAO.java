package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.MemberDTO;

public class MemberDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	//singleton
	private MemberDAO() {}
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context ctx = (Context)new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	public int insertMember(MemberDTO dto) {
		int result = 0;
		
		try {
			//11개
			String sql = "INSERT INTO MEMBER values(?,?,?,?,?,?,?,?,0,?,'활동',sysdate)";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getId());
			pstmt.setString(2,dto.getPw());
			pstmt.setString(3,dto.getName());
			pstmt.setString(4,dto.getId_number());
			pstmt.setString(5,dto.getAge());
			pstmt.setString(6,dto.getGender());
			pstmt.setString(7,dto.getVegi_type());
			pstmt.setString(8,dto.getProfile_img());
			pstmt.setString(9,null);//offence URL
			result = pstmt.executeUpdate();
			System.out.println("[Insert된 회원의 수"+result+"]");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//close block
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return result;
	}
	
	public int loginCheck(String id, String pw) {
		
		//1 > 로그인가능
		//0 > 회원가입필요
		//-1 > 강퇴당한 회원
		
		int result = 0;
		System.out.println(id);
		System.out.println(pw);
		try {
			String sql = "select * from member where id=? and pw=?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = 1;		
				if(rs.getString("state").equals("강퇴")) {
					result = -1;
				}
			}else {
				System.out.println("return FALSE");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}		
		}
		return result;
	}
	
	public String getMemberName(String id, String pw) {
		String result="";
		try {
			conn = getConnection();
			String sql = "SELECT name FROM MEMBER WHERE id=? AND pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString("name");
				System.out.println(result);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}		
		}
		return result;
	}
	//아이디 중복검사
	public boolean confirmId(String id) {
		boolean result = false;
		try {
			String sql = "select * from member where id = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
			System.out.println("confirmId "+result);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return result;
	}
	
	//활동명 중복검사
		public boolean confirmName(String name) {
			boolean result = false;
			try {
				String sql = "select * from member where name = ?";
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = true;
				}
				System.out.println("confirmId "+result);
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
				if(pstmt!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
				if(conn!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			}
			return result;
		}
	
	public int deleteMember(String id) {
		int result=0;
		try {
			conn = getConnection();
			String sql = "delete from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		System.out.println(result);
		return result;
	}
	
	public MemberDTO modifyData(String id) {
		MemberDTO result =null;
		try {
			String sql = "select * from member where id = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = new MemberDTO();
				result.setId(rs.getString("id"));
				result.setPw(rs.getString("pw"));
				result.setName(rs.getString("name"));
				result.setId_number(rs.getString("id_number"));
				result.setAge(rs.getString("age"));
				result.setGender(rs.getString("gender"));
				result.setVegi_type(rs.getString("vegi_type"));
				result.setProfile_img(rs.getString("profile_img"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
	public int updateMember(MemberDTO dto) {
		int result = 0;
		try {
			String sql = "UPDATE MEMBER SET profile_img = ? ,pw=?,name=?,vegi_type=? WHERE id =?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getProfile_img());
			pstmt.setString(2,dto.getPw());
			pstmt.setString(3,dto.getName());
			pstmt.setString(4,dto.getVegi_type());
			pstmt.setString(5,dto.getId());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		System.out.println("Update Count : "+result);
		return result;
	}
	
	public int selectAllMember() {
		int result=0;
		try {
			conn = getConnection();
			String sql = "select count(*) from member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
				System.out.println(result);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return result;
	}
	
	//search overloading
	public int selectAllMember(String option,String search) {
		int result=0;
		try {
			conn = getConnection();
			String sql = "select count(*) from member where "+option+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
				System.out.println(result);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return result;
	}
	
	//Offence member
	public int selectAllMemberByOffence() {
		int result=0;
		try {
			conn = getConnection();
			String sql = "select count(*) from member WHERE OFFENCE_URL IS NOT NULL OR OFFENCE_COUNT >0";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
				System.out.println(result);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return result;
	}
	public List getSearchMemberList(int start, int end) {
		List memberList = new ArrayList<MemberDTO>();
		try {
			conn = getConnection();
			String sql = "select id,pw,age,gender,name,regdate,offence_count,offence_url,state,r from "
					+ "(select id,pw,age,gender,name,regdate,offence_count,offence_url,state, rownum r from "
					+ "(select * from MEMBER ORDER BY OFFENCE_COUNT desc)) where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setAge(rs.getString("age"));
				dto.setGender(rs.getString("gender"));
				dto.setName(rs.getString("name"));
				dto.setRegdate(rs.getTimestamp("regdate"));
				dto.setOffence_count(rs.getInt("offence_count"));
				dto.setOffence_url(rs.getString("offence_url"));
				dto.setState(rs.getString("state"));				
				memberList.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return memberList;
	}
	
	//search overloading
	public List getSearchMemberList(int start, int end,String option,String search) {
		List memberList = new ArrayList<MemberDTO>();
		try {
			conn = getConnection();
			String sql = "select id,pw,age,gender,name,regdate,offence_count,offence_url,state,r from "
					+ "(select id,pw,age,gender,name,regdate,offence_count,offence_url,state, rownum r from "
					+ "(select * from MEMBER where "+option+" like '%"+search+"%' ORDER BY OFFENCE_COUNT desc)) where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setAge(rs.getString("age"));
				dto.setGender(rs.getString("gender"));
				dto.setName(rs.getString("name"));
				dto.setRegdate(rs.getTimestamp("regdate"));
				dto.setOffence_count(rs.getInt("offence_count"));
				dto.setOffence_url(rs.getString("offence_url"));
				dto.setState(rs.getString("state"));				
				memberList.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return memberList;
	}
	
	//offnectMember
	public List getSearchMemberListByOffence(int start, int end) {
		List memberList = new ArrayList<MemberDTO>();
		try {
			conn = getConnection();
			String sql = "select id,pw,age,gender,name,regdate,offence_count,offence_url,state,r from "
					+ "(select id,pw,age,gender,name,regdate,offence_count,offence_url,state, rownum r from "
					+ "(select * from MEMBER WHERE OFFENCE_URL IS NOT NULL OR OFFENCE_COUNT >0 ORDER BY OFFENCE_COUNT desc)) where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setAge(rs.getString("age"));
				dto.setGender(rs.getString("gender"));
				dto.setName(rs.getString("name"));
				dto.setRegdate(rs.getTimestamp("regdate"));
				dto.setOffence_count(rs.getInt("offence_count"));
				dto.setOffence_url(rs.getString("offence_url"));
				dto.setState(rs.getString("state"));				
				memberList.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return memberList;
	}
	
	//회원 강퇴
	public int kickOffMember(String id,String option) {
		int result=0;
		try {
			conn = getConnection();
			String sql ="UPDATE MEMBER SET state=? WHERE id=?";
			if(option.equals("kickOff")) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "강퇴");
				pstmt.setString(2, id);
				result = pstmt.executeUpdate();
			}else if(option.equals("kickOffCancle")) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "활동");
				pstmt.setString(2, id);
				result = pstmt.executeUpdate();
			}
			System.out.println("result"+result);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return result;
	}
	
	//회원 신고
	public void updateOffenceColumn(String offenceUrl, String member) {
		try {
			conn = getConnection();
			String sql ="update Member set offence_url = concat(concat(offence_url,','),?) where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,offenceUrl);
			pstmt.setString(2,member);
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
	}
	
	//회원신고를 위한 활동명으로 아이디 가져오기
	public String selectMemberIdForOffenceByName(String name) {
		String id = "";
		try {
			conn = getConnection();
			String sql ="select id from member where name =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,name);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return id;
	}
	//스크랩한 레시피 중 가장 많은 태그
	public String selectMostTag(String id) {
		String mostTag = null;
		List tags = null;
		List recipeNumList = null;
		
		try {
			conn = getConnection();
			
			//(내가 스크랩한 레시피의 번호들)
			String sql = "select recipe_num from scrap where scraper=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				recipeNumList = new ArrayList();
				do {
					recipeNumList.add(rs.getInt(1));
				} while(rs.next());
			}
			
			//번호가 있으면 각 레시피의 태그 가져오기
			if(recipeNumList != null) {
				tags = new ArrayList();
				sql = "select tag from recipe_board where num=?";
				pstmt = conn.prepareStatement(sql);
				for(int i = 0; i < recipeNumList.size(); i++) {
					pstmt.setInt(1, (int)recipeNumList.get(i));
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						String [] tmp = rs.getString(1).split(",");
						for(int k = 0; k < tmp.length; k++) {
							tags.add(tmp[k]);
						}
					}
				}
				
				//다 가져왔으면 중복 개수 세기
				HashMap<String, Integer> counts = new HashMap<String, Integer>();
				for(int k = 0; k < tags.size(); k++) {
					String tag = (String) tags.get(k);
					
					if(counts.containsKey(tag)) { //해쉬맵에 이미 추가된 태그라면
						counts.replace(tag, counts.get(tag)+1);	//카운트만 +1
					} else {	//없으면
						counts.put(tag,	1);	//추가
					}
				}
				//해쉬맵에서 공백인 키 제거
				counts.remove("");
				
				System.out.println(counts);
				//value값이 가장 큰 값 가져오기
				Set keySet = counts.keySet();
				Iterator it = keySet.iterator();
				List max = new ArrayList(); 
				
				if(it.hasNext()) {
					String key = (String) it.next();
					max.add(key);
					max.add(counts.get(key));
					
					while(it.hasNext()) {
						key = (String) it.next();
						if((int)max.get(1) < counts.get(key)) {
							max.set(0, key);
							max.set(1, counts.get(key));
						}
					}
				}
				
				mostTag = (String) max.get(0);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		
		return mostTag;
	}
	//신고확정, 신고취소
	public boolean updateOffence(String option,String url,String id) {
		boolean isCommit = false;
		try {
			conn = getConnection();
			String sql = "";
			if(option.equals("rollback")) {
				sql = "select OFFENCE_URL from member WHERE id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					String urlBefore = rs.getString(1);
					String[] tmp = urlBefore.split(",");
					String afterUrl = ",";
					for(int indexTmp=1;indexTmp<tmp.length;indexTmp++) {
						System.out.print(tmp[indexTmp]);
						if(!tmp[indexTmp].equals(url)) {
							System.out.print("V");
							afterUrl += tmp[indexTmp]+",";
						}
						System.out.println();
					}
					System.out.println("update Query : "+afterUrl);
					if(!afterUrl.equals(",")) {
						sql = "UPDATE MEMBER SET OFFENCE_URL = ? WHERE id = ?";
						afterUrl = afterUrl.substring(0, afterUrl.length()-1);
						System.out.println("ROLLBACK URL : "+afterUrl);
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, afterUrl);
						pstmt.setString(2, id);
						pstmt.executeUpdate();
					}else if(afterUrl.equals(",")) {
						sql = "UPDATE MEMBER SET OFFENCE_URL = null WHERE id = ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, id);
						pstmt.executeUpdate();
					}
				}
			}else if(option.equals("commit")) {
				sql = "update member set OFFENCE_COUNT = OFFENCE_COUNT+1 where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				isCommit = true;
				sql = "select OFFENCE_URL from member WHERE id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					String urlBefore = rs.getString(1);
					String[] tmp = urlBefore.split(",");
					String afterUrl = ",";
					for(int indexTmp=1;indexTmp<tmp.length;indexTmp++) {
						System.out.print(tmp[indexTmp]);
						if(!tmp[indexTmp].equals(url)) {
							System.out.print("V");
							afterUrl += tmp[indexTmp]+",";
						} 
						System.out.println();
					}
					System.out.println("update Query : "+afterUrl);
					if(!afterUrl.equals(",")) {
						sql = "UPDATE MEMBER SET OFFENCE_URL = ? WHERE id = ?";
						afterUrl = afterUrl.substring(0, afterUrl.length()-1);
						System.out.println("ROLLBACK URL : "+afterUrl);
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, afterUrl);
						pstmt.setString(2, id);
						pstmt.executeUpdate();
					}else if(afterUrl.equals(",")) {
						sql = "UPDATE MEMBER SET OFFENCE_URL = null WHERE id = ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, id);
						pstmt.executeUpdate();
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return isCommit;
	} 
}
