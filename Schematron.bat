@echo off
cls

set XsltProcessor=%SAXON_PATH%

REM use this compiler if you want an output in xml svrl 
REM set schema_compiler=iso-schematron-xslt2\iso_svrl_for_xslt2.xsl
set schema_compiler=C:\Users\Emanuele\Documents\SchematronIso\iso-schematron-xslt2\iso_schematron_text.xsl

IF [%SAXON_PATH%]==[] GOTO printrequiresaxon
IF [%1]==[] GOTO printusage

set schemaFile=%1
set fileToValidate=%2
set compile_output="compile_output.xsl"

echo Processing...
echo.

REM Generate the stylesheet from %schemaFile%

java -jar %XsltProcessor% -o:%compile_output% %schemaFile% %schema_compiler%

REM Now run the input file %fileToValidate% against the generated stylesheet %compile_output% to produce %schemaFile%%.report.xml

java -jar %XsltProcessor% -o:%schemaFile%.report.xml %fileToValidate% %compile_output%

del %compile_output%

echo.
echo Validation of %2 with %1 produced the following issues:
echo.
type %schemaFile%.report.xml

GOTO end

:printusage
echo Schematron example requires 2 params: %%1 = iso schematron file, %%2 =  xml to validate.
echo E.g. %0 input input.xml will produce input.report.xml as output
:printrequiresaxon
echo SAXON_PATH environment variable requested, found none. Please specify the absolute path of the saxon jar file, e.g. C:\Users\Emanuele\Documents\SaxonHE9-6-0-7J\saxon9he.jar 
:end

