import json,os,re,sys
q=json.load(open('/home/claude/queue.json'))
out={}
HEAD=re.compile(r'جامعة|كلية|قسم|وزارة|جمهورية|الإدارة والاقتصاد|الادارة والاقتصاد')
STOP=re.compile(r'رسالة|رسالة|اطروحة|أطروحة|بحث\s*(ال)?دبلوم|بحث دبلوم|إشراف|بإشراف|بأشراف|باشراف|بيإشراف|يإشراف|الطالب|إعداد|اعداد|مقدمة|\bمقدم')
BAD=re.compile(r'^(المقدمة|الفصل|تثبت|المحتويات|الخلاصة|المستخلص)')
for x in q:
    fid=x['f'][0][0]; p='/home/claude/ocr/'+fid+'.txt'
    if not os.path.exists(p): continue
    L=[l.strip() for l in open(p,encoding='utf8').read().split('\n') if l.strip()]
    if not L or BAD.match(L[0]): out[fid]=None; continue
    nm=set(x['n'].split())
    T=[]
    for l in L:
        if HEAD.search(l) and not T: continue
        if STOP.search(l): 
            if T: break
            else: continue
        w=l.split()
        ov=sum(1 for t in w if t in nm)
        if T and ov>=2: break
        if len(re.findall(r'[؀-ۿ]',l))<4: continue
        T.append(l)
    t=' '.join(T)
    t=re.sub(r'\s+',' ',t).strip(' :-–/|')
    out[fid]=t or None
json.dump(out,open('/home/claude/titles_ocr.json','w'),ensure_ascii=False,indent=1)
for x in q:
    fid=x['f'][0][0]
    if fid in out: print(fid[:6],x['n'][:18],'=>',out[fid])
