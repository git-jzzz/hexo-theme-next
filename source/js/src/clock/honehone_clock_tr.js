/******************************************************************************
	初期設定
******************************************************************************/


if(!isMobile()){
	//var swfUrl = "http://chabudai.sakura.ne.jp/blogparts/honehoneclock/honehone_clock_tr.swf";

var swfTitle = "honehoneclock";
	//pc端	执行
LoadBlogParts();
}


/******************************************************************************
	入力		なし
	出力		document.writeによるHTML出力
******************************************************************************/
function LoadBlogParts(){
	//var sUrl = swfUrl;
	
	var sHtml = "";
	sHtml += '<object class="clock" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="/js/src/clock/swflash.cab" width="160" height="70" id="' + swfTitle + '" align="middle">';
	sHtml += '<param name="allowScriptAccess" value="always" />';
	sHtml += '<param name="movie" value="/js/src/clock/honehone_clock_tr.swf" />';
	sHtml += '<param name="quality" value="high" />';
	sHtml += '<param name="bgcolor" value="#ffffff" />';
	sHtml += '<param name="wmode" value="transparent" />';
	sHtml += '<embed wmode="transparent" src="/js/src/clock/honehone_clock_tr.swf" quality="high" bgcolor="#ffffff" width="160" height="70" name="' + swfTitle + '" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />';
	sHtml += '</object>';
	
	document.write(sHtml);
}