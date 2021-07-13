%Read all files and generate model
basePath = "C:\Users\MSI\Documents\Visual Studio 2017\Projects\DataSorter\DataSorter\Dataset\Fundus";
outputPath = "C:\Users\MSI\Documents\Visual Studio 2017\Projects\DataSorter\Evaluation\SFS\";
Files = dir(basePath);
for k=1:length(Files)
   if(strlength(Files(k).name) > 5)
        E = imread(basePath +"\"+ Files(k).name);
        Zn = SFS(E);
        Zn = reshape(Zn,128*128,1);
        fileID = fopen(outputPath +Files(k).name+ ".txt",'w');
        for i=1:128*128
             fprintf(fileID,'%f\n',Zn(i));
        end
       
        fclose(fileID);      
   end
end
%--------------------------------------------------------------------------








