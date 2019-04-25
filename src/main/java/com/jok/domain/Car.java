package com.jok.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @author jok
 * @date 2019/4/20 22:06
 */
@Data
public class Car implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3570864951653381301L;
	private Integer id;
	private String name;
	private Double price;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date saleDate;
}
