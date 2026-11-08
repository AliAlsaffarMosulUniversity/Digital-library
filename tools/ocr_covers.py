import json,glob,base64,re,os,subprocess,sys
D='/tmp/claude-tool-results/d43cedc9-e508-54d8-aefb-0144cfde3728/'
O='/home/claude/ocr/'
for p in sorted(glob.glob(D+'*download_file_content*')+glob.glob(D+'toolu_*.json')):
    s=open(p,encoding='utf8').read()
    if p.endswith('.json') and 'toolu_' in p:
        try:
            L=json.loads(s); s=L[0]['text']
        except Exception: continue
    m=re.search(r'"id": "([^"]+)"',s[:300])
    if not m: continue
    fid=m.group(1)
    if os.path.exists(O+fid+'.txt'): continue
    try: j=json.loads(s)
    except Exception: continue
    pdf=O+fid+'.pdf'
    
    if 'content' not in j: continue
    open(pdf,'wb').write(base64.b64decode(j['content']))
    r=subprocess.run(['pdftoppm','-r','150','-f','1','-l','1','-png',pdf,O+fid],capture_output=True)
    img=glob.glob(O+fid+'-*.png')
    if not img: print('norender',fid); continue
    os.rename(img[0],O+fid+'.png')
    t=subprocess.run(['tesseract',O+fid+'.png','-','-l','ara','--psm','6'],capture_output=True,text=True).stdout
    open(O+fid+'.txt','w',encoding='utf8').write(t)
    os.remove(pdf)
    print('ok',fid)
