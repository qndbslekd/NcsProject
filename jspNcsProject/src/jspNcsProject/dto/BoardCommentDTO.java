package jspNcsProject.dto;

import java.sql.Timestamp;

public class BoardCommentDTO {
	private int comment_num;//고유번호
	private int freeboard_num;//댓글을 다는 해당 글번호
	private int ref;//그룹
	private int re_level;//답글 단계
	private Timestamp reg;
	private String receiver;//답글 대상
	private String writer;//작성자
	private String content;
	
	public BoardCommentDTO() {}

	public BoardCommentDTO(int comment_num, int freeboard_num, int ref, int re_level, Timestamp reg, String receiver,
			String writer, String content) {
		super();
		this.comment_num = comment_num;
		this.freeboard_num = freeboard_num;
		this.ref = ref;
		this.re_level = re_level;
		this.reg = reg;
		this.receiver = receiver;
		this.writer = writer;
		this.content = content;
	}




	public int getComment_num() {
		return comment_num;
	}

	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}

	public int getFreeboard_num() {
		return freeboard_num;
	}

	public void setFreeboard_num(int freeboard_num) {
		this.freeboard_num = freeboard_num;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRe_level() {
		return re_level;
	}

	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}


	public Timestamp getReg() {
		return reg;
	}


	public void setReg(Timestamp reg) {
		this.reg = reg;
	}


	public String getReceiver() {
		return receiver;
	}


	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}


	public String getWriter() {
		return writer;
	}


	public void setWriter(String writer) {
		this.writer = writer;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	@Override
	public String toString() {
		return "BoardCommentDTO [comment_num=" + comment_num + ", freeboard_num=" + freeboard_num + ", ref=" + ref
				+ ", re_level=" + re_level + ", reg=" + reg + ", receiver=" + receiver + ", writer=" + writer
				+ ", content=" + content + "]";
	}
	
	
	

}
