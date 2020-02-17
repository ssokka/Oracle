; [필독] 오라클 클라우드 인스턴스 생성 자동 클릭 스크립트 : https://sjva.me/bbs/board.php?bo_table=tip&wr_id=251
; [참고] 오라클 클라우드 완전히 분리된 인스턴스 생성 : https://sjva.me/bbs/board.php?bo_table=tip&wr_id=253
; [링크] 오라클 클라우드 로그인 : https://www.oracle.com/cloud/sign-in.html

Opt('WinTitleMatchMode', 3)

$paused = False
HotKeySet('{PAUSE}', '_HotKey')		; 스크립트 일시중지/시작 단축키
HotKeySet('!{PAUSE}', '_HotKey')	; 스크립트 종료 단축키

$MoveTop = 1

While 1
	$x = 0
	_OCCIC('Chrome')
	_OCCIC('Whale')
	_OCCIC('Edge')
	_OCCIC('Slimjet')
	$i = 8
	While 1
		_ToolTip('Wait ' & $i)
		If $i = 0 Then ExitLoop
		Sleep(1000)
		$i -= 1
	WEnd
	$MoveTop = 0
WEnd

Func _OCCIC($_wbn)
	Local $_wbt = ' - ' & $_wbn, $_w = 825, $_h = 991

	If $_wbn = 'Edge' Then $_wbt = ''
	If $_wbn = 'Chrome' Then $x = -7
	If $_wbn = 'Whale' Then
		$_w -= 14
		$_h -= 7
	EndIf

	$_cn = 'Chrome_RenderWidgetHostHWND1'
	If $_wbn = 'Slimjet' Then $_cn = 'Slimjet_RenderWidgetHostHWND1'

	$_whd = WinGetHandle('Oracle Cloud Infrastructure' & $_wbt)
	If @error Then Return

	_Resolution()

	$_time = '[' & @YEAR & '-' & @MON & '-' & @MDAY & ' ' & @HOUR & ':' & @MIN & ':' & @SEC & ':' & @MSEC & ']'
	$_wbs = $_wbn & ' 1'
	$_text = $_wbs
	_ToolTip($_text)

	If BitAND(WinGetState($_whd), 32) Then
		$_check = WinSetState($_whd, '', @SW_RESTORE)
		$_text &= @CRLF & 'WinSetState ' & $_check
		_ToolTip($_text)
		Sleep(250)
	EndIf

	$_wpos = WinGetPos($_whd)
	If $_wpos[2] <> $_w And $_wpos[3] <> $_h Then
		$_check = WinMove($_whd, '', $x, 0, $_w, $_h, 1)
		If $_check Then $_check = 1
		$_text &= @CRLF & 'WinMove ' & $_check
		_ToolTip($_text)
		Sleep(250)
	EndIf

	$_check = WinActivate($_whd)
	If $_check Then $_check = 1
	$_text &= @CRLF & 'WinActivate ' & $_check
	_ToolTip($_text)
	Sleep(250)

	If $MoveTop Then
		$_check = 0
		$_check1 = ControlClick($_whd, '', $_cn, 'left', 1, 5, 400)
		Sleep(250)
		$_check2 = ControlSend($_whd, '', $_cn, '{HOME}')
		If $_check1 And $_check2 Then $_check = 1
		$_text &= @CRLF & 'MoveTop ' & $_check
		_ToolTip($_text)
		Sleep(500)
	EndIf

	$_check = ControlClick($_whd, '', $_cn, 'left', 1, 160, 182) ; 세션 만료 - 계속 작업
	$_text &= @CRLF & 'ContinueClick ' & $_check
	_ToolTip($_text)
	Sleep(500)

	$_check = ControlClick($_whd, '', $_cn, 'left', 1, 50, 845) ; 생성
	$_text &= @CRLF & 'CreateClick ' & $_check
	_ToolTip($_text)
	_Console($_time & ' ' & StringReplace($_text, $_wbs, $_wbs & '  ' & @TAB))
	Sleep(500)

	If $x = -7 Then $x = 0
	$x += 100
EndFunc

Func _ToolTip($_text)
	ToolTip($_text, @DesktopWidth / 2, (@DesktopHeight - 40) / 2, '', 0, 2)
EndFunc

Func _Console($_text)
	ConsoleWrite(StringReplace($_text, @CRLF, ' ') & @CRLF)
EndFunc

Func _HotKey()
	Switch @HotKeyPressed
		Case '{PAUSE}'
			$paused = Not $paused
			While $paused
				_ToolTip('Paused')
				Sleep(100)
			WEnd
		Case '!{PAUSE}'
			Exit
	EndSwitch
EndFunc

Func _Resolution()
	Local $_exe = 'dc.exe', $_w = 1280, $_h = 1024
	If @DesktopWidth = $_w And @DesktopHeight = $_h Then Return
	If Not FileExists($_exe) Then InetGet('https://github.com/ssokka/Windows/raw/master/tools/dc.exe', $_exe, 1)
	RunWait($_exe & ' -monitor="\\.\DISPLAY1" -depth=max -refresh=max -width=' & $_w & ' -height=' & $_h)
	If @DesktopWidth <> $_w Or @DesktopHeight <> $_h Then
		$_text = '확인 01. 디스플레이 해상도 = ' & $_w & ' x ' & $_h & @CRLF & @CRLF
		$_text &= '확인 02. 원격 데스크톱 (MSTSC) 접속 설정' & @CRLF & @CRLF
		$_text &= '옵션 표시 >> 디스플레이 >> 디스플레이 구성 = ' & $_w & ' x ' & $_h & ' 픽셀' & @CRLF & @CRLF
		$_text &= '확인 후 이 스크립트를 다시 시작하시기 바랍니다.' & @CRLF
		$_msg = MsgBox(0, @ScriptName, $_text)
		Exit
	EndIf
EndFunc
