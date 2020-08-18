end_of_filename="posZ0.tif";	// These are the rest of the files that the red part will be taken from- i.e. to generate the cropped files for SR analysis. 




run("Clear Results");

requires("1.33s"); 

   dir = getDirectory("Choose root Directory ");

   count = 0;

   countFiles(dir);

   n = 0;

   setBatchMode(true);

   processFiles(dir);


   

   function countFiles(dir) {

      list = getFileList(dir);

      for (i=0; i<list.length; i++) {

  if (!startsWith(list[i],"Log")){

        if (endsWith(list[i], "/"))

              countFiles(""+dir+list[i]);

          else

              count++;

      }

  }

}

   function processFiles(dir) {

      list = getFileList(dir);

      for (i=0; i<list.length; i++) {

if (!startsWith(list[i],"Log")){

          if (endsWith(list[i], "/"))

              processFiles(""+dir+list[i]);

          else {

             showProgress(n++, count);

             path = dir+list[i];

             processFile(path);

          }

}

      }

  }



  function processFile(path) {

       if (endsWith(path, end_of_filename)) {

           open(path);



	

file= getTitle();				// image filename.tif 

root = substring(file,0,indexOf(file, ".tif"));		// image rootname



setBatchMode(true);

run("Z Project...", "projection=[Average Intensity]");
saveAs("Tiff", ""+dir+"Unmapped.tif");
close();

makeRectangle(428, 0, 856, 684);
run("Crop");

saveAs("Tiff", ""+dir+"Red_raw.tif");

close();




	

}	// End batch processing loop