# -*- coding:utf-8 -*-  
# This program is to generate a file list of BaiduYun (cloud) account.
# The BaiduYun db file is under C:\Program Files\Baidu\BaiduYunGuanjia\users\9c93f58d 
# You should see your username there.
# better to copy the BaiduYunCacheFileV0.db to another location.
# To run the code on Windows
# "C:\Python33\python.exe" baiduyun.py

from tkinter import *  
from tkinter.filedialog import askopenfilename  
from tkinter.filedialog import asksaveasfilename  
from tkinter.ttk import *  
import sqlite3  
  
def select_db_file():  
    db_file = askopenfilename(title="Select file BaiduYunCacheFileV0.db",filetypes=[('db', '*.db')])  
    db.set(db_file)  
  
def select_save_file():  
    save_file = asksaveasfilename(filetypes=[('File', '*.txt')])  
    f.set(save_file+".txt")  
  
def write_file(file_dict,f,item,gap=""):  
    if item=="/":  
        f.write("-" + "/" + "\n")  
        for i in file_dict["/"]:  
            f.write("|-" + "-" + i + "\n")  
            i = item + i + "/"  
            if i in file_dict:  
                write_file(file_dict,f,i, gap="|--")  
    else:  
        gap = "|  " + gap  
        for i in file_dict[item]:  
            f.write(gap + i + "\n")  
            i = item + i + "/"  
            if i in file_dict:  
                  write_file(file_dict,f,i,gap)  
  
def create_baiduyun_filelist():  
    file_dict = {}  
    conn = sqlite3.connect(db.get())  
    cursor = conn.cursor()  
    cursor.execute("select * from cache_file")  
    while True:  
        value = cursor.fetchone()  
        if not value:  
            break  
        path = value[2]  
        name = value[3]  
        size = value[4]  
        isdir = value[6]  
        if path not in file_dict:  
            file_dict[path] = []  
            file_dict[path].append(name)  
        else:  
            file_dict[path].append(name)  
    with open(f.get(),"w",encoding='utf-8') as fp:  
        write_file(file_dict,fp,"/")  
  
root = Tk()  
root.title('Tool for Baidu Net Disk')  
db_select = Button(root, text=' Select DB file ',command=select_db_file)  
db_select.grid(row=1,column=1,sticky=W,padx=(2,0),pady=(2,0))  
db = StringVar()  
db_path = Entry(root,width=80,textvariable = db)  
db_path['state'] = 'readonly'  
db_path.grid(row=1,column=2,padx=3,pady=3,sticky=W+E)  
save_path = Button(root, text='Select save file',command=select_save_file)  
save_path.grid(row=2,column=1,sticky=W,padx=(2,0),pady=(2,0))  
f = StringVar()  
file_path = Entry(root,width=80,textvariable = f)  
file_path['state'] = 'readonly'  
file_path.grid(row=2, column=2,padx=3,pady=3,sticky=W+E)  
create_btn = Button(root, text='Generate File List',command=create_baiduyun_filelist)  
create_btn.grid(row=3,column=1,columnspan=2,pady=(0,2))  
root.columnconfigure(2, weight=1)  
root.mainloop() 