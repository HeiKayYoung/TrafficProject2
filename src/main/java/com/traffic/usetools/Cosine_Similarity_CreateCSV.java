package com.traffic.usetools;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.traffic.dao.user.IDao_Cosine_Similarity_admin;
import com.traffic.dto.user.DTO_Cosine_Similarity_admin;

public class Cosine_Similarity_CreateCSV {

	private SqlSession sqlSession;
	
	public Cosine_Similarity_CreateCSV(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public boolean createCSV() {
		
		//		Cosine_Similarity_CreateCSV cosine_similarity = new Cosine_Similarity_CreateCSV(sqlSession);
		//		cosine_similarity.createCSV();
		
		// 남기문 
		// 숙소 데이터 유사도 csv 파일 생성
		try {
			String filepath = "C:\\GootTeamProject\\TravelProject\\TMSTSTAY_DATA_TABLE.csv";
			
			File file = new File(filepath);
			
			if(file.exists()) {
				file.delete();
			}
			
			BufferedWriter bw = null;
			String NEW_LINE = System.lineSeparator();
		
			bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filepath),StandardCharsets.UTF_8));
			
			IDao_Cosine_Similarity_admin cos_dao = sqlSession.getMapper(IDao_Cosine_Similarity_admin.class);
			
			List<DTO_Cosine_Similarity_admin> list = cos_dao.selectCsvData();
			
			bw.write("S_NO,S_INFO" + NEW_LINE);
			
			for (int i = 0; i < list.size(); i++) {
				String str = list.get(i).getS_no() + "," + list.get(i).getS_info().replace(",", " / ").replace("\n", " ");
				bw.write(str + NEW_LINE);
			}	
			
			bw.flush();
			bw.close();
			
			return true;
		}
		catch(Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}
	
}
