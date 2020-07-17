package jspNcsProject.dto;

import java.sql.Timestamp;

public class ProductDTO {
	private int num;
	private String name;
	private String ingredients;
	private String detail;
	private String product_img;
	private Timestamp reg;
	private int recommend;
	private int ref;
	private int re_level;
	private int re_step;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIngredients() {
		return ingredients;
	}
	public void setIngredients(String ingredients) {
		this.ingredients = ingredients;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
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
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	@Override
	public String toString() {
		return "ProductDTO [num=" + num + ", name=" + name + ", ingredients=" + ingredients + ", detail=" + detail
				+ ", product_img=" + product_img + ", reg=" + reg + ", recommend=" + recommend + ", ref=" + ref
				+ ", re_level=" + re_level + ", re_step=" + re_step + "]";
	}
}
