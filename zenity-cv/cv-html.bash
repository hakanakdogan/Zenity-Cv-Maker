#!/bin/bash
html=""


css=""
export_file(){
	echo "$html" > "./index.html"
	echo "$css" > "./st.css"
}

get_font(){
font=`zenity --list \
      --checklist \
      --column "Secili" \
      --column "Font" \
      FALSE "Arial, sans-serif"   \
      FALSE "Verdana, sans-serif"   \
      FALSE "Helvetica, sans-serif"\
      FALSE "'Times New Roman', serif" \
      FALSE "'Courier New', monospace" \
      --title="Font Seçiniz (Birden fazla font seçerseniz listede seçili ilk font uygulanacaktır)" \
      --width 800\
      --height 300\
      
      
       
      `
      
IFS='|' read -r -a fontArray <<< "$font"
      

}

get_pp(){
profile_pic=`zenity --file-selection --title="Lütfen Profil Fotoğrafı Seçiniz (jpg,png,jpeg)"`

	if [ `echo "$profile_pic" | grep .jpg$` ] || [ `echo "$profile_pic" | grep .png$` ] || [ `echo "$profile_pic" | grep .jpeg$` ] 
		then
			case $? in
		 		0)
		 			IFS='/' read -r -a profile_pic_array <<< "$profile_pic"
		 			
		 			echo "$profile_pic"
		        		cp  "$profile_pic"  "./images/${profile_pic_array[-1]}";;
		        		
		        		
		 		1)
		        		echo "No file selected."
		        	        return;;
				-1)
		        		echo "An unexpected error has occurred.";;
	       
			esac
	get_bg
		 else
	  		echo "Lütfen belirtilen formatlarda bir resim seçiniz."
	  		return

	fi



}
get_bg(){
bg_pic=`zenity --file-selection --title="Lütfen Arkaplan Fotoğrafı Seçiniz (jpg,png,jpeg)"`

	if [ `echo "$bg_pic" | grep .jpg$` ] || [ `echo "$bg_pic" | grep .png$` ] || [ `echo "$bg_pic" | grep .jpeg$` ] 


		then
			case $? in
		 		0)
		 			IFS='/' read -r -a bg_pic_array <<< "$bg_pic"
		 			
		 			echo "$bg_pic"
		        		cp  "$bg_pic"  "./images/${bg_pic_array[-1]}";;
		        		
		        		
		 		1)
		        		echo "No file selected."
		        		return;;
				-1)
		        		echo "An unexpected error has occurred.";;
	       
			esac
		get_font
		 else
	  		echo "Lütfen belirtilen formatlarda bir resim seçiniz."
	  		return

	fi


}

get_education(){

education=`zenity --forms --title="Egitim Bilgileri" \
	--width 500\
	--height 150\
	--text="Lütfen Eğitim bilgilerinizi aralarında virgül olacak şekilde giriniz." \
	--separator="," \
	--add-entry="Egitim" \
	
	
`

	IFS=',' read -r -a egitimArray <<< "$education"
	edHtml=""
	for i in "${egitimArray[@]}"
	do
	   : 
	   edHtml+="
	   
	   <li class=\"list-group-item\">&#9830;  ${i}</li>
	   
	   "
	   
	   



	done
	get_pp

}
get_abilities(){

abilities=`zenity --forms --title="Yetenekler" \
	--width 500\
	--height 150\
	--text="Lütfen yeteneklerinizi aralarında virgül olacak şekilde giriniz." \
	--separator="," \
	--add-entry="Yetenek" \
	
	
`

	IFS=',' read -r -a yetenekArray <<< "$abilities"
	abHtml=""
	for i in "${yetenekArray[@]}"
	do
	   : 
	   abHtml+="
	   <span class=\"badge badge-primary badge-pill\"></span>\
	   <li class=\"list-group-item\">&#9830;  ${i}</li>
	   
	   "
	   
	   



	done
	get_experience


}
get_experience(){

experience=`zenity --forms --title="Yetenekler" \
	--width 500\
	--height 150\
	--text="Lütfen deneyimlerinizi aralarında virgül olacak şekilde giriniz." \
	--separator="," \
	--add-entry="Deneyim" \
	
	
`

	IFS=',' read -r -a deneyimArray <<< "$experience"
	expHtml=""
	for i in "${deneyimArray[@]}"
	do
	   : 
	   expHtml+="
	   <span class=\"badge badge-primary badge-pill\"></span>\
	   <li class=\"list-group-item\">&#9830;  ${i}</li>
	   
	   "
	   
	   



	done
	get_education

}

get_theme(){
theme_color=`
	zenity --color-selection --show-palette\
		--title="Lütfen header kısmında gözükecek rengi seçiniz." 
`
css="header {
  background-color: ${theme_color};
}
body {
  background: url("./images/${bg_pic_array[-1]}") no-repeat center center fixed;
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
  font-family: ${fontArray[0]};
}
.back-image {
  height:auto;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: -500;
}
.container-ct{
  margin:0;
  padding:0;
}

.back-image img {
  width: 100%;
  height: 100%;
}

.rounded-circle {
  display: flex;
  align-items: center;
  justify-content: center;
}

