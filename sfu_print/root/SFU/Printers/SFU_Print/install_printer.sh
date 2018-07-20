#!/bin/bash
printerName='SFU_Print'
dnsname='cs-pcut-staff-p.mps.sfu.ca/SFU_Print'
model='Ricoh Printer'
location='SFU'
driver="/Library/Printers/PPDs/Contents/Resources/RICOH MP C6004ex"
## Use generic 
##driver="/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Resources/Generic.ppd"
TAG='Printer_script_munki'


function opsInstall () {
  printerName="$1"
  dnsname="$2"
  model="$3"
  location="$4"
  driver="$5"

  /usr/sbin/lpadmin -p "${printerName}"   -v "smb://${dnsname}"   -E -P "${driver}"   -D "${printerName}"   -L "${location}"   -o printer-is-shared=false \
      -o OptionTray=2Cassette \
      -o LargeCapacityTray=Installed \
      -o InnerTray2=Installed \
      -o Finisher=FinAMURHY \
      -o RIPostScript=Adobe \
      -o PageSize=Letter \
      -o InputSlot=1Tray \
      -o Duplex=DuplexNoTumble \
      -o RIPaperPolicy=PromptUser \
	  -o StaplessUpperLeft \
	  -o auth-info-required=negotiate
}


function check_printer () {
  /usr/bin/lpstat -p ${1} &> /dev/null
  echo ${?}
}


################################################################################
# MAIN
################################################################################


if [ `check_printer $printerName` != "0" ]; then
  logger -t ${TAG} Installing $printerName ...
  opsInstall $printerName $dnsname "$model" "$location" "$driver"
fi

exit 0
