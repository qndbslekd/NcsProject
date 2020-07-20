package jspNcsProject.dto;

import java.sql.Timestamp;

public class RecipeDTO {
	private int num; // 글번호 
	private int recipeStep; // 조리단계
	private String recipeName; //  레시피 이름
	private String thumbnail; // 썸네일 파일명
	private String writer; // 작성자
	private Timestamp reg; // 작성시간
	private String vegiType; // 베지테리언타입
	private int cookingTime; // 요리시간 
	private String difficulty; // 난이도
	private int cal; // 칼로리
	private int quantity;	// 분량
	private String ingredients; // 재료들 
	private double rating; // 평점
	private String tag; // 태그

	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getRecipeStep() {
		return recipeStep;
	}
	public void setRecipeStep(int recipeStep) {
		this.recipeStep = recipeStep;
	}
	public String getRecipeName() {
		return recipeName;
	}
	public void setRecipeName(String recipeName) {
		this.recipeName = recipeName;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getVegiType() {
		return vegiType;
	}
	public void setVegiType(String vegiType) {
		this.vegiType = vegiType;
	}
	public int getCookingTime() {
		return cookingTime;
	}
	public void setCookingTime(int cookingTime) {
		this.cookingTime = cookingTime;
	}
	public String getDifficulty() {
		return difficulty;
	}
	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}
	public int getCal() {
		return cal;
	}
	public void setCal(int cal) {
		this.cal = cal;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getIngredients() {
		return ingredients;
	}
	public void setIngredients(String ingredients) {
		this.ingredients = ingredients;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}


	
}
