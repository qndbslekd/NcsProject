package jspNcsProject.dto;

import java.sql.Timestamp;

public class FreeBoardDTO {
	private int num;
	private String title;
	private String writer;
	private String category;
	private String content;
	private Timestamp reg;
	private int read_count;
	private int recommend;
	private String fix;// "T" or "F"
	private String img;
		
	public FreeBoardDTO() {}
	
	public FreeBoardDTO(int num, String title, String writer, String category, String content, Timestamp reg,
			int read_count, int recommend, String fix, String img) {
		super();
		this.num = num;
		this.title = title;
		this.writer = writer;
		this.category = category;
		this.content = content;
		this.reg = reg;
		this.read_count = read_count;
		this.recommend = recommend;
		this.fix = fix;
		this.img = img;
	}



	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public int getRead_count() {
		return read_count;
	}
	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	
	public String getFix() {
		return fix;
	}

	public void setFix(String fix) {
		this.fix = fix;
	}

	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}

	
}
