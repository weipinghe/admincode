'''
Use Python to convert jpg file to pdf file
C:\Anaconda3\python img2pdf.py
pip intall img2pdf

refer https://stackoverflow.com/questions/27327513/create-pdf-from-a-list-of-images 

'''
import img2pdf
img_file = "test009.jpg"
pdf_file = "test009.pdf"
with open(pdf_file, "wb") as f:
    f.write(img2pdf.convert(img_file))
