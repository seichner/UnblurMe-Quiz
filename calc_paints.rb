#
# feel free to use this script as a starting point to generate your own blurred images
# (requires imagemagick)
#
ARGV.each do |orig_img_name|
  
openI_params, paint_params, max = nil

%w{openi}.each do |mode|
  p "generating images for #{orig_img_name} with #{mode} algorithm"
  
  new_img_name = "images/converted/personen/" + orig_img_name.gsub(/\.jpg/, ".#{mode}.jpg")
  if mode=="openi"
    openI_params = [30, 24, 18, 16, 13, 10, 8, 7, 6, 5, 4.5, 4, 2.5, 1.5, 1, 0.5]
    max = openI_params.length-1
  else
    paint_params = [35, 26, 21, 19, 17, 14, 13, 11, 9, 7, 6, 5, 4, 3, 2, 1]
    max = paint_params.length-1
  end


  for i in 0..max
    p "generating img #{i}"
    params = mode=="openi" ? "-morphology CloseI Disk:#{openI_params[i]}" : "-paint #{paint_params[i]}"
    
    system "convert -resize 800x600 #{params} #{orig_img_name} #{new_img_name.gsub(/\.jpg/, "_#{i}.jpg")}"
    # -resize 800x600\>
  end

  # original
  system "convert -resize 800x600 #{orig_img_name} #{new_img_name.gsub(/\.jpg/, "_#{max+1}.jpg")}"
end

end