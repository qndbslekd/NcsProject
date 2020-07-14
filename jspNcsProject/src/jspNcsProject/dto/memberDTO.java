package jspNcsProject.dto;

public class memberDTO {
	private String id ;
	private String pw ;
	private String name ;
	private String id_number;
	private String age ;
	private String gender ;
	private String vegi_type ;
	private String profile_img ;
    private int offence_count ;
    private String offence_url ;
    private String state;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId_number() {
		return id_number;
	}
	public void setId_number(String id_number) {
		this.id_number = id_number;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getVegi_type() {
		return vegi_type;
	}
	public void setVegi_type(String vegi_type) {
		this.vegi_type = vegi_type;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public int getOffence_count() {
		return offence_count;
	}
	public void setOffence_count(int offence_count) {
		this.offence_count = offence_count;
	}
	public String getOffence_url() {
		return offence_url;
	}
	public void setOffence_url(String offence_url) {
		this.offence_url = offence_url;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "memberDTO [id=" + id + ", pw=" + pw + ", name=" + name + ", id_number=" + id_number + ", age=" + age
				+ ", gender=" + gender + ", vegi_type=" + vegi_type + ", profile_img=" + profile_img
				+ ", offence_count=" + offence_count + ", offence_url=" + offence_url + ", state=" + state + "]";
	}
}
