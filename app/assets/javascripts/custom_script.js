window.onload = function() {
 let mapViewShow = document.querySelector('.map-view-active');
 let switchBtn = document.querySelector('#switchBtn');
 let url = "https://boxgiver.com/s?view=map" && "http://lvh.me:3000/s?view=map";
 if(window.location.href == url){
    mapViewShow.nextElementSibling.setAttribute("checked","checked");
    mapViewShow.setAttribute("href","javascript:history.go(-1)");
 }
};

// ======Filter Popup js======
let filterBtn = document.querySelector('.custom-filterbar');
let filterPop = document.querySelector('.filter-popup');
let popupContent = document.querySelector('.popup-content');
let clonepopBtn = document.querySelectorAll('.clone-pop');
filterBtn.addEventListener('click', ()=> {
  popupContent.classList.remove('bounceOutUp');
  popupContent.classList.add('bounceInDown');
  filterPop.classList.add('show');
  document.body.style.overflow="hidden";
})

clonepopBtn.forEach(el=>{
	el.addEventListener('click', ()=>{
		popupContent.classList.remove('bounceInDown');
		popupContent.classList.add('bounceOutUp');
		setTimeout(()=>{
			filterPop.classList.remove('show');
		},800);
		document.body.style.overflow="unset";
	})
})
