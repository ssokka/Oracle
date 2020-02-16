; [오라클-클라우드] 인스턴스 생성 자동 클릭 스크립트 : https://sjva.me/bbs/board.php?bo_table=tip&wr_id=251
; 반드시 위 사이트 확인 후 실행하시기 바랍니다.
; 오라클 클라우드 로그인 : https://www.oracle.com/cloud/sign-in.html

#include <Misc.au3>

Opt('WinTitleMatchMode', 3)

AdlibRegister('_EXIT', 1)

While 1

	$exe = 'dc.exe'
	If Not FileExists($exe) Then InetGet('https://github.com/ssokka/Windows/raw/master/tools/dc.exe', $exe, 1)
	RunWait($exe & ' -monitor="\\.\DISPLAY1" -depth=max -refresh=max -width=1280 -height=1024')

	$x = 0
	_OCCIC('Chrome')
	_OCCIC('Whale')
	_OCCIC('') ; Microsoft Edge
	_OCCIC('Slimjet')

	$i = 8
	While 1
		ToolTip($i, 15, 928, '', 0, 2)
		If $i = 0 Then ExitLoop
		Sleep(1000)
		$i -= 1
	WEnd

WEnd

Func _OCCIC($_wb)

	Local $_w = 825, $_h = 991

	If $_wb = 'Chrome' Then $x = -7
	If $_wb = 'Whale' Then
		$_w -= 14
		$_h -= 7
	EndIf

	$_cn = 'Chrome_RenderWidgetHostHWND1'
	If $_wb = 'Slimjet' Then $_cn = 'Slimjet_RenderWidgetHostHWND1'
	If $_wb Then $_wb = ' - ' & $_wb
	$_hd = WinGetHandle('Oracle Cloud Infrastructure' & $_wb)
	If @error Then Return

	WinSetState($_hd, '', @SW_RESTORE)
	Sleep(250)
	WinMove($_hd, '', $x, 0, $_w, $_h, 1)
	Sleep(250)
	WinActivate($_hd)
	Sleep(250)
	ControlClick($_hd, '', $_cn, 'left', 1, 5, 400)
	Sleep(250)
	ControlSend($_hd, '', $_cn, '{HOME}')
	Sleep(250)
	ControlMove($_hd, '', $_cn, 0, 81, 809, 902)
	Sleep(250)
	ControlClick($_hd, '', $_cn, 'left', 1, 160, 182) ; 세션 만료 - 계속 작업
	Sleep(500)
	ControlClick($_hd, '', $_cn, 'left', 1, 50, 845) ; 생성
	Sleep(500)

	If $x = -7 Then $x = 0
	$x += 100

EndFunc

Func _EXIT()
	If _IsPressed('13', DllOpen('user32.dll')) Then Exit
EndFunc