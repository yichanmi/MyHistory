package kr.spring.view;
import java.io.ByteArrayInputStream;
//파일을 만들면 스트림을 만드는 작업을 위해
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView {

	public DownloadView() { //jsp파일이 뷰 역할이 아닌 (클래스로)객체가 뷰 역할을 하게해주는 작업
		setContentType("application/download; charset=utf-8");
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		/*
		 * File file = (File) model.get("downloadFile"); //다운로드 파일정보
		 * 
		 * response.setContentType(getContentType()); response.setContentLength((int)
		 * file.length());
		 */
		
		//바이트 배열로 유지 하면서 처리
		byte[] file = (byte[])model.get("downloadFile");//속성명
		String filename = (String)model.get("filename"); //filename이란 속성명으로 저장
		
		
		String userAgent = request.getHeader("User-Agent");
		boolean ie = userAgent.indexOf("MSIE") > -1;
		String fileName = null;
		if (ie) {
			fileName = URLEncoder.encode(filename, "utf-8");
		} else {
			fileName = new String(filename.getBytes("utf-8"),
					"iso-8859-1");
		}
		response.setHeader("Content-Disposition", "attachment; filename=\""
				+ fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		OutputStream out = response.getOutputStream();
		/*FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} finally {
			if (fis != null)
				try {
					fis.close();
				} catch (IOException ex) {
				}
		}
		out.flush();
		*/
		
		//바이트 형태로 처리하므로 윗부분 주석
		InputStream input = new ByteArrayInputStream(file);
		IOUtils.copy(input, out);
		out.flush();
		out.close();
		input.close();
	}

}
