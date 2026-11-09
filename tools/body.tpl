<!-- HOME -->
<main id="v-home">
  <div class="hero"><div class="wrap">
    <h1>أرشيف الرسائل والأطاريح<br>كلية الإدارة والاقتصاد</h1>
    <p>تصفّح أطاريح الدكتوراه ورسائل الماجستير والدبلوم العالي حسب القسم والسنة.</p>
    <form class="search" id="sf">
      <input id="q" type="search" placeholder="ابحث بعنوان الرسالة أو اسم الباحث…" autocomplete="off">
      <button type="submit">بحث</button>
    </form>
  </div></div>
  <div class="wrap">
<style>
.gal{margin:26px 0 8px}
.gal h2{margin-bottom:4px}
.gal .gsub{color:var(--mute);font-size:14px;margin:0 0 14px}
.mos{display:grid;grid-template-columns:repeat(6,1fr);grid-auto-rows:92px;gap:10px}
.mos .gi{position:relative;overflow:hidden;border-radius:var(--r);cursor:pointer;background:#dcd8cc;border:0;padding:0;box-shadow:var(--sh)}
.mos .gi:nth-child(1){grid-column:span 3;grid-row:span 3}
.mos .gi:nth-child(2){grid-column:span 3;grid-row:span 2}
.mos .gi:nth-child(3),.mos .gi:nth-child(4){grid-column:span 3;grid-row:span 1}
.mos .gi:nth-child(n+5){grid-column:span 2;grid-row:span 2}
.mos .gi img{width:100%;height:100%;object-fit:cover;display:block;transition:transform .7s cubic-bezier(.2,.7,.2,1)}
.mos .gi:hover img{transform:scale(1.08)}
.mos .gi::after{content:"";position:absolute;inset:0;background:linear-gradient(180deg,transparent 55%,rgba(10,20,40,.72));opacity:.9;transition:opacity .3s}
.mos .gi span{position:absolute;inset-inline:12px;bottom:9px;z-index:2;color:#fff;font-weight:700;font-size:14px;text-align:right;text-shadow:0 1px 6px rgba(0,0,0,.6)}
.gall-btn{margin-top:14px;background:var(--navy);color:#fff;border:0;border-radius:999px;padding:10px 22px;font:700 15px Tajawal,sans-serif;cursor:pointer;box-shadow:var(--sh)}
.gall-btn:hover{background:#0f2447}
@media(max-width:700px){.mos{grid-template-columns:repeat(2,1fr);grid-auto-rows:110px}.mos .gi:nth-child(n){grid-column:span 1;grid-row:span 1}.mos .gi:nth-child(1){grid-column:span 2;grid-row:span 2}}
.lb{position:fixed;inset:0;z-index:1000;background:radial-gradient(ellipse at center,rgba(14,26,52,.96),rgba(4,8,18,.98));display:none;flex-direction:column;align-items:center;justify-content:center;padding:18px 12px 12px;animation:lbin .35s ease}
.lb.on{display:flex}
@keyframes lbin{from{opacity:0}to{opacity:1}}
.lb .stage{position:relative;width:min(1100px,100%);flex:1;min-height:0;display:flex;align-items:center;justify-content:center}
.lb .stage img{max-width:100%;max-height:100%;object-fit:contain;border-radius:12px;box-shadow:0 20px 70px rgba(0,0,0,.6);animation:kb 9s ease-out both}
@keyframes kb{from{opacity:.0;transform:scale(1.04)}8%{opacity:1}to{opacity:1;transform:scale(1)}}
.lb .cap{color:#fff;text-align:center;margin:12px 0 8px;font-family:'Amiri',serif;font-size:22px}
.lb .cap small{display:block;font:400 13px Tajawal,sans-serif;color:#cdbb8a;margin-top:2px}
.lb .nav,.lb .x,.lb .play{position:absolute;z-index:3;background:rgba(255,255,255,.12);color:#fff;border:1px solid rgba(255,255,255,.25);width:46px;height:46px;border-radius:50%;font-size:22px;cursor:pointer;backdrop-filter:blur(6px)}
.lb .nav:hover,.lb .x:hover,.lb .play:hover{background:var(--gold)}
.lb .prev{right:6px;top:50%;margin-top:-23px}.lb .next{left:6px;top:50%;margin-top:-23px}
.lb .x{top:10px;left:10px}.lb .play{top:10px;left:64px;font-size:16px}
.lb .cnt{position:absolute;top:18px;right:16px;color:#e8dcc0;font-weight:700;z-index:3}
.lb .strip{display:flex;gap:8px;overflow-x:auto;max-width:min(1100px,100%);padding:6px 4px}
.lb .strip button{flex:0 0 auto;width:74px;height:50px;border:2px solid transparent;border-radius:8px;overflow:hidden;padding:0;opacity:.55;cursor:pointer;background:#222}
.lb .strip button.on{border-color:var(--gold);opacity:1}
.lb .strip img{width:100%;height:100%;object-fit:cover}
.lb .bar{position:absolute;bottom:0;right:0;left:0;height:3px;background:rgba(255,255,255,.1)}
.lb .bar i{display:block;height:100%;width:0;background:var(--gold)}
</style>
<section class="block gal" id="gal" style="display:none">
  <h2>جولة مصوّرة في الكلية</h2>
  <p class="gsub">لقطات من مبنى الكلية وساحاتها ومكتبتها وقاعاتها.</p>
  <div class="mos" id="mos"></div>
  <button class="gall-btn" id="galBtn" type="button">▶ افتح المعرض</button>
</section>
<div class="lb" id="lb" role="dialog" aria-modal="true" aria-label="معرض صور الكلية">
  <div class="cnt" id="lbCnt"></div>
  <button class="x" id="lbX" type="button" aria-label="إغلاق">✕</button>
  <button class="play" id="lbPlay" type="button" aria-label="تشغيل تلقائي">❚❚</button>
  <div class="stage">
    <button class="nav prev" id="lbPrev" type="button" aria-label="السابقة">›</button>
    <img id="lbImg" alt="">
    <button class="nav next" id="lbNext" type="button" aria-label="التالية">‹</button>
  </div>
  <div class="cap" id="lbCap"></div>
  <div class="strip" id="lbStrip"></div>
  <div class="bar"><i id="lbBar"></i></div>
</div>
    <div class="stats" id="stats"></div>
    <section class="block hide" id="resBlock">
      <h2>نتائج البحث</h2>
      <div class="count" id="resCount"></div>
      <div class="stu-grid" id="resGrid"></div>
    </section>
    <section class="block" id="deptBlock">
      <h2>الأقسام العلمية</h2>
      <div class="depts" id="depts"></div>
    </section>
  </div>
</main>

<main id="v-dept" class="hide">
  <div class="dhead"><div class="wrap">
    <button class="back" id="back" type="button">→ الرئيسية</button>
    <h1 id="dTitle"></h1>
    <div class="dsub" id="dSub"></div>
  </div></div>
  <div class="wrap">
    <div class="tabs" id="tabs"></div>
    <div class="filters" style="margin-top:14px">
      <input id="dq" type="search" placeholder="ابحث بالعنوان أو الاسم داخل هذا القسم…" style="flex:1;min-width:180px">
      <select id="dYear"></select>
    </div>
    <div id="years"></div>
  </div>
</main>

<main id="v-fav" class="hide">
  <div class="wrap"><section class="block">
    <h2>مفضلتي</h2>
    <div class="count">تُحفظ المفضلة في متصفحك فقط.</div>
    <div class="stu-grid" id="favGrid"></div>
  </section></div>
</main>

<footer><div class="wrap">المكتبة الرقمية – كلية الإدارة والاقتصاد، جامعة الموصل. يتم التحميل مباشرة من Google Drive.</div></footer>
<div class="toast" id="toast"></div>

<script>
const DEPTS=[
 {k:"ba",n:"إدارة الأعمال",i:"💼"},{k:"eco",n:"الاقتصاد",i:"📈"},{k:"acc",n:"المحاسبة",i:"🧾"},
 {k:"mkt",n:"التسويق",i:"🎯"},{k:"ind",n:"الإدارة الصناعية",i:"🏭"},
 {k:"fin",n:"العلوم المالية والمصرفية",i:"🏦"},{k:"mis",n:"نظم المعلومات",i:"🖥️"}];
const DEG={phd:"أطروحات الدكتوراه",master:"رسائل الماجستير",diploma:"الدبلوم العالي"};
const DEGS=["phd","master","diploma"];
const CATALOG=__CATALOG__;

const ROWS=CATALOG.flatMap(g=>{const d=DEPTS.find(x=>x.n===g.dept);return g.items.map(it=>({id:it.id,f:it.f||[],t:it.t||"",n:it.n,dept:g.dept,dk:d?d.k:"",deg:g.deg,year:g.year}))});
const $=s=>document.querySelector(s);
const esc=s=>String(s??"").replace(/[&<>"']/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]));
const norm=s=>String(s||"").toLowerCase().replace(/[ً-ْـ]/g,"").replace(/[أإآ]/g,"ا").replace(/ى/g,"ي").replace(/ة/g,"ه");
const url=id=>"https://drive.google.com/drive/folders/"+id;
let favs=[];try{favs=JSON.parse(localStorage.getItem("clib_favs2")||"[]")}catch(e){}
const saveFavs=()=>{try{localStorage.setItem("clib_favs2",JSON.stringify(favs))}catch(e){}};
function toast(m){const t=$("#toast");t.textContent=m;t.classList.add("on");clearTimeout(toast.h);toast.h=setTimeout(()=>t.classList.remove("on"),1600)}

const S={dept:null,deg:null,year:"",q:""};

function sz(b){return b>=1048576?(b/1048576).toFixed(1)+" MB":Math.max(1,Math.round(b/1024))+" KB"}
const dl=id=>"https://drive.google.com/uc?export=download&id="+id;
function stuCard(r,showCtx){
  const f=favs.includes(r.id),files=r.f||[],p=files[0];
  const main=p?`<a class="open" href="${dl(p[0])}" target="_blank" rel="noopener">⬇ تحميل</a>`:`<span class="open off">لا يوجد ملف</span>`;
  const more=files.length>1?`<details class="more"><summary>ملفات أخرى (${files.length-1})</summary>${files.slice(1).map(x=>`<a href="${dl(x[0])}" target="_blank" rel="noopener"><span>${esc(x[1])}</span><em>${esc(x[3].toUpperCase())} · ${sz(x[2])}</em></a>`).join("")}</details>`:"";
  const meta=(showCtx?esc(r.dept)+" · ":"")+esc(DEG[r.deg])+" · "+r.year+(p?" · "+esc(p[3].toUpperCase())+" "+sz(p[2]):"");
  return `<article class="stu${r.t?" has-t":""}">
    ${r.t?`<h4 class="tt">${esc(r.t)}</h4>`:""}
    <div class="who"><div class="av">${esc(r.n.charAt(0))}</div>
      <div class="si"><b>${esc(r.n)}</b><span>${meta}</span></div>
      ${main}<button class="fv" data-f="${esc(r.id)}" aria-label="مفضلة">${f?"★":"☆"}</button></div>
    ${more}
  </article>`;
}

function renderHome(){
  const yrs=[...new Set(ROWS.map(r=>r.year))].sort();
  const c=d=>ROWS.filter(r=>r.deg===d).length;
  $("#stats").innerHTML=[[ROWS.length,"إجمالي الأعمال"],[c("phd"),"أطروحة دكتوراه"],[c("master"),"رسالة ماجستير"],[c("diploma"),"دبلوم عالي"]]
    .map(x=>`<div class="stat"><b>${x[0]}</b><span>${x[1]}</span></div>`).join("");
  $("#depts").innerHTML=DEPTS.map(d=>{
    const rs=ROWS.filter(r=>r.dk===d.k);
    const chips=DEGS.map(g=>{const n=rs.filter(r=>r.deg===g).length;return n?`<span class="mini">${esc(DEG[g])} ${n}</span>`:""}).join("");
    return `<button class="dept" data-d="${d.k}"><span class="ic">${d.i}</span><b>${esc(d.n)}</b><small>${rs.length} عمل</small><div class="minis">${chips}</div></button>`}).join("");
  const q=norm(S.q).trim();
  $("#resBlock").classList.toggle("hide",!q);
  $("#deptBlock").classList.toggle("hide",!!q);
  if(q){
    const r=ROWS.filter(x=>norm(x.n+" "+x.t+" "+x.dept).includes(q));
    $("#resCount").textContent=r.length+" نتيجة";
    $("#resGrid").innerHTML=r.length?r.slice(0,150).map(x=>stuCard(x,true)).join(""):'<div class="empty">لا توجد نتائج مطابقة.</div>';
  }
}

function renderDept(){
  const d=DEPTS.find(x=>x.k===S.dept);if(!d){return}
  const rs=ROWS.filter(r=>r.dk===d.k);
  $("#dTitle").textContent="قسم "+d.n;
  $("#dSub").textContent=rs.length+" عمل في الأرشيف";
  const avail=DEGS.filter(g=>rs.some(r=>r.deg===g));
  if(!avail.includes(S.deg))S.deg=avail[0]||null;
  $("#tabs").innerHTML=DEGS.map(g=>{const n=rs.filter(r=>r.deg===g).length;
    return `<button class="tab${S.deg===g?" on":""}" data-g="${g}"${n?"":" disabled"}>${esc(DEG[g])} <span>${n}</span></button>`}).join("");
  const cur=rs.filter(r=>r.deg===S.deg);
  const ys=[...new Set(cur.map(r=>r.year))].sort((a,b)=>b-a);
  const sel=$("#dYear");
  sel.innerHTML='<option value="">كل السنوات</option>'+ys.map(y=>`<option>${y}</option>`).join("");
  if(!ys.includes(+S.year))S.year="";
  sel.value=S.year;
  const q=norm(S.q).trim();
  let html="";
  (S.year?[+S.year]:ys).forEach(y=>{
    const list=cur.filter(r=>r.year===y&&(!q||norm(r.n+" "+r.t).includes(q)));
    if(!list.length)return;
    html+=`<section class="ysec"><h3>${y} <small>${list.length}</small></h3><div class="stu-grid">${list.map(r=>stuCard(r,false)).join("")}</div></section>`;
  });
  $("#years").innerHTML=html||'<div class="empty" style="margin-top:14px">لا توجد أعمال مطابقة.</div>';
}

function renderFav(){
  const r=ROWS.filter(x=>favs.includes(x.id));
  $("#favGrid").innerHTML=r.length?r.map(x=>stuCard(x,true)).join(""):'<div class="empty">لم تضف أي عمل إلى المفضلة بعد.</div>';
}

function route(){
  const h=(location.hash||"").slice(1);
  let v="home";
  if(h.startsWith("d-")&&DEPTS.some(d=>"d-"+d.k===h)){v="dept";const k=h.slice(2);if(S.dept!==k){S.dept=k;S.deg=null;S.year="";$("#dq").value="";}}
  else if(h==="fav")v="fav";
  ["home","dept","fav"].forEach(x=>$("#v-"+x).classList.toggle("hide",x!==v));
  document.querySelectorAll("#nav button").forEach(b=>b.classList.toggle("on",b.dataset.v===v||(v==="dept"&&b.dataset.v==="home")));
  if(v==="home")renderHome();if(v==="dept"){S.q=$("#dq").value;renderDept()}if(v==="fav")renderFav();
  scrollTo({top:0});
}
$("#favN").textContent="";
function updFavN(){$("#favN").textContent=favs.length?"("+favs.length+")":""}

document.addEventListener("click",e=>{
  const f=e.target.closest("[data-f]");
  if(f){const id=f.dataset.f;favs=favs.includes(id)?favs.filter(x=>x!==id):favs.concat(id);saveFavs();updFavN();
    const h=(location.hash||"").slice(1);
    f.textContent=favs.includes(id)?"★":"☆";if(h==="fav")renderFav();return}
  const d=e.target.closest(".dept");if(d){location.hash="d-"+d.dataset.d;return}
  const t=e.target.closest(".tab");if(t&&!t.disabled){S.deg=t.dataset.g;S.year="";renderDept();return}
});
$("#nav").addEventListener("click",e=>{const b=e.target.closest("button");if(!b)return;
  if(b.dataset.v==="home"){S.q="";$("#q").value="";if(location.hash==="#home"||!location.hash)route();else location.hash="home"}
  else location.hash=b.dataset.v});
$("#back").onclick=()=>{location.hash="home"};
$("#sf").addEventListener("submit",e=>{e.preventDefault();S.q=$("#q").value;renderHome()});
$("#q").addEventListener("input",e=>{S.q=e.target.value;renderHome()});
$("#dq").addEventListener("input",e=>{S.q=e.target.value;renderDept()});
$("#dYear").addEventListener("change",e=>{S.year=e.target.value;renderDept()});
window.addEventListener("hashchange",route);
updFavN();route();

/* ===== معرض صور الكلية ===== */
(function(){
const B="https://uomosul.edu.iq/en/administrationeconomic/wp-content/uploads/sites/13/2026/01/photo_2025-12-03_";
const G=[
 ["21-21-43","المدخل الرئيس للكلية","بوابة العلم والمعرفة"],
 ["21-21-23","مكتبة الكلية","مكان هادئ للقراءة والدراسة"],
 ["21-21-49","أروقة الكلية","حركة الطلبة في ساحة الكلية"],
 ["21-21-50","مبنى الأقسام العلمية","واجهة الكلية"],
 ["21-21-26-2","حدائق الكلية","مساحات خضراء بين الأبنية"],
 ["21-21-41","رفوف المكتبة","كتب ومراجع في مختلف الاختصاصات"],
 ["21-21-52","واجهات الأقسام","الاقتصاد وإدارة التسويق"],
 ["21-22-01","قاعة الندوات","فعاليات الكلية العلمية"],
 ["21-22-07","قاعة المناقشات","مناقشة الرسائل والأطاريح"],
 ["21-22-00-2","معرض الأنشطة","نشاطات الكلية وفعالياتها"]];
const gal=document.getElementById("gal"),mos=document.getElementById("mos"),lb=document.getElementById("lb");
const img=document.getElementById("lbImg"),cap=document.getElementById("lbCap"),cnt=document.getElementById("lbCnt"),strip=document.getElementById("lbStrip"),bar=document.getElementById("lbBar"),pb=document.getElementById("lbPlay");
let ok=G.map(()=>true),cur=0,timer=null,playing=true;
const url=i=>B+G[i][0]+".jpg";
function build(){
  let loaded=0,tested=0;
  G.forEach((g,i)=>{const t=new Image();t.onload=()=>{loaded++;done()};t.onerror=()=>{ok[i]=false;done()};t.src=url(i)});
  function done(){tested++;if(tested<G.length)return;
    const L=G.map((g,i)=>i).filter(i=>ok[i]);
    if(L.length<4)return;
    gal.style.display="";
    mos.innerHTML=L.map((i,k)=>`<button class="gi" type="button" data-i="${i}" aria-label="${G[i][1]}"><img loading="lazy" src="${url(i)}" alt="${G[i][1]}"><span>${G[i][1]}</span></button>`).join("");
    strip.innerHTML=L.map(i=>`<button type="button" data-i="${i}" aria-label="${G[i][1]}"><img loading="lazy" src="${url(i)}" alt=""></button>`).join("");
    mos.onclick=e=>{const b=e.target.closest(".gi");if(b)open(+b.dataset.i)};
    strip.onclick=e=>{const b=e.target.closest("button");if(b){show(+b.dataset.i);restart()}};
  }
}
function list(){return G.map((g,i)=>i).filter(i=>ok[i])}
function show(i){cur=i;img.style.animation="none";void img.offsetWidth;img.style.animation="";img.src=url(i);img.alt=G[i][1];
  cap.innerHTML=G[i][1]+"<small>"+G[i][2]+"</small>";
  const L=list();cnt.textContent=(L.indexOf(i)+1)+" / "+L.length;
  [...strip.children].forEach(b=>{const on=+b.dataset.i===i;b.classList.toggle("on",on);if(on)b.scrollIntoView({inline:"center",block:"nearest",behavior:"smooth"})})}
function step(d){const L=list();let k=(L.indexOf(cur)+d+L.length)%L.length;show(L[k])}
function restart(){clearInterval(timer);bar.style.transition="none";bar.style.width="0";if(!playing||!lb.classList.contains("on"))return;
  requestAnimationFrame(()=>requestAnimationFrame(()=>{bar.style.transition="width 5s linear";bar.style.width="100%"}));
  timer=setInterval(()=>{step(1);restart()},5000)}
function open(i){lb.classList.add("on");document.body.style.overflow="hidden";show(i);playing=true;pb.textContent="❚❚";restart()}
function close(){lb.classList.remove("on");document.body.style.overflow="";clearInterval(timer)}
document.getElementById("galBtn").onclick=()=>open(list()[0]);
document.getElementById("lbX").onclick=close;
document.getElementById("lbNext").onclick=()=>{step(1);restart()};
document.getElementById("lbPrev").onclick=()=>{step(-1);restart()};
pb.onclick=()=>{playing=!playing;pb.textContent=playing?"❚❚":"▶";restart()};
lb.addEventListener("click",e=>{if(e.target===lb||e.target.classList.contains("stage"))close()});
document.addEventListener("keydown",e=>{if(!lb.classList.contains("on"))return;
  if(e.key==="Escape")close();else if(e.key==="ArrowLeft"){step(1);restart()}else if(e.key==="ArrowRight"){step(-1);restart()}});
let sx=null;lb.addEventListener("touchstart",e=>{sx=e.touches[0].clientX},{passive:true});
lb.addEventListener("touchend",e=>{if(sx===null)return;const d=e.changedTouches[0].clientX-sx;if(Math.abs(d)>50){step(d<0?1:-1);restart()}sx=null});
build();
})();
</script>
</body>
</html>
