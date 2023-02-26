for f in *.png
do
  echo "Converting $f to jpg"
  sips -s format jpeg "$f" --out ${f%.*}.jpg
done
mkdir cut
for f in *.jpg
do
  echo "Processing $f"
  sips --resampleHeight 1440 "$f"
  convert "$f" -crop 997x1440+0+0 cut/${f%.*}_2.jpg
  convert "$f" -crop 997x1440+996+0 cut/${f%.*}_1.jpg
done
echo "==============================================="
echo "  Remove unnecessary files and press [Enter]"
read -p "==============================================="
echo "zipping [聖鬥士星矢.完全版]Vol_00.cbz..."
zip -r "[聖鬥士星矢.完全版]Vol_00.cbz" cut
echo "done"

