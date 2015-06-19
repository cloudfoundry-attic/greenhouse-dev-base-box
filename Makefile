vmware:
	@mkdir -p iso/other
	@[ -f iso/other/ReSharper.exe ] || curl -L -o "iso/other/ReSharper.exe" -C - https://download.jetbrains.com/resharper/ReSharperAndToolsPacked02Update1.exe
	sed -i.bak -e 's/WIN2012_KEY/'$$WIN2012_KEY'/' answer_files/2012_r2/Autounattend.xml
	packer build --only=vmware-iso windows_2012_r2.json

virtualbox:
	@mkdir -p iso/other
	@[ -f iso/other/ReSharper.exe ] || curl -L -o "iso/other/ReSharper.exe" -C - https://download.jetbrains.com/resharper/ReSharperAndToolsPacked02Update1.exe
	sed -i.bak -e 's/WIN2012_KEY/'$$WIN2012_KEY'/' answer_files/2012_r2/Autounattend.xml
	packer build --only=virtualbox-iso windows_2012_r2.json

replace_key:
	sed -i.bak -e 's/WIN2012_KEY/'$$WIN2012_KEY'/' answer_files/2012_r2/Autounattend.xml
