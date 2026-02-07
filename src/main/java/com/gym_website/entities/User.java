package com.gym_website.entities;

import java.sql.Timestamp;

public class User {
	private int id;
	private String name;
	private String email;
	private String mobile;
	private String password;
	private String address;
	private String dob;
	private String gender;
	private Timestamp register_date;
	private String profile;

	/* In a Maven project, constructors, getters, and setters are essential for
	 * initializing objects, accessing or modifying data fields, and ensuring
	 * encapsulation, making the code maintainable and compatible with frameworks
	 * that rely on JavaBeans conventions (like JSP and Hibernate).
	 */

	// constructor using fields
	public User(int id, String name, String email, String mobile, String password, String address, String dob,
			String gender, Timestamp register_date) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.password = password;
		this.address = address;
		this.dob = dob;
		this.gender = gender;
		this.register_date = register_date;
	}

	
	// constructor from superclass
	
	
	
	



	public User(String name, String email, String mobile, String password, String address, String dob, String gender) {
		super();
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.password = password;
		this.address = address;
		this.dob = dob;
		this.gender = gender;
	}

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}


	// getter setter
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Timestamp getRegister_date() {
		return register_date;
	}

	public void setRegister_date(Timestamp register_date) {
		this.register_date = register_date;
	}
	
	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

}