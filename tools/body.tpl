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
</script>
</body>
</html>
