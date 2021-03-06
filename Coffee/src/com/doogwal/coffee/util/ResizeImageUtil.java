package com.doogwal.coffee.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.File;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.MultiStepRescaleOp;

public class ResizeImageUtil {
	
	//원본이미지를 크기에 맞게 다시 이미지를
	//만들어주는 메서드
	
	//1번째인자 : 원본소스경로
	//2번째인자 : 저장될경로
	//3번째인자 : width
	//4번째인자 : height
	public static boolean resize(String source, String target, int targetW, int targetH)  {
		
		Image imgSource = new ImageIcon(source).getImage(); 
 
        int oldW = imgSource.getWidth(null); 
        int oldH = imgSource.getHeight(null);
        
        int sW = 0;
        int sH = 0;
        int newW = 0;
        int newH = 0;
        int cutW = 0;
        int cutH = 0;
        	
    	newW = targetW; 
        newH = (targetW * oldH) / oldW; 
        
        
        if(targetH>newH) {
        	newW = (targetH * oldW) / oldH;
        	newH = targetH;
        	
        	sW = (newW - targetW)/2;
        }else {
        	sH = (newH - targetH)/2;
        }
        
        cutW = targetW;
        cutH = targetH;
        
       return process(source, target, sW,sH, newW, newH, cutW, cutH);
		
	}
	
	//메서드 오버로딩
	//인자 3개짜리
	public static boolean resize(String source,String target,int size) {
		
		return resize(source,target,size,size);
	}
	
	private static boolean process(String source, String target,int sW ,int sH,int newW, int newH, int cutW, int cutH) {
		
		Image imgSource = new ImageIcon(source).getImage(); 
		
		Image imgTarget = imgSource.getScaledInstance(newW, newH, Image.SCALE_SMOOTH); 

        int pixels[] = new int[newW * newH]; 
        
        try {
        
        PixelGrabber pg = new PixelGrabber(imgTarget, sW, sH, cutW, cutH, pixels, 0, cutW); 
        pg.grabPixels(); 

        for(int i = 0; i< newW * newH ; i++) {
        	
        	int onePixel = pixels[i];
        	
        	int alpha = (onePixel >> 24) & 0xff;
        	
        	if(alpha==0) {
        		pixels[i] = -1;
        	}
        }
        
        BufferedImage bi = new BufferedImage(cutW, cutH, BufferedImage.TYPE_INT_RGB); 
        bi.setRGB(0, 0, cutW, cutH, pixels, 0, cutW); 

        MultiStepRescaleOp rescale = new MultiStepRescaleOp(cutW,cutH);
        rescale.setUnsharpenMask(AdvancedResizeOp.UnsharpenMask.Soft);
        
        BufferedImage resizedImage = rescale.filter(bi, null);
        
        int dotIdx = target.lastIndexOf(".");
        
        String ext = target.substring(dotIdx+1,target.length());
                
        ImageIO.write(resizedImage, ext, new File(target));

        return true;
        
        }catch(Exception e) {
        	e.printStackTrace();
        	
        	return false;
        }
        
	}
	
}
