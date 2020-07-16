package jspNcsProject.dto;

public class InfomationDTO {
	private String subject;
	private String content;
	private int num;
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
	@Override
	public String toString() {
		return "InfomationDTO [subject=" + subject + ", content=" + content + ", num=" + num + "]";
	}
	
}
