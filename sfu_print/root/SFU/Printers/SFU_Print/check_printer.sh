#!/bin/bash

thePrinter="SFU_Print"

if [[ `lpstat -p "${thePrinter}"` ]]; then
  echo "Printer Installed"
else
  echo "Printer not installed. Do it"
  /SFU/Printers/$thePrinter/install_printer.sh
fi
