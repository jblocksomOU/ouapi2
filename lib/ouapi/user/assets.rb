module OUApi	
 class User

#=== Asset methods =================================================
 	#see /lib/ouapi/json/assets.json for the asset api set

 	#---grabs the asset set from OUAPi----
 	def assets
		OUApi.assets
	end
	#-------------------------------------

	#--- create asset --------------------
	#-- Grabs the default :new asset params from the default value, and merges the user values into it. 
	#-- If not name id privided, then the name will be a random string
	#-- params  - a hash of create asset params. see the asset api set :new
	def create_asset(params={name:random_string})
		new_asset = assets[:new]
		new_asset[:params].merge!(params)
		post(new_asset)
	end
	#-------------------------------------

	def assets_list
		list = assets[:list]
		get(list)
	end

	def assets_id_by_name(name)
		response = assets_list
		asset_list = json_to_hash(response.body)
		entries = asset_list[:entries]
		id = entries.find{|item| item[:name] == name}
	end

	def assets_publish_all
		response = assets_list
		asset_list = json_to_hash(response.body)
		list = asset_list[:entries]
		ids = []
		list.each do |item|
			ids << item[:permissions][:staging_path]
		end
		files_multipublish({path:ids})
	end

#====================================================================


#========Gallery Asset Methods==========================================
	
	#----Create Gallery---------------------
	#-- creates a gallery asset and uploads the desired images
	#-- Takes a single hash
	#-- :asset - hash of parameters for the created asset. see the asset api set.
	#-- :images - an array of image parameters  [{params:{title:"testing",description:"hello"},image:{path:"test.jpg"}}]
	def create_gallery(args)
		asset = args[:asset]
		images = args[:images]

		params = {type:3}
		params.merge!(asset)

		response = create_asset(params)
		asset = json_to_hash(response.body)
		asset_id = asset[:asset]
		sleep 4
		add_gallery_images(asset_id,images)
		response
	end
	#-----------------------------------------

	#--- Upload Gallery-----------------------
	#-- uploads an image to the target gallery
	#-- :params - a hash of parameters for the target asset
	#-- :image - hash of the image upload requirements {:path (required),:name,:type}
	def upload_gallery_image(args)
		path = "/assets/add_image"
		params = {
			site:@site,
			asset:"required",
			image:"#{random_string}.JPG",
			thumb_width:"10",
			thumb_height:"10"
		}
		image = {
			path:"required",
			name:"default",
			type:"img"
		}
		params.merge!(args[:params])
		image.merge!(args[:image])
		response = package(path:path,params:params,file:image)
	end
	#-------------------------------------------

	#--- Save the gallery params, and updates the gallery info---
	#-- This does not currently works, but it should work. 
	def save_gallery_image(args)
		sleep 2
		image_id = args[:image_id] || "asset id required"
		asset = args[:asset]
		title = args[:title] || ""
		description = args[:description] || ""
		caption = args[:caption] || ""
		link = args[:link] || ""
		
		gallery_save = assets[:gallery_save]
		params = {
            asset:asset,
            images:'{"'+image_id+'":{"title":"'+title+'","description":"'+description+'","caption":"'+caption+'","link":"'+link+'"}}'
        }
        gallery_save[:params].merge!(params)
        post(gallery_save)
    end
    #-----------------------------------------------------------

    #-- Upload image--------------------------------------------
    #--- uploads an image to the target gallery-----------------
    #--- takes an asset id, and 
    def add_gallery_image(asset_id,image_data)
			
			params = {}
			params[:asset] = asset_id
			image = image_data[:image]			
			
			#upload the image
			response = upload_gallery_image(params:params,image:image)
			
			img = json_to_hash(response.body)
			img_id = img[:image]
			params[:image_id] = img_id
			params.merge!(image_data[:params])

			#save the parameters
			save_gallery_image(params)
    end

    def add_gallery_images(asset_id,images)
    	images.each do |image|
    		add_gallery_image(asset_id,image)
    	end
    end
#========================================================================


#========Gallery Form Methods==========================================
=begin
"form_email":{
			"to":"",
			"from":"",
			"subject":"",
			"body":""
		},
"form_text_element":{
			"name":"singlelabel",
			"type":"input-text",
			"required":false,
			"label":"single_label",
			"default_value":"",
			"validation":"",
			"validation_fail":"",
			"advanced":"",
			"options":"[]"
		},
"form_options":{
		"value":"",
		"selected":"",
		"text":""
		},
=end

def create_form(params={name:random_string})
		new_asset = assets[:new_form]
		new_asset[:params].merge!(params)
		#puts new_asset
		post(new_asset)
end


#======================================================================


 end
end
#gallery and form assets will need special treatment