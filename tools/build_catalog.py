import json,sys,collections
# usage: build_catalog.py crawl.txt year out.json
M={ # parent folder id -> (dept, degree)
"1ft1O_Z1zxf1JEIiCGCFFMfIkgffaGffF":("الإدارة الصناعية","master"),"1GeyBcZaEJi7Hnz2Yn3ypHBSwpZGHZBV-":("الإدارة الصناعية","diploma"),"1YREM2Tm-0guMBm-OU2h50e2CxcROPuc7":("الإدارة الصناعية","phd"),
"1L4HXL7gRVDDT20omIdO9bWMphd7gHpUO":("العلوم المالية والمصرفية","diploma"),"1CQ2EcUmnt-WWob9t_vPEBQrmD-9R-JLE":("العلوم المالية والمصرفية","phd"),"1tvAcrQP4652OfYKKYYADSD_HT6rmW0_W":("العلوم المالية والمصرفية","master"),
"1QvefDN6mOryXyZTCRDXadLqVZB6ktkjW":("المحاسبة","phd"),"1pVslTekd0J0POERkjHNJR1bUPgYuUTWz":("المحاسبة","diploma"),"1zrGjaa4CxhxF_8PPtODtFTL7S_wivzPF":("المحاسبة","master"),
"1crPm4i8KLqLpjXgiYjvjSDrX_DN5CG_C":("التسويق","master"),
"13NpUJv-5nfaeel8c3f6phPvXZ8zWI-mz":("إدارة الأعمال","master"),"1rPyVbbi3pv57iUL_abNMV0Tdy3q9etVV":("إدارة الأعمال","phd"),"10JVHZtwqGSmjBfW4znQ_VRwJWORMtXDp":("إدارة الأعمال","diploma"),
"1iOoAsaG4bnExIKQ9ZogVJg7N-vACGcy2":("نظم المعلومات","diploma"),"1Fs_Ea6I15UzdwWCj08JeoukVMPAFGv7P":("نظم المعلومات","master"),
"1-ouJYm4YTMtBiA5PorykifSrtHNM69wP":("الاقتصاد","phd"),"1mwf5MURA-IoO5YfRwUVLfUwIBzXzIKme":("الاقتصاد","master"),"1F5V-5qrOb8itrUEJMIOvo45FB_Ih68g6":("الاقتصاد","diploma")}
t=open(sys.argv[1],encoding='utf8').read(); d=json.loads(t)
if isinstance(d,list): d=json.loads(d[0]["text"])
out=collections.defaultdict(list)
for f in d["files"]:
    k=M.get(f["parentId"])
    if k: out[(k[0],k[1])].append({"n":" ".join(f["title"].split()),"id":f["id"]})
res=[]
for (dept,deg),v in out.items():
    v.sort(key=lambda x:x["n"]); res.append({"dept":dept,"deg":deg,"year":int(sys.argv[2]),"items":v})
json.dump(res,open(sys.argv[3],"w",encoding="utf8"),ensure_ascii=False)
for r in sorted(res,key=lambda r:(r["dept"],r["deg"])): print(r["dept"],r["deg"],len(r["items"]))
print(sum(len(r["items"]) for r in res))
