@echo off
REM Very basic schematron rules to validate an html according to accessibility principles
REM Example coming from http://xml.ascc.net/schematron/1.5/report1-5/schematron-report.html

set schematron_rules=exampleWai\wai.xml
set file_to_validate=exampleWai\waitest.xml

set Parse=msxsl.exe
set Open=start 

set validation_report=schematron-frame.html
set schematron_processor=schematron-report.xsl
set schematron_validator=temp.xsl
set validation_result=schematron-errors.html
set file_to_validate_in_html=schematron-out.html
set embed_xml_in_html=verbid.xsl
set and_generate=-o

del %validation_result%
del %file_to_validate_in_html%

%Parse% %schematron_rules% %schematron_processor% %and_generate% %schematron_validator%
%Parse% %file_to_validate% %schematron_validator% %and_generate% %validation_result%
%Parse% %file_to_validate% %embed_xml_in_html% %and_generate% %file_to_validate_in_html%
%Open% %validation_report%

del %schematron_validator%