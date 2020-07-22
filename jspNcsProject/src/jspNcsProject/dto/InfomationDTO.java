package jspNcsProject.dto;

import java.sql.Timestamp;

public class InfomationDTO {
	private String subject;
	private String content;
	private int num;
	private Timestamp reg;
	private String img;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	@Override
	public String toString() {
		return "InfomationDTO [subject=" + subject + ", content=" + content + ", num=" + num + ", reg=" + reg + ", img="
				+ img + "]";
	}
}
