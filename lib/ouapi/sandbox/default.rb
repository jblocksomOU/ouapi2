module OUApi	
class Sandbox

	def default_zip
		data = {params:{},file:{path:"#{OUApi.gem_root}/dev/autosandbox.zip"}}
	end

	def default_directory_settings
		data = [
      {path:"/",_publish:"skip:xsl,xslt,xml,_properties.inc",template_group:"Content"},
			{path:"/about", _ox_ftp_image_root:"/_resources/images/about",template_group:"Content"},
			{path:"/academics", _ox_ftp_image_root:"/_resources/images/academics",template_group:"Content"},
			{path:"/admissions", _ox_ftp_image_root:"/_resources/images/admissions"},
			{path:"/athletics", _ox_ftp_image_root:"/_resources/images/athletics",template_group:"Content"},
			{path:"/faculty", _ox_ftp_image_root:"/_resources/images/faculty",template_group:"Faculty"},
			{path:"/welcome", _ox_ftp_image_root:"/_resources/images/welcome",template_group:"Content"},
			{path:"/news",template_group:"News"}
		]
	end

	def default_feeds
		data = [
			{ path: "/_resources/rss/news.xml", title: "GU News Feed", description: "GU News"}, 
      { path: "/_resources/rss/events.xml", title: "GU Events Feed" , description: "GU Events"}, 
      { path: "/_resources/rss/announcements.xml", title: "GU Announcements Feed" , description: "GU Announcements"},
      { path: "/_resources/rss/crisis.xml", title: "Crisis Feed", description: "Imporant alerts that will affect all students."}
		]
	end

	def default_users
	end

	def default_groups
		data = [
			{name:"navigation",user:["zz-omni"]}
		]
	end

	def default_snippet_categories
		data = [
			{category:"Text Snippets"},
			{category:"Form Snippets"},
			{category:"Table Snippets"},
			{category:"Images"},
		]
	end

	def dafault_snippets
		data = [
			{name:"Privacy Statement", category:"Text Snippets", path:"/_resources/snippets/privacy.inc",description:"Privacy statement using directory variables and date stamp."},
			{name:"Address Horizontal", category:"Text Snippets", path:"/_resources/snippets/gu_address_horizontal.inc",description:""},
			{name:"Address Vertical", category:"Text Snippets", path:"/_resources/snippets/gu_address_vertical.inc",description:""},
			{name:"Event Form", category:"Form Snippets", path:"/_resources/snippets/form.inc",description:""},
			{name:"Tuition Table", category:"Table Snippets", path:"/_resources/snippets/centered_table.inc",description:""},
			{name:"Left Aligned Image with Caption", category:"Images", path:"/_resources/snippets/image_caption_left.inc",description:"Image with Caption"},
			{name:"Right Aligned Image with Caption", category:"Images", path:"/_resources/snippets/image_caption_right.inc",description:"Image with Caption"}
		]
	end

	def default_templategroups
		data = [
			{name:"News",template:["6_article.tcf","7_archive.tcf"]},
            {name:"Content",template:["2_htaccess.tcf","4_onecolumn.tcf","5_twocolumn.tcf","3_redirect.tcf"]},
            {name:"Faculty",template:["8_faculty.tcf"]},
            {name:"Developers",template:["0_newtemplate.tcf"]},
            {name:"testing6",template:["3_redirect.tcf","1_section.tcf"]}
		]
	end

	def default_gallery
		data = [
			{
				asset:{
					name:"Gallena University Banner",
					description:"Rotating Banner for the school's landing pages."
				},
				images:[
					{params:{title:"Students",caption:"Students at Paerson Library"},image:{path:"#{OUApi.gem_root}/dev/images/1_large.jpg"}},
          {params:{title:"Class",caption:"Class 2012"},image:{path:"#{OUApi.gem_root}/dev/images/2_large.jpg"}},
          {params:{title:"Merker",caption:"Merker Computer Science Building"},image:{path:"#{OUApi.gem_root}/dev/images/3_large.jpg"}}
				]
			}
		]
	end

	def default_assets
		data = [{
					type:"1", 
					name:"Example Text Asset",description: "This text asset is designed to show how text assets function in the WYSIWYG editor.",
                	tags: "Example",
                	content:"This text is an asset, and can be reused across the site. The text cannot be changed in the WYSIWYG, and is centrally managed under the Assets tab. Updating this asset once will change all instances of it across the site!"
                }] 	
	end

	def default_news_items
		 data = [
              {
              tcf_value_0:"New Greek Fraternity Joins GU",
              tcf_value_1:"Mario Ianniello",
              tcf_value_2:["Gallena","GU","Why Choose Gallena","Undergraduate","Athletics","Sports","Basketball","Football","Volleyball","Tennis"],
              tcf_value_3:"Lambda Omicron Lambda is the newest fraternity chapter to join Gallena University. Their values make them the perfect fit to the Greek system.",
              tcf_value_4:"This fall, the Lambda Omicron Lambda fraternity joins the 12chapter Interfraternity Council here at Gallena University. Founded in 1923, the fraternitys values stem in philanthropy, leadership, and strength of character. In a current press release, Frank Remy, President of the chapter, stated, This is a really exciting time for Lambda Omicron Lambda. We look forward to providing a quality fraternity that contributes to the community and Gallena University. Youll see us out in force this coming fall quarter!",
              tcf_value_5:false,
              tcf_value_6:true,
              tcf_value_7:"/_resources/images/news/media_production.jpg",
              tcf_value_8:"/_resources/images/news/thumbs/media_production.jpg",
              tcf_value_9:"/_resources/rss/news.xml",
              tcf_value_10:"new_greek_fraternity",
              path:"/news",
              template:"6_article.tcf"
              },               
               {
              tcf_value_0:"Concert in Student Union Next Month",
              tcf_value_1:"Jeremy Rex",
              tcf_value_2:["Gallena"],
              tcf_value_3:"The Student Association of Gallena University will be hosting a concert next month. Tickets go on sale next week and support local charities and foundations in Gallena.",
              tcf_value_4:"The Student Association of Gallena University has announced a concert for incoming students next month in the Student Union, but dont expect to find out who it is just yet. This is a concert you dont want to miss, says Brittany Rillman, President of the Student Association. We want to keep this a surprise, but I will say that you wont regret coming out for this amazing band! They will rock your socks off! Tickets will go on sale next week, with all the proceeds going towards local charities and foundations in Gallena.",
              tcf_value_5:false,
              tcf_value_6:true,
              tcf_value_7:"/_resources/images/news/student_activity.jpg",
              tcf_value_8:"/_resources/images/news/thumbs/student_activity.jpg",
              tcf_value_9:"/_resources/rss/events.xml",
              tcf_value_10:"concert",
              path:"/news",
              template:"6_article.tcf"
              },
             
               {
              tcf_value_0:"Alumni Campus Fair",
              tcf_value_1:"Michael Monina",
              tcf_value_2:["Gallena"],       
              tcf_value_3:"Gallena Alumni and their families are invited to attend the annual Alumni Campus Fair on January 1 ",
              tcf_value_4:"A pancake breakfast hosted by the Alumni Association will kick off at 9:00 AM in the Campus Dining Center. The Alumni Association Annual General Meeting immediately after, at 10:00 AM in the Campus Hall room. All alumni attending will have the chance to win one of two 100 gift certificates to the campus bookstore. The Campus Fair festivities will begin at 10:00 am until 5:00 pm and will include an alumni booth in Mac Hall where children can have their picture taken as a memento of the day's festivities.",
              tcf_value_5:false,
              tcf_value_6:true,
              tcf_value_7:"/_resources/images/news/college_fair_lg.jpg",
              tcf_value_8:"/_resources/images/news/thumbs/college_fair_thumb.jpg",
              tcf_value_9:"/_resources/rss/events.xml",
              tcf_value_10:"alumni_fair",
              path:"/news",
              template:"6_article.tcf"
              },

               {
              tcf_value_0:"Gallena Wins First Football Game of Season",
              tcf_value_1:"Mario Ianniello",
              tcf_value_2:["Gallena"],
              tcf_value_3:"Gallena University's football wins first game of the year.",
              tcf_value_4:"The Gallena gophers looked solid in both offense and defense in their 24-21 Victory ast week at the Gallena University Stadium between the Gallena Gophers and the University of Walnut Creek.",
              tcf_value_5:false,
              tcf_value_6:true,
              tcf_value_7:"/_resources/images/news/american_football.jpg",
              tcf_value_8:"/_resources/images/news/thumbs/american_football.jpg",
              tcf_value_9:"/_resources/rss/news.xml",
              tcf_value_10:"first_fb_game",
              path:"/news",
              template:"6_article.tcf"
              },

              {
              tcf_value_0:"Gallena University Celebrates 100 Years!",
              tcf_value_1:"Michael Monina",
              tcf_value_2:["Gallena"],
              tcf_value_3:"Gallena University celebrates 100 years of academic excellence. Gallena University is a private University which was founded in 1914. The 310-acre campus is located in Gallena, a diverse community in a culturally rich region of Northern California. The University enrolls 3,634 students in twenty-five undergraduate and seven graduate programs with approximately 350 full-time faculty and staff. Gallena University celebrates 100 years of academic excellence.",
              tcf_value_4:"The University community is committed to basic education and shuns educational fads of the moment. The student body represents all 50 states and many foreign countries. Originally the university was a private institution founded by local mining concerns for those who were unable to travel to San Francisco for college. The original mining company Gallena Mining LLC gave way to a private board of trustees in 1912 and has been a private university ever since. The University is a national model for positive change and academic excellence. Our focus is on quantitative performance and results.",              
              tcf_value_5:false,
              tcf_value_6:true,
              tcf_value_7:"/_resources/images/news/student_activity.jpg",
              tcf_value_8:"/_resources/images/news/thumbs/student_activity.jpg",
              tcf_value_9:"/_resources/rss/news.xml",
              tcf_value_10:"gallena_celebrates",
              path:"/news",
              template:"6_article.tcf"
              },

              {
              tcf_value_0:"Study Abroad Informational Meeting",
              tcf_value_1:"Jeremy Rex",
              tcf_value_2:["Gallena"],
              tcf_value_3:"All Gallena Friends & Family are welcome to join us on campus for our annual semester abroad discussion.",
              tcf_value_4:"This is a great new way to learn about expanding your international education through hands on experience in a foreign country.  ",              
              tcf_value_5:false,
              tcf_value_6:true,
              tcf_value_7:"/_resources/images/news/adult_education.jpg",
              tcf_value_8:"/_resources/images/news/thumbs/adult_education.jpg",
              tcf_value_9:"/_resources/rss/announcements.xml",
              tcf_value_10:"study_abroad",
              path:"/news",
              template:"6_article.tcf"
              },
          ]
	end

  def default_auxsites
        response = @user.view_site({})
        site = json_to_hash(response.body)
        http_root = site[:http_root]
        ftp_server = site[:address]
        ftp_username = site[:username]
        ftp_password = site[:password]
        ftp_root = site[:ftp_root]
        people_root = "_resources/images/misc/faces" 
        buildings_root = "_resources/images/misc/buildings"
        video_root = "_resources/videos"

    data = [
        {name:"Images of People",address: ftp_server ,ftp_type:0,username: ftp_username ,password: ftp_password ,ftp_root:"#{ftp_root}/#{people_root}",http_root:"#{http_root}#{people_root}/",site:"ignore"},
        {name:"Images of Buildings",address: ftp_server ,ftp_type:0,username: ftp_username ,password: ftp_password ,ftp_root:"#{ftp_root}/#{buildings_root}",http_root:"#{http_root}#{buildings_root}/",site:"ignore"},
        {name:"Videos",address: ftp_server ,ftp_type:0,username: ftp_username ,password: ftp_password ,ftp_root:"#{ftp_root}/#{video_root}",http_root:"#{http_root}#{video_root}/",site:"ignore"}
    ]
  end

  def default_findandreplace
    gallery_id = @gallery_id || "1234"
    
    response = @user.view_site({})
    site = json_to_hash(response.body)
    uuid = site[:uuid]
    puts uuid

    data = [
      {srchstr:"6587",rplcstr:gallery_id,paths:"/"},
      {srchstr:"9f51b2ea-4ced-4d10-b0af-009b397b32e0",rplcstr:uuid,paths:["/_resources/php"]}
    ]
  end

end
end

