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
cat=json.load(open(sys.argv[1],encoding='utf8'))
body=open('/home/claude/tools/body.tpl',encoding='utf8').read().replace('__CATALOG__',json.dumps(cat,ensure_ascii=False,separators=(',',':')))
open(p,'w',encoding='utf8').write(head+body)
print(len(head+body))