.profile-img {
  border-radius: 50%;
  margin-top: 2rem;
  max-height:15rem;
}
.profile-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.card-header info-text{
  text-align:center;
}
.info-text{
  text-align:center;
}
.name-text {
  color: white;
}
.align-cent{
  display:flex;
  align-items:center;
  justify-content:center;
}
.row-info{
 margin:1rem 0 1rem 0;
 border-right: 1px solid lightgrey;
 border-left: 1px solid lightgrey;
 
}
.card-info{
  padding:0;
}
.little-about-text {
  color: white;
  font-size: medium;
}"

case $? in
    0)
    	export_file;;
        
        
        
    1)
        echo "CV Eklenmedi"
	;;
    -1)
        echo "An unexpected error has occurred."
	;;
esac

}


get_user_info(){
user=`zenity --forms --title="CV Bilgileri" \
	--width 500\
	--height 350\
	--text="Lütfen CV'niz için gerekli belgeleri giriniz" \
	--separator="," \
	--add-entry="Ad" \
	--add-entry="Soyad" \
	--add-entry="Email"\
	--add-entry="Telefon"\
	--add-entry="Hakkında"\
	--add-entry="Github"\
	
`
IFS=',' read -r -a array <<< "$user"
echo "${array[*]}"

case $? in
    0)
    	get_abilities
    	
    	
    	
    	
    	
    	html="<html lang=\"tr\">
<head>
    <meta charset=\"UTF-8\">
    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Document</title>
    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\">
    <link rel=\"stylesheet\" href=\"./st.css\">
    <script src=\"https://kit.fontawesome.com/2a5eeab234.js\" crossorigin="anonymous"></script>
</head>
<body>

    <div class=\"container mt-5\">
        <header>
            <div class=\"container profile-container\" >
                <div  class=\" rounded-circle \">
                    <img class=\"img img-fluid profile-img\" src=\"./images/${profile_pic_array[-1]}\" alt=\"\">
                </div>
                <div class=\"name-container\">
                    <h1 class=\"name-text\" >${array[0]} ${array[1]} </h1>
                </div>
                
            </div>
           
        </header>
        <div class=\"container container-ct\">
            <div class=\"card\">




                <div class=\"card-body row\">
                    <div class=\"col-md-6 \" >
                        <div class=\"card\">
                            <div class=\"card-header info-text\">
                              HAKKINDA
                            </div>
                            <div class=\"card-body\">
                              
                              <p class=\"card-text\"> ${array[4]} </p>
                              
                            </div>
                          </div>
                    </div>
                    <div class=\"col-md-6 align-cent\" >
                        <i class=\"far fa-address-card fa-10x \"></i>
                    </div>
                </div>


                <div class=\"card-body row\">
                    <div class=\"col-md-6 align-cent\" >
                        <i class=\"fas fa-brain fa-10x\"></i>
                    </div>
                    <div class=\"col-md-6 \" >
                        <div class=\"card\">
                            <div class=\"card-header info-text\">
                              YETENEKLER
                            </div>
                            <div class=\"card-body\">
                              <div class=\"card-body\">
                              
                              <ul class=\"list-group\">
                              	${abHtml}
                              </ul>
                            </div>
                            </div>
                          </div>
                    </div>
                </div>

                <div class=\"card-body row\">
                    <div class=\"col-md-6 \" >
                        <div class=\"card\">
                            <div class=\"card-header info-text\">
                              DENEYİMLER
                            </div>
                            <div class=\"card-body\">
                              <div class=\"card-body\">
                              
                              <ul class=\"list-group\">
                              	${expHtml}
                              </ul>
                            </div>
                            </div>
                          </div>
                    </div>
                    <div class=\"col-md-6 align-cent\" >
                        <i class=\"fas fa-briefcase fa-10x\"></i>
                    </div>
                </div>

                <div class=\"card-body row\">
                    <div class=\"col-md-6 align-cent\" >
                        <i class=\"fas fa-university fa-10x\"></i>
                    </div>
                    <div class=\"col-md-6 \" >
                        <div class=\"card\">
                            <div class=\"card-header info-text\">
                              EĞİTİM
                            </div>
                            <div class=\"card-body\">
                              
                              <ul class=\"list-group\">
                              	${edHtml}
                              </ul>
                            </div>
                        </div>
                    </div>
                    
                    
                    <div class=\"card card-info\">
                            <div class=\"card-header info-text\">
                              İletişim
                            </div>
                            <div class=\"card-body\">
                                <div class=\"container\">
                                    <div class=\"row row-info \">
                                      <div class=\"col-3 align-cent\">
                                        <i class=\"fas fa-envelope fa-3x\"></i>
                                      </div>
                                      <div class=\"col-9 info-text\">
                                       ${array[2]}
                                      </div>
                                      
                                    </div>
                                    <div class=\"row row-info \">
                                      <div class=\"col-3 align-cent\">
                                        <i class=\"fas fa-phone fa-3x\"></i>
                                      </div>
                                      <div class=\"col-9 info-text\">
                                       ${array[3]}
                                      </div>
                                      
                                    </div>
                                    <div class=\"row row-info \">
                                      <div class=\"col-3 align-cent\">
                                        <i class=\"fab fa-github fa-3x\"></i>
                                      </div>
                                      <div class=\"col-9 info-text\">
                                       ${array[5]}
                                      </div>
                                      
                                    </div>
                                    
                                  </div>
                            </div>
                        </div>
                </div>


            </div>
        </div>
        
    </div>


    
</body>
</html>"
	
        get_theme
        
        
        ;;
    1)
        echo "CV Eklenmedi"
	;;
    -1)
        echo "An unexpected error has occurred."
	;;
esac

}

get_user_info
