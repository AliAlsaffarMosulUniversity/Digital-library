import json,re,sys,collections
# usage: titles.py catalog_with_files.json out.json folders1.json [...] --snips snip1.json [...]
a=sys.argv[1:]; i=a.index("--snips")
cat=json.load(open(a[0],encoding='utf8')); out=a[1]
folders=[f for p in a[2:i] for f in json.load(open(p,encoding='utf8'))]
snips=[f for p in a[i+1:] for f in json.load(open(p,encoding='utf8'))]
par={f["id"]:f["parentId"] for f in folders}
stu={it["id"] for g in cat for it in g["items"]}
def root(pid):
    n=0
    while pid and pid not in stu and n<12: pid=par.get(pid); n+=1
    return pid if pid in stu else None
KEY=r'(?:الموسومة|الموسوم|الموسومه|المعنونة|المعنون|بعنوان)'
END=r'(?:\n\s*\n|(?:قد\s+)?(?:جر[يىیﻯ]ت?|تم(?:ت)?\b|كان(?:ت)?\b|وناقشنا|ونحن|وقد\s+|قد\s+جر|جرت|اعد|أعد|تحت\s+اشراف|تحت\s+إشراف|في\s+جامعة|والمق\S*|ومقوم|وناقش\S*|والمشرف))'
pat=re.compile(KEY+r'\s*(?:بـ+|ب|:)?\s*[:：]?\s*[\(\[«"“]?\s*(.+?)\s*'+END,re.S)
def clean(t):
    t=t.replace("ـ","")
    t=re.sub(r'[‌-‏‪-‮]','',t)
    t=" ".join(t.split())
    t=re.sub(r'^[\s:"“”«»\(\[ـ\-–]+','',t)
    t=re.sub(r'[\s"“”«»\)\(\],،؛\-–]+$','',t)
    t=re.sub(r'\s+([:،])',r'\1',t)
    return t
P2=re.compile(r'عنوان\s*(?:الرسالة|الاطروحة|الأطروحة|البحث|الدراسة)\s*[:：]\s*(.+?)\s*(?:\||\n|$)')
STOP=re.compile(r'(?:رسالة|اطروحة|أطروحة|بحث)\s+(?:تقدم|مقدم)|(?:رسالة|اطروحة|أطروحة)\s*(?:ماجستير|دكتوراه)|بحث\s*دبلوم|^\s*مقدم|تقدم\s+بها|تقدم\s+به')
SKIP=re.compile(r'جامعة|كلية|قسم|وزارة|الإدارة|الادارة|العلوم|بإ?شراف|اشراف|الدكتور|الأستاذ|المدرس|1[34]\d\d|الطالب')
def cover(s,name):
    L=[" ".join(l.replace("|"," ").split()) for l in s.split("\n")]
    L=[l for l in L if l and not re.fullmatch(r'[:\-– _ـ]+',l)]
    for k,l in enumerate(L):
        if STOP.search(l):
            blk=[]
            j=k-1
            while j>=0 and len(blk)<4:
                x=L[j]
                if SKIP.search(x) and not blk: j-=1; continue
                if SKIP.search(x): break
                blk.insert(0,x); j-=1
            # drop student name line if matches folder name tokens
            toks=set(name.split())
            blk=[b for b in blk if len(toks&set(b.split()))<2]
            return " ".join(blk) if blk else None
    return None
def ok(t): return 12<=len(t)<=260 and re.search(r'[\u0600-\u06ff]',t) and not re.search(r'[\ufb50-\ufdff\ufe70-\ufeff]',t) and not re.search(r'وهي جزء|لأغراض|متطلبات|فقرات|الاستبان|اقرار|إقرار',t)
cands=collections.defaultdict(list); cover_c=collections.defaultdict(list)
nameOf={it['id']:it['n'] for g in cat for it in g['items']}
for f in snips:
    s=f.get("contentSnippet","")
    r=root(f.get("parentId"))
    if not r: continue
    for m in pat.finditer(s):
        t=clean(m.group(1))
        if ok(t): cands[r].append(t)
    for m in P2.finditer(s):
        t=clean(m.group(1))
        if ok(t): cands[r].append(t)
    if r not in cands:
        nm=nameOf.get(r,"")
        t=cover(s,nm)
        if t:
            t=clean(t)
            if ok(t): cover_c[r].append(t)
def pick(L):
    c=collections.Counter(L)
    return sorted(c,key=lambda t:(-c[t],-len(t)))[0]
got=0
for g in cat:
    for it in g["items"]:
        L=cands.get(it["id"]) or cover_c.get(it["id"])
        if L: it["t"]=pick(L); got+=1
        else: it.pop("t",None)
json.dump(cat,open(out,"w",encoding="utf8"),ensure_ascii=False,separators=(',',':'))
tot=sum(len(g["items"]) for g in cat)
print("titles",got,"of",tot)
miss=[(g["dept"],g["deg"],it["n"]) for g in cat for it in g["items"] if "t" not in it and it["f"]]
print("missing with files:",len(miss))
