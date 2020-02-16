; [오라클-클라우드] 인스턴스 생성 자동 클릭 스크립트 : https://sjva.me/bbs/board.php?bo_table=tip&wr_id=251
; 반드시 위 사이트 확인 후 실행하시기 바랍니다.
; 오라클 클라우드 로그인 : https://www.oracle.com/cloud/sign-in.html

Opt('WinTitleMatchMode', 3)

While 1
	_OCCIC(' - Chrome', -7, 0, 974, 527)
	_OCCIC(' - Whale', 0, 520, 960, 520)
	_OCCIC('', 953, 0, 974, 527) ; Microsoft Edge
	_OCCIC(' - Slimjet', 953, 520, 974, 527)
	$i = 9
	While 1
		ToolTip($i, @DesktopWidth / 2, (@DesktopHeight - 40) / 2, '', 0, 2)
		If $i = 0 Then ExitLoop
		Sleep(1000)
		$i -= 1
	WEnd
WEnd

Func _OCCIC($_wb, $_x, $_y, $_w, $_h)
	$_hd = WinGetHandle('Oracle Cloud Infrastructure' & $_wb)
	If @error Then Return
	WinSetState($_hd, '', @SW_RESTORE)
	Sleep(250)
	$_cn = 'Chrome_RenderWidgetHostHWND1'
	If $_wb = ' - Slimjet' Then $_cn = 'Slimjet_RenderWidgetHostHWND1'
	WinMove($_hd, '', $_x, $_y, $_w, $_h, 1)
	Sleep(250)
	ControlMove($_hd, '', $_cn, 0, 80, 958, 438)
	Sleep(250)
	ControlClick($_hd, '', $_cn, 'left', 1, 235, 185) ; 세션 만료 - 계속 작업
	Sleep(500)
	ControlClick($_hd, '', $_cn, 'left', 1, 50, 380) ; 생성
	Sleep(250)
EndFunc