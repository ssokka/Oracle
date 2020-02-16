; ### 스크립트 실행 환경
; 추천 : VMWare, Hyper-V, VirtualBox 등 가상 환경
; OS : Windows 10
; 디스플레이 해상도 : 1920 x 1080 (클릭 좌표를 최대한 동일하게 고정 시키기 위함)
;
; ### AutoIt 다운로드 및 설치
; AutoIt 홈페이지 : https://www.autoitscript.com/site/
; 01. AutoIt 다운로드 : https://www.autoitscript.com/cgi-bin/getfile.pl?autoit3/autoit-v3-setup.exe
; 02. AutoIt 설치
;     옵션 지정 : Use x86 tools by default, Edit the script
; 03. AutoIt Script Editor 다운로드 : https://www.autoitscript.com/cgi-bin/getfile.pl?../autoit3/scite/download/SciTE4AutoIt3.exe
; 04. AutoIt Script Editor 설치
; 반드시 AutoIt 설치 완료 후 AutoIt Script Editor를 설치하시기 바랍니다.
;
; ### 지원 웹 브라우저 설치 / 설정 / 실행
; 해당 스크립트는 동시 최대 4개의 인스턴스 생성을 자동 클릭합니다.
; 로그인 쿠키로 인하여 동일한 웹 브라우저에서 여러 개의 창으로 실행할 경우 최근 접속한 계정으로 접속 정보가 모두 바뀝니다.
; 01. 지원 웹 브라우저 설치
;     인스턴스 1개 생성 시 : 지원 웹 브라우저 아무거나 1개 설치
;     인스턴스 2개 생성 시 : 지원 웹 브라우저 아무거나 2개 설치
;     인스턴스 3개 생성 시 : 지원 웹 브라우저 아무거나 3개 설치
;     인스턴스 4개 생성 시 : 지원 웹 브라우저 4개 모두 설치
;     크롬 : https://www.google.com/intl/ko/chrome/
;     웨일 : http://update.whale.naver.net/downloads/installers/WhaleSetup.exe
;     [NEW] 엣지 : https://www.microsoft.com/en-us/edge?form=MY01BQ&OCID=MY01BKQ
;     Slimjet : https://www.slimjet.com/kr/postdl.php?version=win64&type=exe
;     파이어 폭스 : 제외, 'Control Class'가 존재하지 않습니다.
; 02. 지원 웹 브라우저 설정
;     크롬 : 초기 상태
;     웨일 : 사이드바 숨기기
;     [NEW] 엣지 : 초기 상태
;     Slimjet : 애드 블로커 해제, 북마크바 표시 - 항상 숨김
;     좌표 클릭을 최대한 정확하게 하기 위해 지원 웹 브라우저의 툴바, 북마크바 등이 표시되어 있다면 숨김으로 설정하시기 바랍니다.
; 03. 지원 웹 브라우저 실행
;     인스턴스 1개 생성 시 : 지원 웹 브라우저 아무거나 1개 실행
;     인스턴스 2개 생성 시 : 지원 웹 브라우저 아무거나 2개 실행
;     인스턴스 3개 생성 시 : 지원 웹 브라우저 아무거나 3개 실행
;     인스턴스 4개 생성 시 : 지원 웹 브라우저 4개 모두 실행
; 지원 웹 브라우저 4개 실행으로 인스턴스 4개 생성 시 CPU가 높게 나타난다면 지원 웹 브라우저를 최대 3개까지만 실행하시기 바랍니다.
; 추천 : 지원 웹 브라우저 2개 실행, 인스턴스 2개 생성
;
; ### 스크립트 실행 전 인스턴스 생성 설정
; 01. 오라클 클라우드 로그인 : https://www.oracle.com/cloud/sign-in.html
; 02. 오라클 클라우드 메인 좌상단 상병 메뉴 >> 컴퓨트 >> 인스턴스 >> (왼쪽 메뉴) 구획 선택 >> 인스턴스 생성
; 상세 인스턴스 생성 설정 참고 : https://sjva.me/bbs/board.php?bo_table=tip&wr_id=253
; 선택 01. 인스턴스 이름 지정
; 선택 02. 운영체제 또는 이미지 소스 선택 = Canonical Ubuntu 18.04 Minimal
; 선택 03. 구성, 네트워크 및 스토리지 옵션 표시 >> 사용자정의 부트 볼륨 크기(GB) = 50 또는 100
; 필수 01. 컴퓨터에서 SSH 키 파일(.pub) 선택 >> ssh.pub
; 필수 02. 최종 인스턴스 생성 설정 확인
;
; ### 스크립트 실행 및 중단
; 01. 스크립트 파일 다운로드 : https://sjva.me/bbs/download.php?bo_table=tip&wr_id=250&no=0
; 02. 스크립트 에디터 실행 : 시작 >> AutoIt v3 >> SciTE
; 03. 스크립트 파일 열기 : Oracle-Cloud-Instance-Create-AutoClick.au3
; 스크립트 실행 메뉴 (단축키) : SciTE >> Tools >> Go (F5)
; 스크립트 중단 메뉴 (단축키) : SciTE >> Tools >> Stop Executing (Ctrl + Pause Break)
; 스크립트 단축키는 스크립트 창이 활성화된 상태에서 입력해야 합니다.

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