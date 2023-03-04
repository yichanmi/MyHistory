package kr.spring.main.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class CommonController {
	@RequestMapping("/common/imageUploader.do")
	@ResponseBody
	public Map<String,Object> uploadImage(MultipartFile upload,
										  HttpSession session,
										  HttpServletResponse response,
										  HttpServletRequest request)throws Exception{
		//업로드할 폴더 경로(ckeditor이용하기 위해)
		String realFolder = session.getServletContext().getRealPath("/resources/image_upload");
		
		//업로드할 파일 이름 구하기
		String org_filename = upload.getOriginalFilename();
		//파일이름을 겹치지않게 작업
		String str_filename = System.currentTimeMillis() + org_filename; //로그타입으로 반환
		
		Integer user_num = (Integer)session.getAttribute("user_num"); //겹치지 않게 작업했으므로 이 부분은 생략 가능
		
		String filepath = realFolder + "\\" + user_num + "\\" + str_filename; //문자열로 파일경로생성
		
		File f = new File(filepath);
		if(!f.exists()) {
			f.mkdirs();
		}
		upload.transferTo(f); //경로에 복사해주는 작업
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uploaded", true); //upload어뎁터.js의 제이슨문자열을 넣기
		//만들어진 경로 정보를 넘겨줌 -> 그래야 '링크'가 걸리기 때문.
		map.put("url", request.getContextPath()+"/resources/image_upload/"+user_num+"/"+str_filename);
		
		return map;
	}
}