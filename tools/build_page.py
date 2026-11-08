import json,sys
# usage: build_page.py catalog_with_files.json  (rebuilds /home/claude/library/index.html in place)
p='/home/claude/library/index.html'
h=open(p,encoding='utf8').read()
head=h[:h.index('<!-- HOME -->')]
extra='''
.stu{flex-wrap:wrap}
.open.off{background:var(--bg);color:var(--mute);cursor:default}
.more{flex-basis:100%;border-top:1px dashed var(--line);padding-top:6px;font-size:13.5px}
.more summary{cursor:pointer;color:var(--navy);font-weight:700}
.more a{display:flex;justify-content:space-between;gap:10px;padding:5px 2px;color:var(--ink);text-decoration:none;border-bottom:1px solid var(--bg)}
.more a:hover{background:var(--gold-soft)}
.more a span{overflow:hidden;text-overflow:ellipsis;white-space:nowrap;min-width:0}
.more a em{color:var(--mute);font-style:normal;white-space:nowrap}
'''
if '.more{flex-basis' not in head: head=head.replace('footer{margin-top:50px',extra+'footer{margin-top:50px',1)
css2='''
.stu-grid{grid-template-columns:repeat(auto-fill,minmax(min(100%,400px),1fr));align-items:start}
.stu{display:block;position:relative;padding:14px 16px 12px;border-inline-start:4px solid var(--gold)}
.stu .tt{font-family:'Amiri','Tajawal',serif;font-weight:700;font-size:19px;line-height:1.9;color:var(--navy);margin:0 0 10px;text-wrap:balance}
.stu.has-t{background:linear-gradient(180deg,#fffdf7 0%,#fff 60%)}
.who{display:flex;align-items:center;gap:10px}
.who .si b{font-size:14.5px;font-weight:700;color:var(--ink)}
.who .si b::before{content:"الباحث: ";color:var(--mute);font-weight:400}
.who .av{width:32px;height:32px;font-size:14px}
.stu .more{margin-top:8px}
'''
if 'Amiri' not in head:
    head=head.replace('<link href="https://fonts.googleapis.com/css2?family=Tajawal','<link href="https://fonts.googleapis.com/css2?family=Amiri:wght@400;700&display=swap" rel="stylesheet">\n<link href="https://fonts.googleapis.com/css2?family=Tajawal',1)
if '.stu .tt{' not in head: head=head.replace('footer{margin-top:50px',css2+'footer{margin-top:50px',1)
cat=json.load(open(sys.argv[1],encoding='utf8'))
body=open('/home/claude/tools/body.tpl',encoding='utf8').read().replace('__CATALOG__',json.dumps(cat,ensure_ascii=False,separators=(',',':')))
open(p,'w',encoding='utf8').write(head+body)
print(len(head+body))
