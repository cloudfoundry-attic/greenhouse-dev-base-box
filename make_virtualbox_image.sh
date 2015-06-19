#!/usr/bin/env bash
set -e

: ${WIN2012_KEY:?"Must provide a product key for Windows 2012 Server R2"}

if [[ "$(which openssl)" = "" ]]
then
  echo "Must have openssl on PATH for sha1 checks."
  exit -1
fi

if [[ "$(which packer)" = "" ]]
then
  echo "Must have packer on PATH for building vagrant box."
  exit -1
fi

if [[ ! "$(packer version)" = "Packer v0.7.5" ]]
then
  echo "Only known to work with packer version 0.7.5"
  exit -1
fi

if [[ ! -f iso/other/en_visual_studio_ultimate_2013_with_update_4_x86_dvd_5935075.iso ]];
then
  echo "Visual Studio ISO doesn't exist in iso/other. Please copy it in there if you haven't done so. Thank you!"
  exit -1
fi


echo "Verifying Visual Studio ISO..."
if [[ ! "$(openssl sha iso/other/en_visual_studio_ultimate_2013_with_update_4_x86_dvd_5935075.iso  | awk '{print $2}')" = "62c2f1500924e7b1402b6fcb9350ae9e0af444f9" ]]
then
  echo "Unexpected sha for Visual Studio ISO. Check that you put it in iso/other and that it is the correct version. Thanks!"
  exit -1
fi

git co answer_files/2012_r2/
echo "Cleaning up Resharper artifacts..."
rm iso/other/ReSharper.exe
mkdir -p iso/other
echo "Downloading Resharper..."
[ -f iso/other/ReSharper.exe ] || curl -L -o "iso/other/ReSharper.exe" -C - "https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2015.1.1.exe"

echo "Verifying Resharper..."
if [[ ! "$(openssl sha iso/other/ReSharper.exe | awk '{print $2}')" = "dbf27641178ebee455b3aaacc6c001e522ebfda7" ]]
then
  echo "Unexpected sha for Resharper. Check that it correctly downloaded and the link in this script isn't stale."
  exit -1
fi

echo "Splicing in key..."
sed -i.bak -e 's/WIN2012_KEY/'$WIN2012_KEY'/' answer_files/2012_r2/Autounattend.xml
echo "Starting packer..."
packer build --only=virtualbox-iso windows_2012_r2.json
