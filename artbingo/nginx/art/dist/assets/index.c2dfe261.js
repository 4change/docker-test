import{d as a,u as l,k as e,p as t}from"./index.6e27ae11.js";import{d as s,I as o,_ as i,m as c,n as d,r as n,o as r,e as p,g as u,t as m,w as b,T as f,A as _,i as v}from"./vendor.8ea4918e.js";import{_ as g}from"./logo.9ad82163.js";var h;(h||(h={})).tuploadartist="/app/tuploadartist";var x=s({name:"Lottery",components:{},setup(){const s=o({visible:!1}),n=l(),r=o({name:"",contactWay:"",socialMediaAccount:""}),p=e();return i((()=>{})),{form:r,onSubmit:()=>{var l;(l=r,a.post({url:h.tuploadartist,params:l})).then((a=>{!0===a&&(s.visible=!0)}))},isDisabled:()=>r.name&&r.contactWay&&r.socialMediaAccount,state:s,goHome:()=>{n(t.home)},isMobile:c((()=>d(p.isMobile)))}}});const y={class:"upload"},U={class:"upload-banner items-center flex justify-center"},$={class:"upload-banner-main flex justify-start flex-col md:flex-row"},w=u("div",{class:"upload-logo w-full md:w-0.64 flex justify-center"},[u("img",{src:g,alt:""})],-1),M={class:"flex flex-col"},k={class:"font-semibold f-3"},A={class:"upload-main flex items-center justify-center"},j={class:"upload-main-div md:w-1/2 w-8/10"},W={class:"upload-bg fixed inset-0 z-10"},C={class:"z-20 fixed bgfixed"},z={class:"flaw-img"},D={class:"margin-tb"},H={class:"QR-img"},Q={class:"submit_suss_txt margin-tb"},R=u("div",{class:"sumit_border"},null,-1);x.render=function(a,l){const e=n("a-input"),t=n("a-form-item"),s=n("a-form"),o=n("a-button");return r(),p("div",y,[u("div",U,[u("div",$,[w,u("div",M,[u("span",k,m(a.$t("Upload.banner_txt_top")),1),u("span",null,m(a.$t("Upload.banner_txt_bot")),1)])])]),u("main",A,[u("div",j,[u(s,{model:a.form,"label-col":{span:6},"wrapper-col":{span:12}},{default:b((()=>[u(t,{label:a.$t("Upload.label_name")},{default:b((()=>[u(e,{maxlength:30,value:a.form.name,"onUpdate:value":l[1]||(l[1]=l=>a.form.name=l),placeholder:a.$t("Upload.placeholder_name")},null,8,["value","placeholder"])])),_:1},8,["label"]),u(t,{label:a.$t("Upload.label_contactWay"),help:a.$t("Upload.help_contactWay")},{default:b((()=>[u(e,{value:a.form.contactWay,"onUpdate:value":l[2]||(l[2]=l=>a.form.contactWay=l),placeholder:a.$t("Upload.placeholder_contactWay"),maxlength:40},null,8,["value","placeholder"])])),_:1},8,["label","help"]),u(t,{label:a.$t("Upload.label_socialMediaAccount"),help:a.$t("Upload.help_socialMediaAccount")},{default:b((()=>[u(e,{value:a.form.socialMediaAccount,"onUpdate:value":l[3]||(l[3]=l=>a.form.socialMediaAccount=l),placeholder:a.$t("Upload.placeholder_socialMediaAccount"),maxlength:40},null,8,["value","placeholder"])])),_:1},8,["label","help"]),u(t,{"wrapper-col":{span:12,offset:(a.isMobile,"6")}},{default:b((()=>[a.isDisabled()?(r(),p("img",{key:0,class:"upload_but",onClick:l[4]||(l[4]=l=>a.onSubmit()),src:a.$t("images.upload_button"),alt:"",srcset:""},null,8,["src"])):(r(),p("img",{key:1,class:"upload_but",src:a.$t("images.upload_button_dis"),alt:"",srcset:""},null,8,["src"]))])),_:1},8,["wrapper-col"])])),_:1},8,["model"])])]),a.state.visible?(r(),p(f,{key:0,to:"body"},[u("div",W,[u("div",C,[u("div",z,[u("img",{onClick:l[5]||(l[5]=(...l)=>a.draw&&a.draw(...l)),src:g,alt:""})]),u("div",D,m(a.$t("Upload.submit_suss")),1),u("div",H,[u("img",{onClick:l[6]||(l[6]=(...l)=>a.draw&&a.draw(...l)),src:a.$t("images.QR"),alt:""},null,8,["src"])]),u("p",Q,m(a.$t("Upload.submit_suss_txt")),1),R,u(o,{type:"primary",onClick:l[7]||(l[7]=l=>a.goHome()),class:"margin-tb",block:""},{default:b((()=>[v(m(a.$t("Upload.gohome")),1)])),_:1})])])])):_("",!0)])};export default x;
