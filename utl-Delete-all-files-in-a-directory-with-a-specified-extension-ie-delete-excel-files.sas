Delete all files in a directory with a specified exrension ie delete excel file                                                         
                                                                                                                                        
github                                                                                                                                  
https://tinyurl.com/y5o652gb                                                                                                            
https://github.com/rogerjdeangelis/utl-Delete-all-files-in-a-directory-with-a-specified-extension-ie-delete-excel-files                 
                                                                                                                                        
SAS Forum                                                                                                                               
https://tinyurl.com/y2su7lyc                                                                                                            
https://communities.sas.com/t5/SAS-Programming/Using-SAS-code-to-delete-many-different-xlsx-files-in-a-folder/m-p/587758                
                                                                                                                                        
*_                   _                                                                                                                  
(_)_ __  _ __  _   _| |_                                                                                                                
| | '_ \| '_ \| | | | __|                                                                                                               
| | | | | |_) | |_| | |_                                                                                                                
|_|_| |_| .__/ \__,_|\__|                                                                                                               
        |_|                                                                                                                             
;                                                                                                                                       
                                                                                                                                        
* ceate a directory and some xlsx extensions;                                                                                           
data _null_;                                                                                                                            
                                                                                                                                        
  * create directory;                                                                                                                   
  if _n_=0 then do;                                                                                                                     
      %let rc=%sysfunc(dosubl('                                                                                                         
         data _null_;                                                                                                                   
             rc=dcreate("xlsx","d:/");                                                                                                  
         run;quit;                                                                                                                      
     '));                                                                                                                               
  end;                                                                                                                                  
                                                                                                                                        
  file "d:/xlsx/file1.xlsx"; put "file1";                                                                                               
  file "d:/xlsx/file2.xlsx"; put "file2";                                                                                               
  file "d:/xlsx/file3.xlsx"; put "file3";                                                                                               
  file "d:/xlsx/file4.txt"; put "file4";                                                                                                
                                                                                                                                        
run;quit;                                                                                                                               
                                                                                                                                        
 d:/xlsx                                                                                                                                
   /file1.xlsx                                                                                                                          
   /file2.xlsx                                                                                                                          
   /file3.xlsx                                                                                                                          
   /file4.txt                                                                                                                           
                                                                                                                                        
*            _               _                                                                                                          
  ___  _   _| |_ _ __  _   _| |_                                                                                                        
 / _ \| | | | __| '_ \| | | | __|                                                                                                       
| (_) | |_| | |_| |_) | |_| | |_                                                                                                        
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                       
                |_|                                                                                                                     
;                                                                                                                                       
                                                                                                                                        
only file remains in directory, it does not have the xlsx extension.                                                                    
                                                                                                                                        
  d:/xlsx/file4.txt                                                                                                                     
                                                                                                                                        
*                                                                                                                                       
 _ __  _ __ ___   ___ ___  ___ ___                                                                                                      
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                                     
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                                     
| .__/|_|  \___/ \___\___||___/___/                                                                                                     
|_|                                                                                                                                     
;                                                                                                                                       
                                                                                                                                        
%macro utl_delfiles(folder,ext)/des="Delete empty folders";                                                                             
      filename filelist "&folder";                                                                                                      
      data _null_;                                                                                                                      
         dir_id = dopen('filelist');                                                                                                    
         total_members = dnum(dir_id);                                                                                                  
         do i = 1 to total_members;  /* walk through all the files in the folder */                                                     
            member_name = dread(dir_id,i);                                                                                              
            if index(lowcase(member_name),".&ext")=0 then leave;                                                                        
            file_id = mopen(dir_id,member_name,'i',0);                                                                                  
            if file_id > 0 then do; /* if the file is readable */                                                                       
               freadrc = fread(file_id);                                                                                                
                  rc = fclose(file_id);                                                                                                 
                  rc = filename('delete',member_name,,,'filelist');                                                                     
                  rc = fdelete('delete');                                                                                               
            end;                                                                                                                        
            rc = fclose(file_id);                                                                                                       
         end;                                                                                                                           
         rc = fdelete('dir_id');                                                                                                        
         rc = dclose(dir_id);                                                                                                           
      run;                                                                                                                              
%mend utl_delfiles;                                                                                                                     
                                                                                                                                        
%utl_delfiles(d:/xlsx,xlsx);                                                                                                            
                                                                                                                                        
                                                                                                                                        
                                                                                                                                        
                                                                                                                                        
                                                                                                                                        
