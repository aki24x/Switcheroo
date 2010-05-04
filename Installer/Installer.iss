; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Switcheroo"
#define MyAppVerName "Switcheroo v0.4.1"
#define MyAppPublisher "James Sulak"
#define MyAppURL "http://bitbucket.org/jasulak/switcheroo"
#define MyAppExeName "switcheroo.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{A5AF4C34-70A7-4D3B-BA18-E49C0AEEA5E6}
AppName={#MyAppName}
AppVerName={#MyAppVerName}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked
Name: startupfolder; Description: Startup with windows

[Files]
Source: B:\workspace\idoswitcher\IDOSwitcher\IDOSwitcher\bin\Release\switcheroo.exe; DestDir: {app}; Flags: ignoreversion
Source: B:\workspace\idoswitcher\IDOSwitcher\IDOSwitcher\bin\Release\ManagedWinapi.dll; DestDir: {app}; Flags: ignoreversion
Source: B:\workspace\idoswitcher\IDOSwitcher\IDOSwitcher\bin\Release\switcheroo.exe.config; DestDir: {app}; Flags: ignoreversion
Source: B:\workspace\idoswitcher\IDOSwitcher\readme.txt; DestDir: {app}; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: {group}\{#MyAppName}; Filename: {app}\{#MyAppExeName}
Name: {group}\{cm:UninstallProgram,{#MyAppName}}; Filename: {uninstallexe}
Name: {group}\Readme; Filename: {app}\readme.txt
Name: {commondesktop}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: desktopicon
Name: {commonstartup}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: startupfolder

[Run]
Filename: {app}\{#MyAppExeName}; Description: {cm:LaunchProgram,{#MyAppName}}; Flags: nowait postinstall skipifsilent
Filename: {app}\README.TXT; Description: View the README file; Flags: postinstall shellexec skipifsilent

[Code]
const

// The following was stolen from the Witty Twitter installer.
// http://code.google.com/p/wittytwitter/source/browse/trunk/Witty/Installer/Installer.iss

//Use these values for .NET 3.5
dotnetRedistURL = 'http://www.microsoft.com/downloads/details.aspx?FamilyID=333325FD-AE52-4E35-B531-508D977D32A6';
dotnetRegKey = 'SOFTWARE\Microsoft\Net Framework Setup\NDP\v3.5';
version = '3.5';

function InitializeSetup(): Boolean;
var
    ErrorCode: Integer;
    NetFrameWorkInstalled : Boolean;
    InstallDotNetResponse : Boolean;
begin
	NetFrameWorkInstalled := RegKeyExists(HKLM,dotnetRegKey);
	if NetFrameWorkInstalled =true then
	   begin
		  Result := true;
	   end
	else
	   begin
		  InstallDotNetResponse := MsgBox('This setup requires version ' + version + ' of the .NET Framework. Please download and install the .NET Framework and run this setup again. Do you want to download the framework now?',mbConfirmation,MB_YESNO)= idYes;
		  if InstallDotNetResponse =false then
			begin
			  Result:=false;
			end
		  else
			begin
			  Result:=false;
			  ShellExec('open',dotnetRedistURL,'','',SW_SHOWNORMAL,ewNoWait,ErrorCode);
			end;
	   end;
	end;
