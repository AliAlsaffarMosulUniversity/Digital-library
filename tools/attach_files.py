import json,sys,glob
# usage: attach_files.py catalog.json out.json files1.json [files2.json ...] --folders folders1.json [...]
a=sys.argv[1:]; i=a.index("--folders")
cat=json.load(open(a[0],encoding='utf8')); out=a[1]
files=[f for p in a[2:i] for f in json.load(open(p,encoding='utf8'))]
folders=[f for p in a[i+1:] for f in json.load(open(p,encoding='utf8'))]
par={f["id"]:f["parentId"] for f in folders}
stu={it["id"] for g in cat for it in g["items"]}
def root(pid):
    seen=0
    while pid and pid not in stu and seen<12:
        pid=par.get(pid); seen+=1
    return pid if pid in stu else None
by={}
skip={"tmp","ini","db","ds_store"}
for f in files:
    if f.get("fileExtension","").lower() in skip: continue
    r=root(f.get("parentId"))
    if r: by.setdefault(r,[]).append(f)
def rank(f):
    ext=f.get("fileExtension","").lower(); size=int(f.get("fileSize") or 0)
    return (0 if ext=="pdf" else 1 if ext in("docx","doc") else 2, -size)
n=0;miss=0
for g in cat:
    for it in g["items"]:
        fs=sorted(by.get(it["id"],[]),key=rank)
        it["f"]=[[f["id"],f["title"],int(f.get("fileSize") or 0),f.get("fileExtension","").lower()] for f in fs]
        n+=len(fs); miss+=0 if fs else 1
json.dump(cat,open(out,"w",encoding="utf8"),ensure_ascii=False,separators=(',',':'))
print("files attached",n,"students without files",miss,"of",len(stu))
