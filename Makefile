all: replace_key isos
	packer build windows_2012_r2.json

vmware: replace_key isos
	packer build --only=vmware-iso windows_2012_r2.json

virtualbox: replace_key isos
	packer build --only=virtualbox-iso windows_2012_r2.json

isos:
	@mkdir -p iso/other
	@[ -f iso/other/ReSharper.exe ] || curl -L -o "iso/other/ReSharper.exe" -C - https://download.jetbrains.com/resharper/ReSharperAndToolsPacked01Update1.exe

replace_key:
	sed -i.bak -e 's/<Key>.*<\/Key>/<Key>'$$WIN2012_KEY'<\/Key>/' answer_files/2012_r2/Autounattend.xml
