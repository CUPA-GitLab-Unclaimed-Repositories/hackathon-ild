/*
Description:
This script retrieves ILD data (ISPWarehouse_OCR_ILDv001 or ISPWarehouse_CIE_ILD_v001)
from various tables for a specified SessionID and businessStream, 
and exports the results to CSV files at a user-defined location.

Inputs:
- SessionID
- business_stream 
- Output path (where the CSVs will be saved)
*/

%macro set_business_stream_options(business_stream);

%global lib_ILD QuartileSummary FacilitiesByQuartile ItemFreq 
        ItemStats TestFreq TestSummary
        businessstreamid; 

    %if &business_stream = OCR %then
        %do;
            /*OCR*/
            %let lib_ILD = ISPWarehouse_OCR_ILDv001;
            %let QuartileSummary = OCR_QuartileSummary;
            %let FacilitiesByQuartile = OCR_FacilitiesByQuartile;
            %let ItemFreq = OCR_ItemFreqBySex;
            %let ItemStats = OCR_Itemstats;
            %let TestFreq = OCR_TestFreq;
            %let TestSummary = OCR_TestSummary;
            %let businessstreamid = 01;
        %end;

    %if &business_stream = CIE %then
        %do;
            /*CIE*/
            %let lib_ILD = ISPWarehouse_CIE_ILD_v001;
            %let QuartileSummary = CIE_CountryQuartileSummary;
            %let FacilitiesByQuartile = CIE_FacilitiesBYQuartileCountry;
            %let ItemFreq = CIE_ItemFreqBySexCountry;
            %let ItemStats = CIE_ItemstatsByCountry;
            %let TestFreq = CIE_TestFreqByCountry;
            %let TestSummary = CIE_TestSummary;
            %let businessstreamid = 02;
        %end;
%mend set_business_stream_options;


%macro get_ild_data(SessionID, output_dir, UpdateType=1);

options dlcreatedir;
libname refdata "&output_dir.\&SessionID";

LIBNAME ild meta library = "&lib_ILD";

proc export data=ild.&TestSummary(where=(SessionID=&SessionID and UpdateType=&UpdateType))
    outfile="&output_dir.\&SessionID.\&TestSummary..csv"
    dbms=csv
    replace;
run;

proc export data=ild.&FacilitiesByQuartile(where=(SessionID=&SessionID and UpdateType=&UpdateType))
    outfile="&output_dir.\&SessionID.\&FacilitiesByQuartile..csv"
    dbms=csv
    replace;
run;

proc export data=ild.&ItemFreq(where=(SessionID=&SessionID and UpdateType=&UpdateType))
    outfile="&output_dir.\&SessionID.\&ItemFreq..csv"
    dbms=csv
    replace;
run;

proc export data=ild.&ItemStats(where=(SessionID=&SessionID and UpdateType=&UpdateType))
    outfile="&output_dir.\&SessionID.\&ItemStats..csv"
    dbms=csv
    replace;
run;

proc export data=ild.&QuartileSummary(where=(SessionID=&SessionID and UpdateType=&UpdateType))
    outfile="&output_dir.\&SessionID.\&QuartileSummary..csv"
    dbms=csv
    replace;
run;

proc export data=ild.&TestFreq(where=(SessionID=&SessionID and UpdateType=&UpdateType))
    outfile="&output_dir.\&SessionID.\&TestFreq..csv"
    dbms=csv
    replace;
run;

libname ild clear;
libname refdata clear;
%mend get_ild_data;

/*Inputs*/
%let business_stream = CIE;
%let SessionID=19964;
%let output_dir= \\sdsasap003\SASDATA_DEV\ARD\UserFolders\mought\ild_data;

%set_business_stream_options(&business_stream)
%get_ild_data(&SessionID, &output_dir);
